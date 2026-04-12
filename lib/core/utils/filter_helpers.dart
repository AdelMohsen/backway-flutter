import 'constant/app_strings.dart';
import 'extensions/extensions.dart';

/// Helper class for order direction mapping
/// Context-aware: Display text changes based on orderBy field
/// - created_at: Newest/Oldest
/// - avg_rating: Highest/Lowest
/// - price: Highest Price/Lowest Price
/// Backend always sends: asc/desc
class OrderDirectionHelper {
  static const String ascendingValue = 'asc';
  static const String descendingValue = 'desc';
  
  /// Get context-aware display text based on orderBy field and direction
  /// orderByValue: 'created_at', 'avg_rating', or 'price'
  /// backendValue: 'asc' or 'desc'
  static String getDisplayText(String backendValue, {String? orderByValue}) {
    if (orderByValue == null) {
      // Default to date-based if no context provided
      return backendValue == ascendingValue 
          ? AppStrings.oldest.tr 
          : AppStrings.newest.tr;
    }
    
    switch (orderByValue) {
      case OrderByHelper.createdAtValue: // 'created_at'
        return backendValue == ascendingValue
            ? AppStrings.oldest.tr     // asc = oldest first
            : AppStrings.newest.tr;    // desc = newest first
            
      case OrderByHelper.avgRatingValue: // 'avg_rating'
        return backendValue == ascendingValue
            ? AppStrings.lowest.tr     // asc = lowest rating first
            : AppStrings.highest.tr;   // desc = highest rating first
            
      case OrderByHelper.priceValue: // 'price'
        return backendValue == ascendingValue
            ? AppStrings.lowestPrice.tr  // asc = lowest price first
            : AppStrings.highestPrice.tr; // desc = highest price first
            
      default:
        // Default to date-based
        return backendValue == ascendingValue
            ? AppStrings.oldest.tr
            : AppStrings.newest.tr;
    }
  }
  
  /// Get backend value from context-aware display text
  /// orderByValue: 'created_at', 'avg_rating', or 'price'
  static String getBackendValue(String displayText, {String? orderByValue}) {
    // Check all possible display texts and return appropriate backend value
    // For all contexts: desc values come first, asc values come second
    
    // Date-based (created_at)
    if (displayText == AppStrings.newest.tr) return descendingValue; // desc
    if (displayText == AppStrings.oldest.tr) return ascendingValue;  // asc
    
    // Rating-based (avg_rating)
    if (displayText == AppStrings.highest.tr) return descendingValue; // desc
    if (displayText == AppStrings.lowest.tr) return ascendingValue;   // asc
    
    // Price-based (price)
    if (displayText == AppStrings.highestPrice.tr) return descendingValue; // desc
    if (displayText == AppStrings.lowestPrice.tr) return ascendingValue;   // asc
    
    return ascendingValue; // default fallback
  }
  
  /// Get context-aware options based on orderBy field
  /// orderByValue: 'created_at', 'avg_rating', or 'price'
  static List<OrderDirectionOption> getAllOptions({String? orderByValue}) {
    if (orderByValue == null) {
      // Default to date-based
      return [
        OrderDirectionOption(
          displayText: AppStrings.newest.tr,
          backendValue: descendingValue,
        ),
        OrderDirectionOption(
          displayText: AppStrings.oldest.tr,
          backendValue: ascendingValue,
        ),
      ];
    }
    
    switch (orderByValue) {
      case OrderByHelper.createdAtValue: // 'created_at'
        return [
          OrderDirectionOption(
            displayText: AppStrings.newest.tr,  // desc
            backendValue: descendingValue,
          ),
          OrderDirectionOption(
            displayText: AppStrings.oldest.tr,  // asc
            backendValue: ascendingValue,
          ),
        ];
        
      case OrderByHelper.avgRatingValue: // 'avg_rating'
        return [
          OrderDirectionOption(
            displayText: AppStrings.highest.tr, // desc
            backendValue: descendingValue,
          ),
          OrderDirectionOption(
            displayText: AppStrings.lowest.tr,  // asc
            backendValue: ascendingValue,
          ),
        ];
        
      case OrderByHelper.priceValue: // 'price'
        return [
          OrderDirectionOption(
            displayText: AppStrings.highestPrice.tr, // desc
            backendValue: descendingValue,
          ),
          OrderDirectionOption(
            displayText: AppStrings.lowestPrice.tr,  // asc
            backendValue: ascendingValue,
          ),
        ];
        
      default:
        // Default to date-based
        return [
          OrderDirectionOption(
            displayText: AppStrings.newest.tr,
            backendValue: descendingValue,
          ),
          OrderDirectionOption(
            displayText: AppStrings.oldest.tr,
            backendValue: ascendingValue,
          ),
        ];
    }
  }
}

/// Helper class for order by field mapping
class OrderByHelper {
  static const String createdAtValue = 'created_at';
  static const String avgRatingValue = 'avg_rating';
  static const String priceValue = 'price';
  
  /// Get display text based on current language
  static String getDisplayText(String backendValue) {
    switch (backendValue) {
      case createdAtValue:
        return AppStrings.createdAt.tr;
      case avgRatingValue:
        return AppStrings.avgRating.tr;
      case priceValue:
        return AppStrings.price.tr;
      default:
        return AppStrings.createdAt.tr;
    }
  }
  
  /// Get backend value from display text
  static String getBackendValue(String displayText) {
    if (displayText == AppStrings.createdAt.tr) {
      return createdAtValue;
    } else if (displayText == AppStrings.avgRating.tr) {
      return avgRatingValue;
    } else if (displayText == AppStrings.price.tr) {
      return priceValue;
    }
    return createdAtValue; // default
  }
  
  /// Get all available options for dropdown
  static List<OrderByOption> getAllOptions() {
    return [
      OrderByOption(
        displayText: AppStrings.createdAt.tr,
        backendValue: createdAtValue,
      ),
      OrderByOption(
        displayText: AppStrings.avgRating.tr,
        backendValue: avgRatingValue,
      ),
      OrderByOption(
        displayText: AppStrings.price.tr,
        backendValue: priceValue,
      ),
    ];
  }
}

/// Data class for order direction options
class OrderDirectionOption {
  final String displayText;
  final String backendValue;
  
  const OrderDirectionOption({
    required this.displayText,
    required this.backendValue,
  });
  
  @override
  String toString() => displayText;
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderDirectionOption &&
          runtimeType == other.runtimeType &&
          backendValue == other.backendValue;
  
  @override
  int get hashCode => backendValue.hashCode;
}

/// Data class for order by options
class OrderByOption {
  final String displayText;
  final String backendValue;
  
  const OrderByOption({
    required this.displayText,
    required this.backendValue,
  });
  
  @override
  String toString() => displayText;
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderByOption &&
          runtimeType == other.runtimeType &&
          backendValue == other.backendValue;
  
  @override
  int get hashCode => backendValue.hashCode;
}
