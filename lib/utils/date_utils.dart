import 'package:intl/intl.dart';

class DateUtils {

	static DateTime _now = DateTime.now();

	static DateTime _getDate(DateTime d) => DateTime(d.year, d.month, d.day);

	//today
	static String get todayStart => _getDate(_now).toIso8601String();

	static String get todayEnd => _getDate(_now).add(
		Duration(hours: 23, minutes: 59, seconds: 59 )).toIso8601String();

	//this week
	static String get firstDayOfWeek => _getDate(_now.subtract(
		Duration(days: _now.weekday - 1))).toIso8601String();

	static String get lastDayOfWeek => _getDate(_now.
		add(Duration(days: DateTime.daysPerWeek - _now.weekday))).
			add(Duration(hours: 23, minutes: 59, seconds: 59 )).toIso8601String();

	//this month
	static String get firstDayOfMonth => DateTime(_now.year, _now.month, 1).toIso8601String();

	static String get lastDayOfMonth => DateTime(_now.year, _now.month + 1, 1, 0, 0, -1).toIso8601String(); 

}