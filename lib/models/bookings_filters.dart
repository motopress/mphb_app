import 'package:intl/intl.dart';
import 'package:mphb_app/models/enum/date_range.dart';

class Bookings_Filters {

    final List<String> post_status = <String>[];
    String date_range = '';

	Bookings_Filters();

	//now
	final now = DateTime.now();

	DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

	//today
	String get todayStart => getDate(now).toIso8601String();
	String get todayEnd => getDate(now).add(Duration(hours: 23, minutes: 59, seconds: 59 )).toIso8601String();

	//this week
	String get firstDayOfWeek => getDate(now.subtract(Duration(days: now.weekday - 1))).toIso8601String();
	String get lastDayOfWeek => getDate(now.
		add(Duration(days: DateTime.daysPerWeek - now.weekday))).
			add(Duration(hours: 23, minutes: 59, seconds: 59 )).toIso8601String();

	//this month
	String get firstDayOfMonth => DateTime(now.year, now.month, 1).toIso8601String();
	String get lastDayOfMonth => DateTime(now.year, now.month + 1, 1, 0, 0, -1).toIso8601String();

	Map<String, String> toMap() {

		Map<String, String> map = {};

		if ( post_status.length > 0 ) {
			map['filter[post_status]'] = post_status.join(',');
		}

		if ( ! date_range.isEmpty ) {
			switch (date_range) {
				case DateRangeEnum.TODAY:
					map['after'] = todayStart;
					map['before'] = todayEnd;
					break;
				case DateRangeEnum.THIS_WEEK:
					map['after'] = firstDayOfWeek;
					map['before'] = lastDayOfWeek;
					break;
				case DateRangeEnum.THIS_MONTH:
					map['after'] = firstDayOfMonth;
					map['before'] = lastDayOfMonth;
					break;
			}
		}

		return map;
	}

	bool isEmpty() {
		return (
			post_status.length == 0 &&
			date_range.isEmpty
		);
	}

}
