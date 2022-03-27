import 'package:flutter/material.dart';
import 'package:mphb_app/controller/accommodation_type_controller.dart';
import 'package:mphb_app/models/new_booking.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';
import 'package:mphb_app/models/accommodation_type.dart';

class SingleAccommodation extends StatefulWidget {

	const SingleAccommodation({
		Key? key,
		required this.accommodation,
		required this.booking,
	}) : super(key: key);

	final Accommodation accommodation;
	final NewBooking booking;

	@override
	_SingleAccommodationState createState() => _SingleAccommodationState(
		accommodation: accommodation,
		booking: booking,
	);

}

class _SingleAccommodationState extends State<SingleAccommodation> {

	_SingleAccommodationState({
		required this.accommodation,
		required this.booking,
	});

	late Accommodation accommodation;
	late NewBooking booking;
	late Accommodation_Type accommodation_type;

	String _state = '';

	late final AccommodationTypeController _accommodationTypeController;

	@override
	void initState() {

		super.initState();
		_accommodationTypeController = new AccommodationTypeController();

		getAccommodationType();
	}

	void getAccommodationType() async {

		setState(() {_state = 'waiting';});

		final accommodationType = await _accommodationTypeController.wpGetAccommodationType(
			accommodation.accommodation_type_id );

		setState(() {
			_state = 'complete';
			accommodation_type = accommodationType;
		} );
		
		print( accommodationType );
	}

	List<Widget> getChildren() {

		List<Widget> children = [Text( accommodation.title )];

		switch (_state) {
			case 'complete':
				children += [
					SizedBox(height: 5.0),

					Text( accommodation_type.title, style: const TextStyle(fontSize: 11), ),
					Text( accommodation_type.adults.toString() ),
					Text( accommodation_type.children.toString() ),
				];
				break;
			
			case 'waiting':
				children += [Center(child:CircularProgressIndicator())];
				break;
		}

		return children;
	}

	@override
	Widget build(BuildContext context) {

		return Container(

			padding: EdgeInsets.all(20.0),
			margin: EdgeInsets.all(10.00),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.all(
					Radius.circular(6)
				),
				boxShadow: [
					BoxShadow(
						color: Colors.grey.withOpacity(0.1),
						spreadRadius: 0,
						blurRadius: 2,
						offset: Offset(0, 4), // changes position of shadow
					),
				],
			),
			child: Row(
				children: [
					Column(
						mainAxisAlignment: MainAxisAlignment.start,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: getChildren(),
					),
				]
			),
		);

	}

}
