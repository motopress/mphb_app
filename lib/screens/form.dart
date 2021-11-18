import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mphb_app/models/form_model.dart';
import 'package:mphb_app/screens/scanner.dart';
import 'package:mphb_app/local_storage.dart';

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
	const MyCustomForm({Key? key}) : super(key: key);

	@override
	MyCustomFormState createState() {
		return MyCustomFormState();
	}
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {

	// Create a global key that uniquely identifies the Form widget
	// and allows validation of the form.
	//
	// Note: This is a GlobalKey<FormState>,
	// not a GlobalKey<MyCustomFormState>.
	final _formKey = GlobalKey<FormState>();
	
	final model = FormModel();

	@override
	void initState() {
		// TODO: implement initState
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		// Build a Form widget using the _formKey created above.
		return new Scaffold(
			body: Center(
				child: Container(

					padding: const EdgeInsets.all(36.0),
					child: Column(

						crossAxisAlignment: CrossAxisAlignment.center,
						mainAxisAlignment: MainAxisAlignment.center,

						children: <Widget>[
							Container(
								padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0, bottom: 30.0),

								decoration: BoxDecoration(
									color: Colors.white,
									borderRadius: BorderRadius.all(
										Radius.circular(6)
									),
									boxShadow: [
										BoxShadow(
											color: Colors.grey.withOpacity(0.15),
											spreadRadius: 4,
											blurRadius: 16,
											offset: Offset(0, 10), // changes position of shadow
										),
									],
								),

								child: Column(
									children: [

										Text(
											'Setup',
											style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
										),
										SizedBox(height: 25.0),

										OutlinedButton.icon(
											onPressed: () {

												/*
												 * Web issue
												 * https://github.com/juliuscanute/qr_code_scanner/issues/441
												 */												
												Navigator.push(
												context,
													MaterialPageRoute(builder: (context) => Scanner()),
												);

											},
											icon: Icon(Icons.qr_code_scanner),
											label: Text("Scan QRCode"),
											style: OutlinedButton.styleFrom(
												padding: EdgeInsets.all(10),
											),
										),

										SizedBox(height: 25.0),

										Form(
											key: _formKey,
											child: Column(
												children: [
													TextFormField(
														initialValue: "https://uglywebsites.org/booking-api/wp-json/mphb/v1",
														decoration: const InputDecoration(
															hintText: 'Domain',
															labelText: 'Domain',
															border: OutlineInputBorder(),
														),
														// The validator receives the text that the user has entered.
														validator: (value) {
															if (value == null || value.isEmpty) {
																return 'Please enter some text';
															}
															return null;
														},
														onSaved: (value) {
															model.domain = value ?? '';
														},
													),
													SizedBox(height: 30),
													TextFormField(
														initialValue: "ck_09c4163541fb26930cf9531ba1601f711f5c1ab9",
														decoration: const InputDecoration(
															hintText: 'consumer_key',
															labelText: 'Key',
															border: OutlineInputBorder(),
														),
														// The validator receives the text that the user has entered.
														validator: (value) {
															if (value == null || value.isEmpty) {
																return 'Please enter some text';
															}
															return null;
														},
														onSaved: (value) {
															model.consumer_key = value ?? '';
														},
													),
													SizedBox(height: 30),
													TextFormField(
														initialValue: "cs_47fd90af2ca6ec49dcb9b5ad73766cd6545c25a8",
														decoration: const InputDecoration(
															hintText: 'consumer_secret',
															labelText: 'Secret',
															border: OutlineInputBorder(),
														),
														obscureText: true,
														// The validator receives the text that the user has entered.
														validator: (value) {
															if (value == null || value.isEmpty) {
																return 'Please enter some text';
															}
															return null;
														},
														onSaved: (value) {
															model.consumer_secret = value ?? '';
														},
													),
													SizedBox(height: 30),
													ElevatedButton(
														style: ElevatedButton.styleFrom(
															minimumSize: Size(double.infinity, 50), // double.infinity is the width and 50 is the height
															padding: EdgeInsets.all(10),
														),
														onPressed: () {
															// Validate returns true if the form is valid, or false otherwise.
															if (_formKey.currentState!.validate()) {

																_formKey.currentState!.save();

																// set value
																LocalStorage().domain = model.domain;
																LocalStorage().consumer_key = model.consumer_key;
																LocalStorage().consumer_secret = model.consumer_secret;
																
																Navigator.pushReplacementNamed(context, '/bookings');
															}
														},
														child: const Text(
															'Submit',
														),
													),
												],
											),
										),
									]
								),
							),
						]
					),
				),
			),
		);
	}
}
