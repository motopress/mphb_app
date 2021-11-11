import 'package:mphb_app/models/customer.dart';
import 'package:mphb_app/models/reserved_accommodations.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';
import 'package:mphb_app/models/payment.dart';

class Booking {

	final int id;
	final String status;
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
	final double total_price;

	final List<Payment> payments;

	final bool imported;
	final String ical_description;
	final String ical_prodid;
	final String ical_summary;
	final String note;

	final List internal_notes;

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
	});

	factory Booking.fromJson(Map<String, dynamic> json) {

		var reserved_accommodations = Reserved_Accommodations.fromJson( json );

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
			reserved_accommodations: reserved_accommodations,
			coupon_code: json['coupon_code'],
			currency: json['currency'],
			total_price: json['total_price'],
			payments: json['payments'].cast<Map<String, dynamic>>().map<Payment>((json) => Payment.fromJson(json)).toList(),
			imported: json['imported'],
			ical_description: json['ical_description'],
			ical_prodid: json['ical_prodid'],
			ical_summary: json['ical_summary'],
			note: json['note'],
			internal_notes: json['internal_notes'],
		);
	}

	double getPaid() {
		
		double paid = 0;
		
		for( Payment payment in payments ) {
			if (payment.status == 'completed') {
				paid += payment.amount;
			}
		}

		return paid;
	}

	double getToPay() {
		return total_price - getPaid();
	}

}
