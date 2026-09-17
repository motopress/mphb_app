import 'package:flutter/material.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';
import 'package:mphb_app/models/customer.dart';
import 'package:mphb_app/models/enum/booking_status.dart';

class Create_Booking extends Notification {
  String state = 'initial';
  String status = BookingStatusEnum.CONFIRMED;

  static const String INITIAL = 'initial';
  static const String CHECKOUT = 'checkout';
  static const String COMPLETE = 'complete';

  final List<Accommodation> accommodations = [];

  List<Reserved_Accommodation> reserved_accommodations = [];

  Customer customer = Customer.empty();

  String check_in_date = '';
  String check_out_date = '';

  Create_Booking();

  void reset() {
    reserved_accommodations = [];
  }

  Map<String, dynamic> toApiParams() => {
    'status': status,
    'check_in_date': check_in_date,
    'check_out_date': check_out_date,
    'reserved_accommodations': reserved_accommodations
        .map(
          (room) => {
            'accommodation': room.accommodation,
            'adults': room.adults,
            'children': room.children,
          },
        )
        .toList(),
    'customer': {
      'first_name': customer.first_name,
      'last_name': customer.last_name,
      'email': customer.email,
      'phone': customer.phone,
    },
  };

  bool hasValidCustomerEmail() {
    final email = customer.email.trim();
    if (email.isEmpty) return true;
    return RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?)+$",
    ).hasMatch(email);
  }

  bool isReadyForSubmit() {
    return reserved_accommodations.isNotEmpty && hasValidCustomerEmail();
  }
}
