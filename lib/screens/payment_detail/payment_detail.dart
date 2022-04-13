import 'package:flutter/material.dart';
import 'package:mphb_app/controller/payment_controller.dart';
import 'package:mphb_app/models/payment.dart';
import 'package:mphb_app/screens/payment_detail/payment_detail_status.dart';
import 'package:mphb_app/screens/payment_detail/payment_detail_amount.dart';
import 'package:mphb_app/screens/payment_detail/payment_detail_booking.dart';
import 'package:mphb_app/screens/payment_detail/payment_detail_gateway.dart';
import 'package:mphb_app/screens/booking_detail/booking_detail_customer.dart';
import 'package:mphb_app/screens/payment_detail/payment_detail_actions.dart';

class PaymentDetailScreen extends StatefulWidget {

	const PaymentDetailScreen({Key? key, required this.payment}) : super(key: key);

	final Payment payment;

	@override
	_PaymentDetailScreenState createState() =>
		_PaymentDetailScreenState( paymentID: this.payment.id );

}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {

	_PaymentDetailScreenState({
		required this.paymentID
	});

	late final PaymentController _paymentController;

	late Future<Payment> _paymentFuture;

	final int paymentID;

	@override
	void initState() {

		_paymentController = new PaymentController();
		_paymentFuture = _getPayment( paymentID );

		super.initState();
	}

	Future<Payment> _getPayment( int id ) {

		var paymentFuture;

		try {

			paymentFuture = _paymentController.wpGetPayment( id );

		} catch (error) {

			paymentFuture = null;

			print(error);
			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(content: Text(error.toString()))
			);
		}

		return paymentFuture;
	}

	_showModalBottomSheet( BuildContext context, Payment payment ) {

		showModalBottomSheet(
			context: context,
			builder: (context) {
				return PaymentDetailActions( payment: payment );
			},

		).then((action) {

			if ( action != null ) {

				switch ( action ) {

					case 'delete':
						print('Delete payment!');
						break;

					default:
						try {

							setState(() {
								_paymentFuture =
									_paymentController.wpUpdatePaymentStatus(
										payment, action
									);
							});

						} catch (error) {

							print(error);
							ScaffoldMessenger.of(context).showSnackBar(
								SnackBar(
									content: Text(error.toString())
								)
							);
						}
						break;
				}
			}
		});
	}

	@override
	Widget build(BuildContext context) {

		return WillPopScope(
			child: Scaffold(
				appBar: AppBar(
					title: Text( 'Payment #$paymentID' ),
					actions: <Widget>[
						IconButton(
							icon: const Icon(Icons.sync),
							tooltip: 'Refresh',
							onPressed: () {
								setState(() {
									_paymentFuture = _getPayment( paymentID );
								});
							},
						),
						FutureBuilder(
							future: _paymentFuture,
							builder: (context, AsyncSnapshot snapshot) {
								if (snapshot.connectionState == ConnectionState.waiting) {
									return new Center(
										child: Padding(
											padding: const EdgeInsets.all(14),
											child: SizedBox(
												child: CircularProgressIndicator(
													color: Colors.black,
													strokeWidth: 2.0,
												),
												height: 20.0,
												width: 20.0,
											),
										),
									);
								} else if (snapshot.hasError) {
									return new Container();
								} else {

									Payment payment = snapshot.data;

									return IconButton(
										icon: const Icon(Icons.more_vert),
										tooltip: 'Actions',
										onPressed: () => _showModalBottomSheet( context, payment ),
									);
								}
							}
						),
					],
				),
				body: FutureBuilder(
					future: _paymentFuture,
					initialData: widget.payment,
					builder: (context, AsyncSnapshot snapshot) {

						if (snapshot.hasError) {

							return new Text('Error: ${snapshot.error}');
						} else {

							Payment payment = snapshot.data;

							return RefreshIndicator(
								onRefresh: () => Future.sync(
									() => setState(() {
										_paymentFuture = _getPayment( paymentID );
									}),
								),
								child: SingleChildScrollView(
									physics: AlwaysScrollableScrollPhysics(),
									child: Container(
										padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
										child: Column(
											children: [
												// payment id + status
												PaymentDetailStatus( payment: payment ),
												// amount
												PaymentDetailAmount( payment: payment ),
												// amount
												PaymentDetailBooking( payment: payment ),
												// gateway
												PaymentDetailGateway( payment: payment ),
												// billing info
												if ( ! payment.billing_info.isEmpty() )
													BookingDetailCustomer(
														customer: payment.billing_info ),
											],
										),
									),
								),
							);
						}
					}
				),
			),
			onWillPop: () async {
				Navigator.pop(context, _paymentFuture);
				return false;
			}
		);
	}
}
