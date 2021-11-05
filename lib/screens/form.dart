import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mphb_app/models/form_model.dart';

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
			body: Column(
				children: <Widget>[
					Text(
						'Setup',
						style: Theme.of(context).textTheme.headline1,
					),
					Form(
						key: _formKey,
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								TextFormField(
									initialValue: "uglywebsites.org",
									decoration: const InputDecoration(
										hintText: 'Domain',
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
								TextFormField(
									initialValue: "ck_09c4163541fb26930cf9531ba1601f711f5c1ab9",
									decoration: const InputDecoration(
										hintText: 'consumer_key',
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
								TextFormField(
									initialValue: "cs_47fd90af2ca6ec49dcb9b5ad73766cd6545c25a8",
									decoration: const InputDecoration(
										hintText: 'consumer_secret',
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
									padding: const EdgeInsets.symmetric(vertical: 16.0),
									child: ElevatedButton(
										onPressed: () {
											// Validate returns true if the form is valid, or false otherwise.
											if (_formKey.currentState!.validate()) {
												
												_formKey.currentState!.save();
												//print(model.domain);
												
												// set value
												sharedPreferences.setString('domain', model.domain);
												sharedPreferences.setString('consumer_key', model.consumer_key);
												sharedPreferences.setString('consumer_secret', model.consumer_secret);
												
												Navigator.pushReplacementNamed(context, '/bookings');
											}
										},
										child: const Text('Submit'),
									),
								),
							],
						),
					),
				]
			),
		);
	}
}
