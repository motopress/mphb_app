import 'package:flutter/material.dart';
import 'package:mphb_app/models/payments_filters.dart';
import 'package:mphb_app/models/enum/date_range.dart';
import 'package:mphb_app/models/enum/payment_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentsFilter extends StatefulWidget {

	final Payments_Filters payments_filters;

	const PaymentsFilter({
		required this.payments_filters,
		Key? key
	}) : super(key: key);

	@override
	_PaymentsFilterState createState() =>
		_PaymentsFilterState( payments_filters: this.payments_filters );

}

class _PaymentsFilterState extends State<PaymentsFilter> {

	_PaymentsFilterState({
		required this.payments_filters
	});

	Payments_Filters payments_filters;

	static List _paymentStatusesOptions(BuildContext context) {
		return [
			{'label': AppLocalizations.of(context).paymentCompletedOptionText, 'value': PaymentStatusEnum.COMPLETED},
			{'label': AppLocalizations.of(context).paymentCanceledOptionText, 'value': PaymentStatusEnum.CANCELLED},
			{'label': AppLocalizations.of(context).paymentAbandonedOptionText, 'value': PaymentStatusEnum.ABANDONED},
			{'label': AppLocalizations.of(context).paymentPendingOptionText, 'value': PaymentStatusEnum.PENDING},
			{'label': AppLocalizations.of(context).paymentFailedOptionText, 'value': PaymentStatusEnum.FAILED},
			{'label': AppLocalizations.of(context).paymentRefundedOptionText, 'value': PaymentStatusEnum.REFUNDED},
			{'label': AppLocalizations.of(context).paymentOnHoldOptionText, 'value': PaymentStatusEnum.ON_HOLD},
		];
	}

 static List _paymentDateRangeOptions(BuildContext context) {
    return [
      {'label': AppLocalizations.of(context).todayOptionText, 'value': DateRangeEnum.TODAY},
      {'label': AppLocalizations.of(context).thisWeekOptionText, 'value': DateRangeEnum.THIS_WEEK},
      {'label': AppLocalizations.of(context).thisMonthOptionText, 'value': DateRangeEnum.THIS_MONTH},
    ];
  }

	Iterable<Widget> get paymentStatusesFilter sync* {
		for (final status in _paymentStatusesOptions(context)) {
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
								payments_filters.post_status.removeWhere(
									(String value) {
										return value == status['value'];
									}
								);
							}
						});
					},
				),
			);
		}
	}

	Iterable<Widget> get paymentDateRangeFilter sync* {
		for (final range in _paymentDateRangeOptions(context)) {
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

	void reset() {
		setState(() {
			payments_filters = new Payments_Filters();
		});
	}

	@override
	Widget build(BuildContext context) {

		return WillPopScope(
			child: Scaffold(
				backgroundColor: const Color(0xFFF4F5F8),
				appBar: AppBar(
					title: Text(AppLocalizations.of(context).filtersTitleText),
					actions: <Widget>[
						Padding(
							padding: EdgeInsets.all(10.0),
							child: TextButton(
								onPressed: reset,
								child: Text(AppLocalizations.of(context).resetButtonText),
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
												child: Text(AppLocalizations.of(context).paymentStatusLabelText + ':'),
											),
											Wrap(
												children: paymentStatusesFilter.toList(),
											),
											SizedBox(height: 10),
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
												child: Text(AppLocalizations.of(context).dateCreatedLabelText + ':')
											),
											Wrap(
												children: paymentDateRangeFilter.toList(),
											),
											SizedBox(height: 10),
										],
									),
								),
							],
						),
					),
				),
			),
			onWillPop: () async {
				Navigator.pop(context, payments_filters);
				return false;
			}
		);
	}

}
