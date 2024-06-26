import 'package:html_unescape/html_unescape_small.dart';

class Rate {

    final int id;
    final String title;
    final String description;
    final int accommodation_type_id;
    final List season_prices;

	Rate({
		required this.id,
		required this.title,
		required this.description,
		required this.accommodation_type_id,
		required this.season_prices,
	});

	factory Rate.fromJson(Map<String, dynamic> json) {

		var unescape = HtmlUnescape();

		return Rate(
			id: json['id'] as int,
			title: unescape.convert( json['title'] ?? '' ),
			description: json['description'] as String,
			accommodation_type_id: json['accommodation_type_id'] as int,
			season_prices: json['season_prices'] as List,
		);
	}

}
