import 'package:flutter/material.dart';
import 'package:mphb_app/models/payments_filters.dart';
import 'package:mphb_app/models/enum/date_range.dart';
import 'package:mphb_app/models/enum/payment_status.dart';

class PaymentsFilter extends StatefulWidget {

	final Payments_Filters payments_filters;

	const PaymentsFilter({
		required this.payments_filters,
		Key? key
	}) : super(key: key);

	@override
	_PaymentsFilterState createState() => _PaymentsFilterState( payments_filters: this.payments_filters );

}

class _PaymentsFilterState extends State<PaymentsFilter> {

	_PaymentsFilterState({
		required this.payments_filters
	});

	Payments_Filters payments_filters;

	final List _paymentStatusesOptions = [
		const {'label': 'Completed', 'value': PaymentStatusEnum.COMPLETED},
		const {'label': 'Cancelled', 'value': PaymentStatusEnum.CANCELLED},
		const {'label': 'Abandoned', 'value': PaymentStatusEnum.ABANDONED},
		const {'label': 'Pending', 'value': PaymentStatusEnum.PENDING},
		const {'label': 'Failed', 'value': PaymentStatusEnum.FAILED},
		const {'label': 'Refunded', 'value': PaymentStatusEnum.REFUNDED},
		const {'label': 'On Hold', 'value': PaymentStatusEnum.ON_HOLD},
	];

	final List _paymentDateRangeOptions = [
		const {'label': 'Today', 'value': DateRangeEnum.TODAY},
		const {'label': 'This Week', 'value': DateRangeEnum.THIS_WEEK},
		const {'label': 'This Month', 'value': DateRangeEnum.THIS_MONTH},
	];

	Iterable<Widget> get paymentStatusesFilter sync* {
		for (final status in _paymentStatusesOptions) {
			yield Padding(
				padding: const EdgeInsets.all(4.0),
				child: FilterChip(
					label: Text(status['label']),
					selected: payments_filters.post_status.contains(status['value']),
					onSelected: (bool value) {
						setState(() {
							if (value) {
								payments_filters.post_status.add(status['value']);
							} else {
								payments_filters.post_status.removeWhere((String value) {
									return value == status['value'];
								});
							}
						});
					},
				),
			);
		}
	}

	Iterable<Widget> get paymentDateRangeFilter sync* {
		for (final range in _paymentDateRangeOptions) {
			yield Padding(
				padding: const EdgeInsets.all(4.0),
				child: ChoiceChip(
					label: Text(range['label']),
					selected: payments_filters.date_range == range['value'],
					onSelected: (bool value) {
						setState(() {
							if (value) {
								payments_filters.date_range = range['value'];
							} else {
								payments_filters.date_range = '';
							}
						});
					},
				),
			);
		}
	}

	void close() {
		Navigator.of(context).pop(
			payments_filters
		);
	}

	void reset() {
		setState(() {
			payments_filters = new Payments_Filters();
		});
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			backgroundColor: Colors.white,
			appBar: AppBar(
				title: const Text('Filters'),
				actions: <Widget>[
					Padding(
						padding: EdgeInsets.all(10.0),
						child: TextButton(
							onPressed: reset,
							child: const Text('Reset'),
							style: TextButton.styleFrom(
								primary: Colors.black,
							),
						),
					),
				],
			),
			body: SingleChildScrollView(
				child: Container(
					padding: const EdgeInsets.all(20.0),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.start,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[

							Container(
								margin: const EdgeInsets.only(top: 0.0),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Padding(
											padding: const EdgeInsets.only(bottom: 10.0),
											child: Text('Payment Status:'),
										),
										Wrap(
											children: paymentStatusesFilter.toList(),
										),
										SizedBox(height: 10),
										//Text('Look for: ${payments_filters.post_status.join(', ')}'),
									],
								),
							),
							Container(
								margin: const EdgeInsets.only(top: 20.0),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Padding(
											padding: const EdgeInsets.only(bottom: 10.0),
											child: Text('Date Range:'),
										),
										Wrap(
											children: paymentDateRangeFilter.toList(),
										),
										SizedBox(height: 10),
										//Text('Look for: ${payments_filters.date_range}'),
									],
								),
							),
						],
					),
				),
			),

			persistentFooterButtons: [
				ElevatedButton(
					style: ElevatedButton.styleFrom(
						minimumSize: Size(double.infinity, 50), // double.infinity is the width and 50 is the height
						padding: EdgeInsets.all(10),
					),
					onPressed: close,
					child: const Text('Apply'),
				),
			],
		);

	}

}
