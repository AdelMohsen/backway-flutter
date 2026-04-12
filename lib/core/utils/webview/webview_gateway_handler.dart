import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

/// Enum for gateway response status
enum GatewayStatus {
  success,
  failed,
  pending,
  unknown,
}

/// Gateway response data class
class GatewayResponse {
  final GatewayStatus status;
  final String? message;
  final Map<String, dynamic>? data;
  final String? transactionId;
  final String url;

  const GatewayResponse({
    required this.status,
    required this.url,
    this.message,
    this.data,
    this.transactionId,
  });

  bool get isSuccess => status == GatewayStatus.success;
  bool get isFailed => status == GatewayStatus.failed;
  bool get isPending => status == GatewayStatus.pending;
  bool get isUnknown => status == GatewayStatus.unknown;

  @override
  String toString() {
    return 'GatewayResponse(status: $status, message: $message, url: $url)';
  }
}

/// Functional gateway handler utility
class WebviewGatewayHandler {
  /// Parse gateway response from URL
  static GatewayResponse parseFromUrl(String url) {
    final uri = Uri.parse(url);
    
    // Check for success/failure in URL path or query parameters
    final path = uri.path.toLowerCase();
    final queryParams = uri.queryParameters;
    
    GatewayStatus status = GatewayStatus.unknown;
    String? message;
    String? transactionId;
    Map<String, dynamic>? data;

    // **PRIORITY**: Backend specific success parameter handling
    if (queryParams.containsKey('success')) {
      final successValue = queryParams['success'];
      if (successValue == '1') {
        status = GatewayStatus.success;
      } else if (successValue == '0') {
        status = GatewayStatus.failed;
      }
    }
    
    // Extract message from status parameter (URL decoded)
    if (queryParams.containsKey('status')) {
      message = Uri.decodeComponent(queryParams['status']!);
    }
    
    // If no success parameter found, fall back to other URL patterns
    if (status == GatewayStatus.unknown) {
      if (path.contains('success') || queryParams.containsKey('success')) {
        status = GatewayStatus.success;
      } else if (path.contains('fail') || path.contains('error') || queryParams.containsKey('error')) {
        status = GatewayStatus.failed;
      } else if (path.contains('pending') || queryParams.containsKey('pending')) {
        status = GatewayStatus.pending;
      }
    }
    
    // Set default message if not found in status parameter
    if (message == null) {
      message = queryParams['message'] ?? queryParams['error'] ?? _getDefaultMessage(status);
    }

    // Extract transaction ID
    transactionId = queryParams['transaction_id'] ?? 
                   queryParams['txn_id'] ?? 
                   queryParams['payment_id'] ??
                   queryParams['reference'] ??
                   queryParams['ref'];

    // Create data map from query parameters
    if (queryParams.isNotEmpty) {
      data = Map<String, dynamic>.from(queryParams);
    }

    return GatewayResponse(
      status: status,
      url: url,
      message: message,
      data: data,
      transactionId: transactionId,
    );
  }

