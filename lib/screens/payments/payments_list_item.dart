import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mphb_app/screens/payment_detail/payment_detail.dart';
import 'package:mphb_app/models/payment.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mphb_app/models/enum/payment_status.dart';

class PaymentListItem extends StatefulWidget {

	final Payment payment;
	final PagingController pagingController;
	final int index;

	const PaymentListItem({
		required this.pagingController,
		required this.index,
		required this.payment,
		Key? key
	}) : super(key: key);

	@override
	_PaymentListItemState createState() => _PaymentListItemState( payment: this.payment );

}

class _PaymentListItemState extends State<PaymentListItem> {

	_PaymentListItemState({
		required this.payment
	});

	late Payment payment;

	void _showPaymentDetails(BuildContext context) async {

		final Payment newPayment = await Navigator.push(
			context,
			MaterialPageRoute(builder: (context) => PaymentDetailScreen( payment: payment )),
		);
		//print(newPayment);

		if ( widget.payment.status != newPayment.status ) {
			widget.payment.status = newPayment.status;
			widget.pagingController.notifyListeners();
		}
	}

	@override
	Widget build(BuildContext context) {

		return Container(
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
						offset: Offset(0, 2),
					),
				],
			),
			margin: EdgeInsets.only(bottom: 10.0),
			child: InkWell(
				onTap: () {
					_showPaymentDetails(context);
				},
				child: Padding(
					padding: EdgeInsets.all(15),
					child: Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: [
							Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Row(
										children: [
											Padding(
												padding: EdgeInsets.only(right: 10.0),
												child: Row(
													//crossAxisAlignment: CrossAxisAlignment.baseline,
													//textBaseline: TextBaseline.ideographic,
													children: [
														Text(
															payment.amount.toString(),
															style: TextStyle(fontWeight: FontWeight.bold),
														),
														Padding(
															padding: EdgeInsets.only(left: 5.0),
															child: Text(
																payment.currency,
																style: TextStyle(
																	fontSize: 12,
																),
															),
														),
														Padding(
															padding: EdgeInsets.only(right: 3.0, left: 10.0),
															child: Icon(
																Icons.credit_card,
																size: 12,
																color: Colors.indigo.shade100
															)
														),
														Text(
															payment.gateway_id,
															style: TextStyle(
																fontSize: 12,
															),
														),
													]
												),
											),
										]
									),
									Container(
										padding: EdgeInsets.only(top: 15.0),
										child: Row(
											children: [
												Padding(
													padding: EdgeInsets.only(right: 1.0),
													child: Icon(
														Icons.tag,
														size: 12,
														color: Colors.indigo.shade100
													)
												),
												Text(
													payment.id.toString(),
													style: TextStyle(
														fontSize: 12,
													),
												),
												Padding(
													padding: EdgeInsets.only(right: 3.0, left: 8.0),
													child: Icon(
														Icons.event_available,
														size: 12,
														color: Colors.indigo.shade100
													)
												),
												Text(
													DateFormat('yyyy-MM-dd').format( DateTime.parse(payment.date_created) ),
													style: TextStyle(
														fontSize: 12,
													),
												),
												Padding(
													padding: EdgeInsets.only(right: 3.0, left: 8.0),
													child: Icon(
														Icons.description,
														size: 12,
														color: Colors.indigo.shade100
													)
												),
												Text(
													payment.booking_id.toString(),
													style: TextStyle(
														fontSize: 12,
													),
												),
											]
										),
									),
								]
							),
							Flexible(
								child: Container(
									padding: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 6.0, right: 6.0),
									decoration: ShapeDecoration(
										shape: RoundedRectangleBorder(
											borderRadius: BorderRadius.all(
												Radius.circular(4)
											)
										),
										color:
											(payment.status == PaymentStatusEnum.COMPLETED || payment.status == PaymentStatusEnum.ON_HOLD) ?
												Colors.green
											: (payment.status == PaymentStatusEnum.CANCELLED || payment.status == PaymentStatusEnum.REFUNDED) ?
												Colors.orange
											:  Colors.blueGrey,
									),
									child: Text(
										payment.status,
										style: TextStyle(color: Colors.white, fontSize: 12),
										overflow: TextOverflow.ellipsis,
									),
								),
							),
						]
					),
				),
			),
		);
  }
}