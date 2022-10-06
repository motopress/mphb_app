import 'package:flutter/foundation.dart';
import 'package:mphb_app/models/enum/date_range.dart';
import 'package:mphb_app/utils/date_utils.dart';

class Bookings_Filters {

    List<String> post_status;

    String date_range;

	String searchTerm;

	Bookings_Filters():
		post_status = [],
		date_range = '',
		searchTerm = '';

	Map<String, String> toMap() {

		Map<String, String> map = {};

		if ( post_status.length > 0 ) {
			map['filter[post_status]'] = post_status.join(',');
		}

		if ( ! date_range.isEmpty ) {
			switch (date_range) {
				case DateRangeEnum.TODAY:
					map['after'] = DateUtils.todayStart;
					map['before'] = DateUtils.todayEnd;
					break;
				case DateRangeEnum.THIS_WEEK:
					map['after'] = DateUtils.firstDayOfWeek;
					map['before'] = DateUtils.lastDayOfWeek;
					break;
				case DateRangeEnum.THIS_MONTH:
					map['after'] = DateUtils.firstDayOfMonth;
					map['before'] = DateUtils.lastDayOfMonth;
					break;
			}
		}

		if ( ! searchTerm.isEmpty ) {
			map['search'] = searchTerm;
		}

		return map;
	}

	bool isEmpty() {

		return (
			post_status.length == 0 &&
			date_range.isEmpty
		);
	}

	Bookings_Filters clone() {

		Bookings_Filters clone = new Bookings_Filters();

		clone.post_status = []..addAll( post_status );
		clone.date_range = date_range;
		clone.searchTerm = searchTerm;

		return clone;
	}

	bool equals( Bookings_Filters obj ) {

		return (
			date_range == obj.date_range &&
			searchTerm == obj.searchTerm &&
			listEquals( post_status, obj.post_status )
		);
	}


}
