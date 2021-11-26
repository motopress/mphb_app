import 'package:flutter/material.dart';
import 'package:mphb_app/screens/bookings/create/search_availability_form.dart';
import 'package:mphb_app/controller/bookings_controller.dart';
import 'package:mphb_app/models/accommodation_availability.dart';
import 'package:mphb_app/models/accommodation.dart';

class CreateBookingSearchPage extends StatefulWidget {

	const CreateBookingSearchPage({
		Key? key,
		required this.booking,
	}) : super(key: key);

	final Map booking;

	@override
	_CreateBookingSearchPageState createState() => _CreateBookingSearchPageState( booking: booking );

}

class _CreateBookingSearchPageState extends State<CreateBookingSearchPage> {

	_CreateBookingSearchPageState({
		required this.booking,
	});

	final Map booking;

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

			setState(() {_state = 'waiting';});

			final items = await _bookingsController.wpCheckAvailability( params );

			setState(() {
				_accommodations = items;
				_state = 'complete';
			});

			booking['check_in_date'] = params['check_in_date'];
			booking['check_out_date'] = params['check_out_date'];


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
				return [Center(child:CircularProgressIndicator())];
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
				initiallyExpanded: i == 0,
				title: Text(accommodation_availability.title),
				children: [
					ListView.builder(
						shrinkWrap: true,
						itemCount: accommodation_availability.accommodations.length,
						itemBuilder: (BuildContext context, int index) {

							Accommodation accommodation = accommodation_availability.accommodations[index];

							return CheckboxListTile(
								title: Text( accommodation.title ),
								value: booking['selectedAccommodations'].contains(accommodation.id),
								onChanged: (bool? value) {
									setState(() {
										value! ? booking['selectedAccommodations'].add(accommodation.id) :
											booking['selectedAccommodations'].remove(accommodation.id);
									});

									print(booking['selectedAccommodations']);
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
				mainAxisAlignment: MainAxisAlignment.start,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Container(
						padding: EdgeInsets.all(20.00),
						margin: EdgeInsets.only(bottom: 10.00),
						child: SearchAvailabilityForm( callback: _checkAvailability ),
					),
					Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: getChildren(),
					),
				],
			),
		);

	}

}