  /// Parse gateway response from page body content
  static Future<GatewayResponse> parseFromPageContent(
    WebViewController controller,
    String url,
  ) async {
    try {
      // Execute JavaScript to get page content and parse various formats
      final pageContent = await controller.runJavaScriptReturningResult(
        '''
        (function() {
          var body = document.body;
          var content = {
            text: body.innerText || body.textContent || '',
            html: body.innerHTML || '',
            title: document.title || '',
            url: window.location.href || ''
          };
          
          var indicators = {
            success: false,
            failed: false,
            pending: false,
            message: '',
            transactionId: '',
            rawData: null
          };
          
          var text = content.text.toLowerCase();
          var html = content.html.toLowerCase();
          
          // Try to parse JSON from body content first
          try {
            var jsonMatch = content.text.match(/\\{[^}]*\\}/);
            if (jsonMatch) {
              var jsonData = JSON.parse(jsonMatch[0]);
              indicators.rawData = jsonData;
              
              // Check JSON fields for status
              if (jsonData.status) {
                var status = jsonData.status.toString().toLowerCase();
                if (status.includes('success') || status.includes('completed') || 
                    status.includes('approved') || status === 'true' || status === '1') {
                  indicators.success = true;
                } else if (status.includes('failed') || status.includes('error') || 
                          status.includes('declined') || status === 'false' || status === '0') {
                  indicators.failed = true;
                } else if (status.includes('pending') || status.includes('processing')) {
                  indicators.pending = true;
                }
              }
              
              // Extract message from JSON
              indicators.message = jsonData.message || jsonData.msg || jsonData.description || '';
              
              // Extract transaction ID from JSON
              indicators.transactionId = jsonData.transaction_id || jsonData.txn_id || 
                                       jsonData.payment_id || jsonData.reference || '';
            }
          } catch (e) {
            // JSON parsing failed, continue with text analysis
          }
          
          // If no JSON found or parsed, analyze text content
          if (!indicators.success && !indicators.failed && !indicators.pending) {
            // Check for success indicators in text
            if (text.includes('success') || text.includes('completed') || 
                text.includes('approved') || text.includes('paid') ||
                html.includes('success') || html.includes('approved')) {
              indicators.success = true;
            }
            
            // Check for failure indicators in text
            else if (text.includes('failed') || text.includes('error') || 
                    text.includes('declined') || text.includes('cancelled') ||
                    text.includes('rejected') || html.includes('error') || 
                    html.includes('failed')) {
              indicators.failed = true;
            }
            
            // Check for pending indicators in text
            else if (text.includes('pending') || text.includes('processing') ||
                    text.includes('waiting') || html.includes('pending')) {
              indicators.pending = true;
            }
          }
          
          // Extract message from HTML elements if not found in JSON
          if (!indicators.message) {
            var messageSelectors = [
              '.message', '.alert', '.notification', '.status-message', 
              '#message', '.response-message', '.payment-message',
              '.success-message', '.error-message', '.status',
              '[data-message]', '.result-message'
            ];
            
            for (var selector of messageSelectors) {
              var elements = document.querySelectorAll(selector);
              if (elements.length > 0) {
                indicators.message = elements[0].innerText || elements[0].textContent || '';
                if (indicators.message) break;
              }
            }
          }
          
          // Extract transaction ID from text if not found in JSON
          if (!indicators.transactionId) {
            var txnPatterns = [
              /(?:transaction|txn|payment)\\s*(?:id|ref|reference|number)\\s*:?\\s*([a-zA-Z0-9-_]+)/i,
              /(?:ref|reference)\\s*:?\\s*([a-zA-Z0-9-_]+)/i,
              /(?:order|invoice)\\s*(?:id|number)\\s*:?\\s*([a-zA-Z0-9-_]+)/i
            ];
            
            for (var pattern of txnPatterns) {
              var match = content.text.match(pattern);
              if (match && match[1]) {
                indicators.transactionId = match[1];
                break;
              }
            }
          }
          
          // Look for hidden form data or meta tags
          var hiddenInputs = document.querySelectorAll('input[type="hidden"]');
          var metaData = {};
          for (var input of hiddenInputs) {
            if (input.name && input.value) {
              metaData[input.name] = input.value;
            }
          }
          
          var metaTags = document.querySelectorAll('meta[name*="payment"], meta[name*="transaction"], meta[name*="status"]');
          for (var meta of metaTags) {
            if (meta.name && meta.content) {
              metaData[meta.name] = meta.content;
            }
          }
          
          return JSON.stringify({
            content: content,
            indicators: indicators,
            metaData: metaData
          });
        })();
        ''',
      );

      // Parse the JavaScript result
      final resultMap = jsonDecode(pageContent.toString());
      final indicators = resultMap['indicators'];
      
      GatewayStatus status = GatewayStatus.unknown;
      if (indicators['success'] == true) {
        status = GatewayStatus.success;
      } else if (indicators['failed'] == true) {
        status = GatewayStatus.failed;
      } else if (indicators['pending'] == true) {
        status = GatewayStatus.pending;
      }

      return GatewayResponse(
        status: status,
        url: url,
        message: indicators['message']?.toString().isNotEmpty == true 
            ? indicators['message'] 
            : _getDefaultMessage(status),
        transactionId: indicators['transactionId']?.toString().isNotEmpty == true 
            ? indicators['transactionId'] 
            : null,
        data: resultMap['content'],
      );
    } catch (e) {
      // Fallback to URL parsing if JavaScript execution fails
      return parseFromUrl(url);
    }
  }

