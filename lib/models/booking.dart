import 'package:collection/collection.dart';
import 'package:mphb_app/models/rate.dart';
import 'package:mphb_app/models/service.dart';
import 'package:mphb_app/models/customer.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';
import 'package:mphb_app/models/payment.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/accommodation_type.dart';
import 'package:mphb_app/models/booking_embeded.dart';
import 'package:mphb_app/models/booking_internal_note.dart';

class Booking {

	final int id;
	String status;
	final String date_created;
	final String date_created_utc;
	final String key;
	final String check_in_date;
	final String check_out_date;
	final String check_in_time;
	final String check_out_time;

	final Customer customer;

	final List<Reserved_Accommodation> reserved_accommodations;

	final String coupon_code;
	final String currency;
	final num total_price;

	final List<Payment> payments;

	final bool imported;
	final String ical_description;
	final String ical_prodid;
	final String ical_summary;
	final String note;

	final List internal_notes;

	final BookingEmbeded? embedded;

	Booking({
		required this.id,
		required this.status,
		required this.date_created,
		required this.date_created_utc,
		required this.key,
		required this.check_in_date,
		required this.check_out_date,
		required this.check_in_time,
		required this.check_out_time,
		required this.customer,
		required this.reserved_accommodations,
		required this.coupon_code,
		required this.currency,
		required this.total_price,
		required this.payments,
		required this.imported,
		required this.ical_description,
		required this.ical_prodid,
		required this.ical_summary,
		required this.note,
		required this.internal_notes,
		required this.embedded,
	});

	factory Booking.fromJson(Map<String, dynamic> json) {

		return Booking(

			id: json['id'],
			status: json['status'],
			date_created: json['date_created'],
			date_created_utc: json['date_created_utc'],
			key: json['key'],
			check_in_date: json['check_in_date'],
			check_out_date: json['check_out_date'],
			check_in_time: json['check_in_time'],
			check_out_time: json['check_out_time'],
			customer: Customer.fromJson( json['customer'] ),
			reserved_accommodations: json['reserved_accommodations'].cast<Map<String, dynamic>>().
				map<Reserved_Accommodation>((json) => Reserved_Accommodation.fromJson(json)).toList(),
			coupon_code: json['coupon_code'],
			currency: json['currency'],
			total_price: json['total_price'],
			payments: json['payments'].cast<Map<String, dynamic>>().
				map<Payment>((json) => Payment.fromJson(json)).toList(),
			imported: json['imported'],
			ical_description: json['ical_description'],
			ical_prodid: json['ical_prodid'],
			ical_summary: json['ical_summary'],
			note: json['note'],
			internal_notes: json['internal_notes'].cast<Map<String, dynamic>>().
				map<BookingInternalNote>((json) => BookingInternalNote.fromJson(json)).toList(),
			embedded: json.containsKey( '_embedded' ) ?
				BookingEmbeded.fromJson( json['_embedded'] ) : null,
		);
	}

	num getPaid() {
		
		num paid = 0;
		
		for( Payment payment in payments ) {
			if (payment.status == 'completed') {
				paid += payment.amount;
			}
		}

		return paid;
	}

	num getToPay() {
		return total_price - getPaid();
	}

	Accommodation? getAccommodationByID( int id ) {

		return embedded?.accommodations?.firstWhereOrNull((element) => element.id == id);
	}

	Accommodation_Type? getAccommodationTypeByID( int id ) {

		return embedded?.accommodation_types?.firstWhereOrNull((element) => element.id == id);
	}
	
	Service? getServiceByID( int id ) {

		return embedded?.services?.firstWhereOrNull((element) => element.id == id);
	}

	Rate? getRateByID( int id ) {

		return embedded?.rates?.firstWhereOrNull((element) => element.id == id);
	}

}
