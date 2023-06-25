import 'package:flutter/material.dart';
import 'package:mphb_app/controller/accommodation_type_controller.dart';
import 'package:mphb_app/models/create_booking.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';
import 'package:mphb_app/models/accommodation_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleAccommodation extends StatefulWidget {

	const SingleAccommodation({
		Key? key,
		required this.accommodation,
		required this.booking,
	}) : super(key: key);

	final Accommodation accommodation;
	final Create_Booking booking;

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
	late Create_Booking booking;
	late Accommodation_Type accommodation_type;
	late Reserved_Accommodation _reserved_accommodation;

	String _state = '';

	late final AccommodationTypeController _accommodationTypeController;

	@override
	void initState() {

		super.initState();
		_accommodationTypeController = new AccommodationTypeController();

		getAccommodationType();
	}

	void getAccommodationType() async {

		try {

			setState(() {_state = 'waiting';});

			final accommodationType =
				await _accommodationTypeController.wpGetAccommodationType(
					accommodation.accommodation_type_id );

			//Reserved_Accommodation
			Reserved_Accommodation reserved_accommodation = new Reserved_Accommodation(

				accommodation: accommodation.id,
				accommodation_type: accommodation.accommodation_type_id,
				rate: 0,
				adults: 1,
				children: 0,
				guest_name: '',
				services: [],
				accommodation_price_per_days: [],
				fees: [],
				taxes: {},
				discount: 0

			);

			booking.reserved_accommodations.add( reserved_accommodation );

			setState(() {
				_state = 'complete';
				accommodation_type = accommodationType;
				_reserved_accommodation = reserved_accommodation;
			} );

			booking.dispatch(context);

		} catch (error) {

			setState(() {_state = 'complete';});

			ScaffoldMessenger.of(context).clearSnackBars();
			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(content: Text(error.toString()))
			);
		}
	}

	List<Widget> getChildren() {

		List<Widget> children = [Text( accommodation.title )];

		switch (_state) {
			case 'complete':
				children += [

					SizedBox(height: 5.0),
					Text( accommodation_type.title, style: const TextStyle(fontSize: 11), ),

					Column(
						children: [
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: [
									Text(AppLocalizations.of(context).adultsLabelText),
									DropdownButton<String>(
										value: _reserved_accommodation.adults.toString(),

										items: List<String>.generate(
												accommodation_type.adults, (i) => (i + 1).toString()
											).map((String value) {

											return DropdownMenuItem<String>(
												value: value,
												child: Text(value),
											);
										}).toList(),

										onChanged: (String? newValue) {
											setState(() {
												_reserved_accommodation.adults = int.parse(newValue!);
											});
										},
									),
								],
							),

							if ( accommodation_type.children > 0 )
							SizedBox(width: 10),

							if ( accommodation_type.children > 0 )
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: [
									Text(AppLocalizations.of(context).childrenLabelText),
									DropdownButton<String>(
										value: _reserved_accommodation.children.toString(),
										items: List<String>.generate(
												accommodation_type.children + 1, (i) => (i).toString()
											).map((String value) {

											return DropdownMenuItem<String>(
												value: value,
												child: Text(value),
											);
										}).toList(),

										onChanged: (String? newValue) {
											setState(() {
												_reserved_accommodation.children = int.parse(newValue!);
											});
										},
									),
								],
							),
						],
					),
				];
				break;

			case 'waiting':
				children += [
					Center(
						child: Padding (
							padding: EdgeInsets.only(top: 20.0),
							child: CircularProgressIndicator(),
						),
					),
				];
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
						offset: Offset(0, 4),
					),
				],
			),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: getChildren(),
			),
		);

	}

}
