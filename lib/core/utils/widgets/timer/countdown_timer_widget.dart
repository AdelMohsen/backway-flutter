import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimerWidget extends StatefulWidget {
  final DateTime endTime;
  final String language;

  const CountdownTimerWidget({
    super.key,
    required this.endTime,
    this.language = 'ar',
  });

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late Timer _timer;
  Duration _remainingTime = const Duration();

  final Map<String, String> _arabicNumerals = {
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
  };

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _calculateRemainingTime() {
    final now = DateTime.now();
    if (widget.endTime.isAfter(now)) {
      _remainingTime = widget.endTime.difference(now);
    } else {
      _remainingTime = const Duration();
    }
    setState(() {});
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateRemainingTime();
    });
  }

  String _convertToArabicNumerals(int number) {
    return number
        .toString()
        .split('')
        .map((digit) => _arabicNumerals[digit] ?? digit)
        .join('');
  }

  String _formatTime(int hours, int minutes, int seconds) {
    if (widget.language == 'ar') {
      return '${_convertToArabicNumerals(hours)} س : ${_convertToArabicNumerals(minutes)}د : ${_convertToArabicNumerals(seconds)} ث';
    } else {
      return '${hours.toString().padLeft(2, '0')}h : ${minutes.toString().padLeft(2, '0')}m : ${seconds.toString().padLeft(2, '0')}s';
    }
  }

  @override
  Widget build(BuildContext context) {
    final hours = _remainingTime.inHours;
    final minutes = _remainingTime.inMinutes.remainder(60);
    final seconds = _remainingTime.inSeconds.remainder(60);

    return Text(
      _formatTime(hours, minutes, seconds),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
