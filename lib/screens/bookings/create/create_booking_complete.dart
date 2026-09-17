import 'package:flutter/material.dart';
import 'package:mphb_app/controller/bookings_controller.dart';
import 'package:mphb_app/models/create_booking.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:mphb_app/screens/bookings/create/single_accommodation.dart';
import 'package:sprintf/sprintf.dart';
import 'package:mphb_app/l10n/app_localizations.dart';

class CreateBookingCompletePage extends StatefulWidget {
  const CreateBookingCompletePage({
    Key? key,
    required this.booking,
    required this.createBookingCallback,
  }) : super(key: key);

  final Create_Booking booking;

  final Function(Booking) createBookingCallback;

  @override
  _CreateBookingCompletePageState createState() =>
      _CreateBookingCompletePageState(booking: booking);
}

class _CreateBookingCompletePageState extends State<CreateBookingCompletePage> {
  _CreateBookingCompletePageState({required this.booking});

  late Create_Booking booking;

  String _state = 'waiting';

  late final BookingsController _bookingsController;

  @override
  void initState() {
    super.initState();
    _bookingsController = new BookingsController();

    bookNow();
  }

  void bookNow() async {
    setState(() {
      _state = 'waiting';
    });

    try {
      final bookingObj = await _bookingsController.wpCreateBooking(
        booking.toApiParams(),
      );

      setState(() {
        _state = 'complete';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            sprintf(AppLocalizations.of(context)!.bookingCreatedMessage, [
              bookingObj.id,
            ]),
          ),
        ),
      );

      widget.createBookingCallback(bookingObj);
    } catch (error) {
      setState(() {
        _state = '';
      });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  Widget getChild() {
    switch (_state) {
      case 'complete':
        return Icon(Icons.check_circle, size: 64, color: Colors.green);
        break;

      case 'waiting':
        return CircularProgressIndicator();
        break;

      default:
        return Text('');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.00),
              child: getChild(),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