  /// Get default message based on status
  static String _getDefaultMessage(GatewayStatus status) {
    switch (status) {
      case GatewayStatus.success:
        return 'Payment completed successfully';
      case GatewayStatus.failed:
        return 'Payment failed';
      case GatewayStatus.pending:
        return 'Payment is being processed';
      case GatewayStatus.unknown:
        return 'Payment status unknown';
    }
  }

  /// Create a callback function for webview URL changes
  static Function(String) createUrlChangeHandler({
    required Function(GatewayResponse) onGatewayResponse,
    List<String>? successUrls,
    List<String>? failureUrls,
    List<String>? pendingUrls,
  }) {
    return (String url) {
      print('🔍 Gateway URL Check: $url');
      
      // PRIORITY: Check URL patterns first before parsing
      if (successUrls != null) {
        print('🟢 Checking success patterns: $successUrls');
        for (final pattern in successUrls) {
          if (url.toLowerCase().contains(pattern.toLowerCase())) {
            print('✅ SUCCESS PATTERN MATCHED: $pattern in $url');
            // Parse the URL to get message and data
            final response = parseFromUrl(url);
            final updatedResponse = GatewayResponse(
              status: GatewayStatus.success,
              url: url,
              message: response.message ?? 'Payment completed successfully',
              data: response.data,
              transactionId: response.transactionId,
            );
            onGatewayResponse(updatedResponse);
            return;
          }
        }
      }
      
      if (failureUrls != null) {
        print('🔴 Checking failure patterns: $failureUrls');
        for (final pattern in failureUrls) {
          if (url.toLowerCase().contains(pattern.toLowerCase())) {
            print('❌ FAILURE PATTERN MATCHED: $pattern in $url');
            // Parse the URL to get message and data
            final response = parseFromUrl(url);
            final updatedResponse = GatewayResponse(
              status: GatewayStatus.failed,
              url: url,
              message: response.message ?? 'Payment failed',
              data: response.data,
              transactionId: response.transactionId,
            );
            onGatewayResponse(updatedResponse);
            return;
          }
        }
      }
      
      if (pendingUrls != null) {
        for (final pattern in pendingUrls) {
          if (url.toLowerCase().contains(pattern.toLowerCase())) {
            // Parse the URL to get message and data
            final response = parseFromUrl(url);
            final updatedResponse = GatewayResponse(
              status: GatewayStatus.pending,
              url: url,
              message: response.message ?? 'Payment is being processed',
              data: response.data,
              transactionId: response.transactionId,
            );
            onGatewayResponse(updatedResponse);
            return;
          }
        }
      }
      
      // If no patterns matched, use default parsing
      print('⚪ No patterns matched, using default parsing');
      final response = parseFromUrl(url);
      print('📋 Default parsed response: ${response.status} - ${response.message}');
      onGatewayResponse(response);
    };
  }

