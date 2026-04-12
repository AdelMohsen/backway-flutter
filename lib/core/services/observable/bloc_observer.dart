import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/utility.dart';

class BlocObserverService extends BlocObserver {
  static const String _tag = '🔍 BLOC_OBSERVER';
  
  String _formatTimestamp() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}.${now.millisecond.toString().padLeft(3, '0')}';
  }

  String _formatBlocName(String blocType) {
    return blocType.replaceAll('Bloc', '').replaceAll('Cubit', '');
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    final timestamp = _formatTimestamp();
    final blocName = _formatBlocName(bloc.runtimeType.toString());
    cprint('$_tag [$timestamp] 🟢 CREATE: $blocName');
    cprint('$_tag [$timestamp] 📍 Instance: ${bloc.hashCode}');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    final timestamp = _formatTimestamp();
    final blocName = _formatBlocName(bloc.runtimeType.toString());
    final eventType = event.runtimeType.toString();
    
    cprint('$_tag [$timestamp] 📥 EVENT: $blocName');
    cprint('$_tag [$timestamp] 🎯 Type: $eventType');
    cprint('$_tag [$timestamp] 📦 Data: $event');
    cprint('$_tag [$timestamp] 📍 Instance: ${bloc.hashCode}');
    cprint('$_tag [$timestamp] ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    final timestamp = _formatTimestamp();
    final blocName = _formatBlocName(bloc.runtimeType.toString());
    
    cprint('$_tag [$timestamp] 🔄 CHANGE: $blocName');
    cprint('$_tag [$timestamp] 📍 Instance: ${bloc.hashCode}');
    cprint('$_tag [$timestamp] 🔴 From: ${change.currentState}');
    cprint('$_tag [$timestamp] 🟢 To: ${change.nextState}');
    cprint('$_tag [$timestamp] ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    final timestamp = _formatTimestamp();
    final blocName = _formatBlocName(bloc.runtimeType.toString());
    final eventType = transition.event.runtimeType.toString();
    
    cprint('$_tag [$timestamp] ⚡ TRANSITION: $blocName');
    cprint('$_tag [$timestamp] 📍 Instance: ${bloc.hashCode}');
    cprint('$_tag [$timestamp] 🎯 Event: $eventType');
    cprint('$_tag [$timestamp] 📦 Event Data: ${transition.event}');
    cprint('$_tag [$timestamp] 🔴 Current State: ${transition.currentState}');
    cprint('$_tag [$timestamp] 🟢 Next State: ${transition.nextState}');
    cprint('$_tag [$timestamp] ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    final timestamp = _formatTimestamp();
    final blocName = _formatBlocName(bloc.runtimeType.toString());
    
    cprint('$_tag [$timestamp] ❌ ERROR: $blocName');
    cprint('$_tag [$timestamp] 📍 Instance: ${bloc.hashCode}');
    cprint('$_tag [$timestamp] 🚨 Error Type: ${error.runtimeType}');
    cprint('$_tag [$timestamp] 💥 Error Message: $error');
    cprint('$_tag [$timestamp] 📚 Stack Trace:');
    
    // Format stack trace for better readability
    final stackLines = stackTrace.toString().split('\n');
    for (int i = 0; i < stackLines.length && i < 10; i++) {
      if (stackLines[i].trim().isNotEmpty) {
        cprint('$_tag [$timestamp] 📚   ${stackLines[i].trim()}');
      }
    }
    
    if (stackLines.length > 10) {
      cprint('$_tag [$timestamp] 📚   ... (${stackLines.length - 10} more lines)');
    }
    
    cprint('$_tag [$timestamp] ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    final timestamp = _formatTimestamp();
    final blocName = _formatBlocName(bloc.runtimeType.toString());
    cprint('$_tag [$timestamp] 🔴 CLOSE: $blocName');
    cprint('$_tag [$timestamp] 📍 Instance: ${bloc.hashCode}');
    cprint('$_tag [$timestamp] ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  }
}
