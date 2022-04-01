import 'package:flutter/material.dart';
import 'dart:async';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:mphb_app/models/form_model.dart';
import 'package:mphb_app/screens/scanner.dart';
import 'package:mphb_app/local_storage.dart';

class MyCustomForm extends StatefulWidget {

	const MyCustomForm({Key? key}) : super(key: key);

	@override
	_MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {

	final _formKey = GlobalKey<FormState>();
	
	final model = FormModel();

	final domainController = TextEditingController();
	final keyController = TextEditingController();
	final secretController = TextEditingController();

	PackageInfo _packageInfo = PackageInfo(
		appName: 'Unknown',
		packageName: 'Unknown',
		version: 'Unknown',
		buildNumber: 'Unknown',
		buildSignature: 'Unknown',
	);

	@override
	void initState() {
		super.initState();
		_initPackageInfo();
	}

	Future<void> _initPackageInfo() async {
		final info = await PackageInfo.fromPlatform();
		setState(() {
			_packageInfo = info;
		});
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			body: Center(
				child: SingleChildScrollView(
					child: Container(

						padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0, bottom: 30.0),
						child: Column(

							crossAxisAlignment: CrossAxisAlignment.center,
							mainAxisAlignment: MainAxisAlignment.center,

							children: <Widget>[
								Container(
									padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0, bottom: 30.0),

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

											ElevatedButton.icon(
												onPressed: () async {

													/*
													 * Web issue
													 * https://github.com/juliuscanute/qr_code_scanner/issues/441
													 */												

													await Navigator.push(
														context,
														MaterialPageRoute(builder: (context) => Scanner()),
													).then((formModel) {

														if ( formModel.isEmpty ) {

															ScaffoldMessenger.of(context).removeCurrentSnackBar();
															ScaffoldMessenger.of(context).showSnackBar(
																SnackBar(
																	backgroundColor: Colors.red,
																	content: Text( 'QR code is not valid.' ),
																)
															);
														}

														domainController.text = formModel.domain;
														keyController.text = formModel.consumer_key;
														secretController.text = formModel.consumer_secret;
													});

												},
												icon: Icon(Icons.qr_code_scanner),
												label: Text(
													"Scan QR Code",
													style: const TextStyle(fontSize: 16),
												),
												style: ElevatedButton.styleFrom(
													padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
													minimumSize: Size(double.infinity, 0),
												),
											),

											SizedBox(height: 30.0),

											Text(
												'Navigate to Settings > Advanced to generate API keys and scan QR code. Or enter your data in the form below.',
												style: const TextStyle(fontSize: 12),
												textAlign: TextAlign.center,
											),
											SizedBox(height: 25.0),

											Form(
												key: _formKey,
												child: Column(
													children: [
														Row(
															mainAxisAlignment: MainAxisAlignment.spaceBetween,
															children: [
																TextButton(
																	onPressed: () {
																		domainController.text = 'https://uglywebsites.org/booking-api';
																		keyController.text = 'ck_09c4163541fb26930cf9531ba1601f711f5c1ab9';
																		secretController.text = 'cs_47fd90af2ca6ec49dcb9b5ad73766cd6545c25a8';
																	},
																	child: Text("Demo Data"),
																),
																TextButton(
																	onPressed: () {
																		domainController.text = '';
																		keyController.text = '';
																		secretController.text = '';
																	},
																	child: Text("Clear"),
																),
															],
														),
														SizedBox(height: 10),

														TextFormField(
															controller: domainController,
															decoration: const InputDecoration(
																hintText: 'https://mywebsite.com',
																labelText: 'Domain',
																//floatingLabelBehavior: FloatingLabelBehavior.always,
																//border: OutlineInputBorder(),
															),
															validator: (value) {
																if (value == null || value.isEmpty) {
																	return 'Please enter Domain';
																}
																return null;
															},
															onSaved: (value) {
																model.domain = value ?? '';
															},
														),
														SizedBox(height: 10),
														TextFormField(
															//initialValue: "ck_09c4163541fb26930cf9531ba1601f711f5c1ab9",
															controller: keyController,
															decoration: const InputDecoration(
																hintText: 'ck_xxxxxxxxxx',
																labelText: 'Key',
																//floatingLabelBehavior: FloatingLabelBehavior.always,
																//border: OutlineInputBorder(),
															),
															validator: (value) {
																if (value == null || value.isEmpty) {
																	return 'Please enter Key';
																}
																return null;
															},
															onSaved: (value) {
																model.consumer_key = value ?? '';
															},
														),
														SizedBox(height: 10),
														TextFormField(
															//initialValue: "cs_47fd90af2ca6ec49dcb9b5ad73766cd6545c25a8",
															controller: secretController,
															decoration: const InputDecoration(
																hintText: 'cs_xxxxxxxxxx',
																labelText: 'Secret',
																//floatingLabelBehavior: FloatingLabelBehavior.always,
																//border: OutlineInputBorder(),
															),
															obscureText: true,
															validator: (value) {
																if (value == null || value.isEmpty) {
																	return 'Please enter Secret';
																}
																return null;
															},
															onSaved: (value) {
																model.consumer_secret = value ?? '';
															},
														),
														SizedBox(height: 25),
														OutlinedButton(
															style: OutlinedButton.styleFrom(
																minimumSize: Size(double.infinity, 0),
																padding: EdgeInsets.all(15),
															),
															onPressed: () {
																// Validate returns true if the form is valid, or false otherwise.
																if (_formKey.currentState!.validate()) {

																	_formKey.currentState!.save();

																	// trim slash
																	if ( model.domain.endsWith('/') ) {
																		model.domain = model.domain.substring(0, model.domain.length - 1);
																	}

																	/*
																	 * https://developer.wordpress.org/rest-api/extending-the-rest-api/routes-and-endpoints/
																	 * 
																	 * 1. All routes should be built onto this route, the wp-json portion can be changed,
																	 *    but in general, it is advised to keep it the same.
																	 * 2. On sites without pretty permalinks, the route is instead added to the URL as the
																	 *    rest_route parameter. For the above example, the full URL would then be
																	 *    http://example.com/?rest_route=/wp/v2/posts/123
																	 */

																	 //TODO: make it better
																	if ( model.domain.endsWith( '/wp-json/mphb/v1' ) ) {

																		LocalStorage().domain = model.domain;

																	} else {

																		LocalStorage().domain = model.domain + '/wp-json/mphb/v1';
																	}

																	LocalStorage().consumer_key = model.consumer_key;
																	LocalStorage().consumer_secret = model.consumer_secret;
																	
																	Navigator.pushReplacementNamed(context, '/home');
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

								SizedBox(height: 25.0),								
								Text(
									'Hotel Booking Application by MotoPress.',
									style: const TextStyle(fontSize: 11),
									textAlign: TextAlign.center,
								),

								SizedBox(height: 5.0),
								Text(
									'Version: ${_packageInfo.version} build ${_packageInfo.buildNumber}',
									style: const TextStyle(fontSize: 11),
									textAlign: TextAlign.center,
								),
							]
						),
					),
				),
			),
		);
	}
}
