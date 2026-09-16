import 'package:flutter/material.dart';
import 'package:mphb_app/models/enum/booking_status.dart';
import 'package:mphb_app/models/create_booking.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';
import 'package:mphb_app/screens/bookings/create/single_accommodation.dart';
import 'package:mphb_app/l10n/app_localizations.dart';

class CreateBookingCheckoutPage extends StatefulWidget {
  const CreateBookingCheckoutPage({Key? key, required this.booking})
    : super(key: key);

  final Create_Booking booking;

  @override
  _CreateBookingCheckoutPageState createState() =>
      _CreateBookingCheckoutPageState(booking: booking);
}

class _CreateBookingCheckoutPageState extends State<CreateBookingCheckoutPage> {
  _CreateBookingCheckoutPageState({required this.booking});

  late Create_Booking booking;

  void _dispatchBookingUpdate() {
    booking.dispatch(context);
  }

  @override
  void initState() {
    super.initState();

    //reset
    booking.reset();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.all(10.00),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6)),
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
              children: [
                Text(AppLocalizations.of(context)!.customerInformationText),
                TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.optionalFieldLabel(
                      AppLocalizations.of(context)!.firstnameLabelText,
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (text) {
                    booking.customer.first_name = text.trim();
                    _dispatchBookingUpdate();
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.optionalFieldLabel(
                      AppLocalizations.of(context)!.lastnameLabelText,
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (text) {
                    booking.customer.last_name = text.trim();
                    _dispatchBookingUpdate();
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.optionalFieldLabel(
                      AppLocalizations.of(context)!.emailLabelText,
                    ),
                    helperText: AppLocalizations.of(
                      context,
                    )!.bookingEmailHelpText,
                    helperMaxLines: 3,
                    errorText: booking.hasValidCustomerEmail()
                        ? null
                        : AppLocalizations.of(
                            context,
                          )!.invalidCustomerEmailText,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (text) {
                    setState(() {
                      booking.customer.email = text.trim();
                    });
                    _dispatchBookingUpdate();
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.optionalFieldLabel(
                      AppLocalizations.of(context)!.phoneLabelText,
                    ),
                  ),
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  onChanged: (text) {
                    booking.customer.phone = text.trim();
                    _dispatchBookingUpdate();
                  },
                ),
              ],
            ),
          ),
          Column(children: getChildren()),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.bookingStatusLabelText),
                RadioGroup<String>(
                  groupValue: booking.status,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      booking.status = value;
                    });
                    _dispatchBookingUpdate();
                  },
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        value: BookingStatusEnum.CONFIRMED,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          AppLocalizations.of(
                            context,
                          )!.bookingStatusConfirmedText,
                        ),
                      ),
                      RadioListTile<String>(
                        value: BookingStatusEnum.PENDING,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          AppLocalizations.of(
                            context,
                          )!.bookingStatusPendingText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getChildren() {
    return buildAccommodations.toList();
  }

  Iterable<Widget> get buildAccommodations sync* {
    var accommodations = booking.accommodations;

    for (var i = 0; i < accommodations.length; i++) {
      Accommodation accommodation = accommodations[i];

      yield SingleAccommodation(accommodation: accommodation, booking: booking);
    }
  }
}
