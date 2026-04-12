import 'package:intl/intl.dart';

import '../../../shared/blocs/main_app_bloc.dart';

class DateFormats {
  /// (e.g., "Oct 11, 2022 4:27:23 PM").
  static String formatDateDayAndTime(String stringDate) =>
      DateFormat.yMMMd().add_jms().format(DateTime.parse(stringDate).toLocal());

  ///(e.g., "Tuesday, October 11, 2022").
  static String formatDateyMMMMEEEEdTime(String stringDate) =>
      DateFormat('yMMMMEEEEd', mainAppBloc.isArabic ? 'ar' : 'en_US')
          .format(DateTime.parse(stringDate).toLocal());

  ///(e.g., "Wednesday, October 12").
  static String formatDateEEEEMMMdd(String stringDate) => DateFormat.EEEE()
      .add_MMMM()
      .add_d()
      .format(DateTime.parse(stringDate).toLocal());

  ///(e.g., "October Wednesday 12").
  static String formatDateMMMMEEEEd(String stringDate) =>
      DateFormat.MMMMEEEEd().format(DateTime.parse(stringDate).toLocal());

  ///(e.g., "10/12/2022").
  static String formatDateMdyyyy(String stringDate) =>
      DateFormat.Md().add_y().format(DateTime.parse(stringDate).toLocal());

  /// Formats the date in the format "day-month-year".
  static String formatDateDayMonthYear(String stringDate) =>
      DateFormat('d-M-y').format(DateTime.parse(stringDate).toLocal());

  ///(e.g., "16:27").
  static String formatDateHHmm(String stringDate) =>
      DateFormat.Hm().format(DateTime.parse(stringDate).toLocal());

  ///(e.g., "04:27:23").
  static String formatDatehhmmss(String stringDate) =>
      DateFormat.Hms().format(DateTime.parse(stringDate).toLocal());

  ///(e.g., "Oct 2022").
  static String formatDateMMMyy(String stringDate) =>
      DateFormat.MMM().add_y().format(DateTime.parse(stringDate).toLocal());

  ///(e.g., "24/11/20 11:30 am")
  static String formatDateYearMonthDayHoursMinAmOrPm(String stringDate) =>
      DateFormat(
        'yyyy-MM-dd / hh:mm a',
      ).format(DateTime.parse(stringDate).toLocal());

  ///(e.g., "11:30 am")
  static String formatDateHoursMinAmOrPm(String stringDate) => DateFormat(
        'h:mm a',
      ).format(DateTime.parse(stringDate).toLocal());

  /// Formats the date and time using a custom format string.
  static String formatCustom(String stringDate, String format) =>
      DateFormat(format).format(DateTime.parse(stringDate).toLocal());
  static String messagerFormated(String stringDate) =>
      DateFormat('MMMM d').format(DateTime.parse(stringDate).toLocal());

  //  gives the full name of the day
  static String getDayName(DateTime date, String locale) =>
      DateFormat('EEEE', locale).format(date);
  static String formatDayMonthTime(DateTime dateTime) {
    final DateFormat dayFormatter = DateFormat.d();
    final DateFormat monthFormatter = DateFormat.MMMM();
    final DateFormat timeFormatter =
        DateFormat.jm(); // For time in 'hh:mm AM/PM' format

    String day = dayFormatter.format(dateTime);
    String month = monthFormatter.format(dateTime);
    String time = timeFormatter.format(dateTime);

    return '$day $month $time';
  }

  /// Checks if the provided string is a valid date.
  static bool isDateValid(String str) {
    try {
      DateTime.parse(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}
