import 'package:flutter/material.dart';

class Calendar_Filters {

	static const SHOW_IMPORTED_DEFAULT = true;

    final List<String> post_status = <String>[];

    bool show_imported = SHOW_IMPORTED_DEFAULT;

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

}
