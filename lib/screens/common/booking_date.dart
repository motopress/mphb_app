import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingDate extends StatelessWidget {

	final String date;
	double fontSize;

	BookingDate(
		this.date,
		{
			this.fontSize = 20,
			Key? key
		}
	) : super(key: key);

	@override
	Widget build( BuildContext context ) {

		DateTime _datetime = DateTime.parse( date );

		return Row(
			children: [
				Text(
					DateFormat('d').format( _datetime ),
					style: TextStyle(
						fontWeight: FontWeight.bold,
						fontSize: fontSize,
						height: 1
					),
				),
				const SizedBox(width: 3.0),
				Column(
					children: [
						Text(
							DateFormat('M').format( _datetime ),
							style: TextStyle(
								fontSize: fontSize * 0.45,
								fontWeight: FontWeight.bold,
								height: 1
							),
						),
						Text(
							DateFormat('yy').format( _datetime ),
							style: TextStyle(
								fontSize: fontSize * 0.45,
								height: 1
							),
						),
					],
				),
			],
		);
	}
}