import 'package:flutter/material.dart';
import 'package:mphb_app/screens/bookings/create/search_availability_form.dart';
import 'package:mphb_app/controller/bookings_controller.dart';
import 'package:mphb_app/models/accommodation_availability.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/create_booking.dart';

class CreateBookingSearchPage extends StatefulWidget {

	CreateBookingSearchPage({
		Key? key,
		required this.booking,
	}) : super(key: key);

	late Create_Booking booking;

	@override
	_CreateBookingSearchPageState createState() => _CreateBookingSearchPageState( booking: booking );

}

class _CreateBookingSearchPageState extends State<CreateBookingSearchPage> {

	_CreateBookingSearchPageState({
		required this.booking,
	});

	late Create_Booking booking;

	late final BookingsController _bookingsController;

	List<Accommodation_Availability> _accommodations = [];

	String _state = 'initialized'; // initialized, waiting, complete

	@override
	void initState() {

		super.initState();
		_bookingsController = new BookingsController();
	}

	Future<void> _checkAvailability( params ) async {

		try {

			//reset search results
			booking.accommodations.clear();

			setState(() {_state = 'waiting';});

			final items = await _bookingsController.wpCheckAvailability( params );

			setState(() {
				_accommodations = items;
				_state = 'complete';
			});

			booking.check_in_date = params['check_in_date'];
			booking.check_out_date = params['check_out_date'];


		} catch (error) {
			print(error);
		}
	}

	List<Widget> getChildren() {

		switch (_state) {
			case 'complete':
				if ( _accommodations.length > 0 ) {
					return buildAccommodations.toList();
				} else {
					return [Center(child:Text('Nothing found'))];
				}
				break;
			
			case 'waiting':
				return [CircularProgressIndicator()];
				break;
			default:
				return [];
				break;
		}
	}

	Iterable<Widget> get buildAccommodations sync* {

		for (var i = 0; i < _accommodations.length; i++) {

			Accommodation_Availability accommodation_availability = _accommodations[i];

			yield ExpansionTile(
				//initiallyExpanded: i == 0,
				title: Text(accommodation_availability.title +
					' (' + accommodation_availability.accommodations.length.toString() + ')'),
				subtitle: Text(
					'Base price: ' + accommodation_availability.base_price.toStringAsFixed(2),
					style: const TextStyle(fontSize: 11),
				),
				children: [
					ListView.builder(
						shrinkWrap: true,
						itemCount: accommodation_availability.accommodations.length,
						itemBuilder: (BuildContext context, int index) {

							Accommodation accommodation = accommodation_availability.accommodations[index];

							return CheckboxListTile(
								title: Text( accommodation.title ),
								value: booking.accommodations.contains(accommodation),
								onChanged: (bool? value) {
									setState(() {
										value! ? booking.accommodations.add(accommodation) :
											booking.accommodations.remove(accommodation);
									});

									booking.dispatch(context);

									//booking.accommodations.forEach((element) => print(element.id));
								},
							);
						}
					),
				]
			);
		}
	}

	@override
	Widget build(BuildContext context) {

		return SingleChildScrollView(
			child: Column(
				crossAxisAlignment: _state == 'waiting' ? CrossAxisAlignment.center : CrossAxisAlignment.start,
				mainAxisAlignment: _state == 'waiting' ? MainAxisAlignment.center : MainAxisAlignment.start,
				children: [
					Container(
						padding: EdgeInsets.all(20.00),
						margin: EdgeInsets.all(10.00),
						child: SearchAvailabilityForm( callback: _checkAvailability ),
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
					),
					Container(
						padding: getChildren().isEmpty ? EdgeInsets.all(0.00) : EdgeInsets.all(20.00),
						margin: EdgeInsets.all(10.00),
						child: Column(
							children: getChildren(),
						),
						decoration: BoxDecoration(
							color: Colors.white,
							borderRadius: BorderRadius.all(
								Radius.circular( _state == 'waiting' ? 100: 6 )
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
					),
				],
			),
		);

	}

}
