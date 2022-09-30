import 'package:flutter/foundation.dart';

class Calendar_Filters {

	static const SHOW_IMPORTED_DEFAULT = true;

    List<String> post_status;

    bool show_imported;

	Calendar_Filters():
		post_status = [],
		show_imported = SHOW_IMPORTED_DEFAULT;

	Map<String, String> toMap() {

		Map<String, String> map = {};

		if ( post_status.length > 0 ) {
			map['filter[post_status]'] = post_status.join(',');
		}

		if ( show_imported == false ) {
			map['filter[meta_query][0][key]'] = '_mphb_sync_id';
			map['filter[meta_query][0][compare]'] = 'NOT EXISTS';
		}

		return map;
	}

	bool isEmpty() {

		return (
			post_status.length == 0 &&
			show_imported == SHOW_IMPORTED_DEFAULT
		);
	}

	Calendar_Filters clone() {

		Calendar_Filters clone = new Calendar_Filters();

		clone.post_status = []..addAll( post_status );
		clone.show_imported = show_imported;

		return clone;
	}

	bool equals( Calendar_Filters obj ) {

		return (
			show_imported == obj.show_imported &&
			listEquals( post_status, obj.post_status )
		);
	}

}