  /// Parse JSON response directly from page body
  static Future<GatewayResponse> parseJsonFromPageBody(
    WebViewController controller,
    String url,
  ) async {
    try {
      // Execute JavaScript to extract JSON from page body
      final jsonContent = await controller.runJavaScriptReturningResult(
        '''
        (function() {
          var body = document.body;
          var text = body.innerText || body.textContent || '';
          
          // Try to find JSON in the page
          var jsonData = null;
          
          // Method 1: Look for JSON object in text
          try {
            var jsonMatch = text.match(/\\{[\\s\\S]*\\}/);
            if (jsonMatch) {
              jsonData = JSON.parse(jsonMatch[0]);
            }
          } catch (e) {
            // Method 2: Check if entire body is JSON
            try {
              jsonData = JSON.parse(text.trim());
            } catch (e2) {
              // Method 3: Look for JSON in script tags
              var scripts = document.querySelectorAll('script');
              for (var script of scripts) {
                try {
                  var scriptText = script.textContent || script.innerText || '';
                  if (scriptText.includes('{') && scriptText.includes('}')) {
                    var scriptJsonMatch = scriptText.match(/\\{[\\s\\S]*\\}/);
                    if (scriptJsonMatch) {
                      jsonData = JSON.parse(scriptJsonMatch[0]);
                      break;
                    }
                  }
                } catch (e3) {
                  continue;
                }
              }
            }
          }
          
          return JSON.stringify({
            found: jsonData !== null,
            data: jsonData,
            rawText: text
          });
        })();
        ''',
      );

      final result = jsonDecode(jsonContent.toString());
      
      if (result['found'] == true && result['data'] != null) {
        final jsonData = result['data'];
        
        // Parse the JSON response
        GatewayStatus status = GatewayStatus.unknown;
        String? message;
        String? transactionId;
        
        // Check various status field names
        final statusFields = ['status', 'success', 'result', 'state', 'payment_status'];
        for (final field in statusFields) {
          if (jsonData[field] != null) {
            final statusValue = jsonData[field].toString().toLowerCase();
            if (statusValue == 'success' || statusValue == 'completed' || 
                statusValue == 'approved' || statusValue == 'true' || 
                statusValue == '1' || statusValue == 'paid') {
              status = GatewayStatus.success;
            } else if (statusValue == 'failed' || statusValue == 'error' || 
                      statusValue == 'declined' || statusValue == 'false' || 
                      statusValue == '0' || statusValue == 'cancelled') {
              status = GatewayStatus.failed;
            } else if (statusValue == 'pending' || statusValue == 'processing' || 
                      statusValue == 'waiting') {
              status = GatewayStatus.pending;
            }
            break;
          }
        }
        
        // Extract message
        final messageFields = ['message', 'msg', 'description', 'error_message', 'response_message'];
        for (final field in messageFields) {
          if (jsonData[field] != null && jsonData[field].toString().isNotEmpty) {
            message = jsonData[field].toString();
            break;
          }
        }
        
        // Extract transaction ID
        final txnFields = ['transaction_id', 'txn_id', 'payment_id', 'reference', 'ref', 'order_id'];
        for (final field in txnFields) {
          if (jsonData[field] != null && jsonData[field].toString().isNotEmpty) {
            transactionId = jsonData[field].toString();
            break;
          }
        }
        
        return GatewayResponse(
          status: status,
          url: url,
          message: message ?? _getDefaultMessage(status),
          transactionId: transactionId,
          data: jsonData,
        );
      } else {
        // Fallback to regular content parsing
        return await parseFromPageContent(controller, url);
      }
    } catch (e) {
      // Fallback to URL parsing if everything fails
      return parseFromUrl(url);
    }
  }

