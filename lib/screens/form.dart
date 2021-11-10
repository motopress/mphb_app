import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
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

	late SharedPreferences sharedPreferences;

	@override
	void initState() {
		// TODO: implement initState
		super.initState();
		initialGetSaved();
	}

	void initialGetSaved() async{
		sharedPreferences = await SharedPreferences.getInstance();
	}

	@override
	Widget build(BuildContext context) {
		// Build a Form widget using the _formKey created above.
		return new Scaffold(
			body:
				Center(
					child: Container(
					color: Colors.white,
					child: Padding(
						padding: const EdgeInsets.all(36.0),
						child:
							Column(

								crossAxisAlignment: CrossAxisAlignment.center,
								mainAxisAlignment: MainAxisAlignment.center,

								children: <Widget>[
									Text(
										'Setup',
										style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
									),
									SizedBox(height: 25.0),

									Container(
										decoration: BoxDecoration(
											border: Border.all(color: Colors.black, width: 2),
											color: Colors.white,
											shape: BoxShape.circle,
										),
										child: IconButton(
											icon: const Icon(Icons.qr_code_scanner),
											tooltip: 'Scan QRCode',
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
										),
									),

									SizedBox(height: 25.0),
									Form(
										key: _formKey,
										child: Column(
											children: [
												TextFormField(
													initialValue: "uglywebsites.org",
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
														labelText: 'consumer_key',
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
														labelText: 'consumer_secret',
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
												Padding(
													padding: const EdgeInsets.symmetric(vertical: 30.0),
													child: ElevatedButton(
														style: ElevatedButton.styleFrom(
															minimumSize: Size(double.infinity, 50), // double.infinity is the width and 30 is the height
														),
														onPressed: () {
															// Validate returns true if the form is valid, or false otherwise.
															if (_formKey.currentState!.validate()) {
																
																_formKey.currentState!.save();
																//print(model.domain);
																
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
												),
											],
										),
									),
								]
							),
						)
					)
				)
		);
	}
}