  /// Get all raw page content for debugging - no parsing
  static Future<Map<String, dynamic>> getRawPageContent(
    WebViewController controller,
    String url,
  ) async {
    try {
      // Execute multiple JavaScript calls to get ALL content with maximum error handling
      final rawContent = await controller.runJavaScriptReturningResult(
        '''
        (function() {
          var result = {
            timestamp: new Date().toISOString(),
            errors: [],
            url: 'unknown',
            title: 'unknown',
            bodyText: 'unknown',
            bodyHtml: 'unknown',
            fullHtml: 'unknown',
            documentReady: false,
            metaTags: [],
            allClasses: [],
            allIds: [],
            scripts: [],
            hiddenInputs: [],
            divs: [],
            spans: [],
            paragraphs: [],
            headers: [],
            forms: [],
            inputs: [],
            localStorage: {},
            sessionStorage: {},
            windowVars: {},
            rawData: {}
          };
          
          // Helper function to safely execute and log errors
          function safeExecute(name, fn) {
            try {
              return fn();
            } catch (e) {
              result.errors.push(name + ': ' + e.toString());
              return null;
            }
          }
          
          // Get basic page info
          result.url = safeExecute('url', function() {
            return window.location.href || 'no-url';
          }) || 'error-getting-url';
          
          result.title = safeExecute('title', function() {
            return document.title || 'no-title';
          }) || 'error-getting-title';
          
          result.documentReady = safeExecute('documentReady', function() {
            return document.readyState === 'complete';
          }) || false;
          
          // Get body content with multiple fallbacks
          result.bodyText = safeExecute('bodyText', function() {
            if (!document.body) return 'no-body-element';
            return document.body.innerText || document.body.textContent || 'empty-body-text';
          }) || 'error-getting-body-text';
          
          result.bodyHtml = safeExecute('bodyHtml', function() {
            if (!document.body) return 'no-body-element';
            return document.body.innerHTML || 'empty-body-html';
          }) || 'error-getting-body-html';
          
          result.fullHtml = safeExecute('fullHtml', function() {
            if (!document.documentElement) return 'no-document-element';
            return document.documentElement.outerHTML || 'empty-full-html';
          }) || 'error-getting-full-html';
          
          // Get all text content from page (alternative method)
          result.rawData.allTextContent = safeExecute('allTextContent', function() {
            var walker = document.createTreeWalker(
              document.body || document,
              NodeFilter.SHOW_TEXT,
              null,
              false
            );
            var textNodes = [];
            var node;
            while (node = walker.nextNode()) {
              if (node.nodeValue && node.nodeValue.trim()) {
                textNodes.push(node.nodeValue.trim());
              }
            }
            return textNodes.join(' | ');
          }) || 'error-getting-text-nodes';
          
          // Get all element content
          result.rawData.allElements = safeExecute('allElements', function() {
            var elements = document.querySelectorAll('*');
            var elementData = [];
            for (var i = 0; i < Math.min(elements.length, 100); i++) { // Limit to first 100 elements
              var el = elements[i];
              elementData.push({
                tag: el.tagName ? el.tagName.toLowerCase() : 'unknown',
                text: (el.innerText || el.textContent || '').substring(0, 200), // First 200 chars
                class: el.className || '',
                id: el.id || ''
              });
            }
            return elementData;
          }) || [];
          
          // Get scripts content
          result.scripts = safeExecute('scripts', function() {
            var scripts = document.querySelectorAll('script');
            var scriptData = [];
            for (var i = 0; i < scripts.length; i++) {
              var script = scripts[i];
              scriptData.push({
                src: script.src || '',
                content: (script.textContent || script.innerText || '').substring(0, 1000), // First 1000 chars
                type: script.type || 'text/javascript'
              });
            }
            return scriptData;
          }) || [];
          
          // Get meta tags
          result.metaTags = safeExecute('metaTags', function() {
            var metas = document.querySelectorAll('meta');
            var metaData = [];
            for (var i = 0; i < metas.length; i++) {
              var meta = metas[i];
              metaData.push({
                name: meta.name || '',
                property: meta.property || '',
                content: meta.content || '',
                httpEquiv: meta.httpEquiv || ''
              });
            }
            return metaData;
          }) || [];
          
          // Get all form data
          result.forms = safeExecute('forms', function() {
            var forms = document.querySelectorAll('form');
            var formData = [];
            for (var i = 0; i < forms.length; i++) {
              var form = forms[i];
              formData.push({
                action: form.action || '',
                method: form.method || '',
                id: form.id || '',
                class: form.className || '',
                innerHTML: form.innerHTML.substring(0, 500) // First 500 chars
              });
            }
            return formData;
          }) || [];
          
          // Get all inputs
          result.inputs = safeExecute('inputs', function() {
            var inputs = document.querySelectorAll('input, textarea, select');
            var inputData = [];
            for (var i = 0; i < inputs.length; i++) {
              var input = inputs[i];
              inputData.push({
                type: input.type || input.tagName.toLowerCase(),
                name: input.name || '',
                value: input.value || '',
                id: input.id || '',
                class: input.className || ''
              });
            }
            return inputData;
          }) || [];
          
          // Get window variables
          result.windowVars = safeExecute('windowVars', function() {
            var vars = {};
            var commonVars = ['paymentResult', 'gatewayResponse', 'transactionData', 'paymentData', 'result', 'response', 'status', 'data'];
            for (var i = 0; i < commonVars.length; i++) {
              var varName = commonVars[i];
              try {
                if (window[varName] !== undefined) {
                  vars[varName] = JSON.stringify(window[varName]);
                }
              } catch (e) {
                vars[varName + '_error'] = e.toString();
              }
            }
            return vars;
          }) || {};
          
          // Get storage
          result.localStorage = safeExecute('localStorage', function() {
            var storage = {};
            for (var i = 0; i < localStorage.length; i++) {
              var key = localStorage.key(i);
              if (key) {
                storage[key] = localStorage.getItem(key);
              }
            }
            return storage;
          }) || {};
          
          result.sessionStorage = safeExecute('sessionStorage', function() {
            var storage = {};
            for (var i = 0; i < sessionStorage.length; i++) {
              var key = sessionStorage.key(i);
              if (key) {
                storage[key] = sessionStorage.getItem(key);
              }
            }
            return storage;
          }) || {};
          
          return JSON.stringify(result, null, 2);
        })();
        ''',
      );

      return jsonDecode(rawContent.toString());
    } catch (e) {
      // If main JavaScript fails, try simpler approaches
      try {
        final fallbackContent = await controller.runJavaScriptReturningResult(
          '''
          (function() {
            try {
              return JSON.stringify({
                fallback: true,
                error: 'Main script failed: ${e.toString()}',
                url: window.location ? window.location.href : 'no-location',
                title: document.title || 'no-title',
                bodyExists: !!document.body,
                bodyText: document.body ? (document.body.innerText || document.body.textContent || 'empty') : 'no-body',
                bodyHTML: document.body ? document.body.innerHTML : 'no-body',
                documentHTML: document.documentElement ? document.documentElement.outerHTML : 'no-document',
                readyState: document.readyState || 'unknown',
                timestamp: new Date().toISOString()
              });
            } catch (innerError) {
              return JSON.stringify({
                fallback: true,
                error: 'Both scripts failed',
                mainError: '${e.toString()}',
                fallbackError: innerError.toString(),
                timestamp: new Date().toISOString()
              });
            }
          })();
          ''',
        );
        
        return jsonDecode(fallbackContent.toString());
      } catch (fallbackError) {
        // If everything fails, return basic info
        return {
          'error': 'All JavaScript execution failed',
          'mainError': e.toString(),
          'fallbackError': fallbackError.toString(),
          'url': url,
          'timestamp': DateTime.now().toIso8601String(),
          'suggestion': 'The page might not be fully loaded or JavaScript is disabled',
        };
      }
    }
  }

  /// Create a callback function for page finished events
  static Function(String) createPageFinishedHandler({
    required WebViewController controller,
    required Function(GatewayResponse) onGatewayResponse,
    bool parseContent = true,
    bool preferJsonParsing = true,
  }) {
    return (String url) async {
      if (parseContent) {
        final response = preferJsonParsing 
            ? await parseJsonFromPageBody(controller, url)
            : await parseFromPageContent(controller, url);
        onGatewayResponse(response);
      } else {
        final response = parseFromUrl(url);
        onGatewayResponse(response);
      }
    };
  }

  /// Create a debug callback that returns raw content
  static Function(String) createDebugPageHandler({
    required WebViewController controller,
    required Function(Map<String, dynamic>) onRawContent,
  }) {
    return (String url) async {
      final rawContent = await getRawPageContent(controller, url);
      onRawContent(rawContent);
    };
  }
}
