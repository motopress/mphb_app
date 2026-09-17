import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:mphb_app/controller/basic_controller.dart';
import 'package:mphb_app/models/form_model.dart';
import 'package:mphb_app/screens/scanner.dart';
import 'package:mphb_app/local_storage.dart';
import 'package:mphb_app/l10n/app_localizations.dart';

class LoginForm extends StatefulWidget {
	const LoginForm({Key? key}) : super(key: key);

	@override
	_LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
	final _formKey = GlobalKey<FormState>();

	final model = FormModel();

	final domainController = TextEditingController();
	final keyController = TextEditingController();
	final secretController = TextEditingController();

	bool _loggingIn = false;

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
	void dispose() {
		domainController.dispose();
		keyController.dispose();
		secretController.dispose();
		super.dispose();
	}

	void qr_code_scanner() async {
		/*
		 * Web issue
		 * https://github.com/juliuscanute/qr_code_scanner/issues/441
		 */

		await Navigator.push(
			context,
			MaterialPageRoute(builder: (context) => Scanner()),
		).then((formModel) {
			if (formModel.isEmpty) {
				ScaffoldMessenger.of(context).clearSnackBars();
				ScaffoldMessenger.of(context).showSnackBar(SnackBar(
					backgroundColor: Colors.red,
					content: Text(AppLocalizations.of(context)!.invalidQRCodeMessage),
				));
			}

			domainController.text = formModel.domain;
			keyController.text = formModel.consumer_key;
			secretController.text = formModel.consumer_secret;
		});
	}

	void login() async {
		if (_loggingIn) {
			return;
		}

		// Validate returns true if the form is valid, or false otherwise.
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();

			setState(() {
				_loggingIn = true;
			});

			try {
				await BasicController.validateCredentials(
					domain: model.domain,
					consumerKey: model.consumer_key,
					consumerSecret: model.consumer_secret,
				);

				if (!mounted) {
					return;
				}

				LocalStorage().domain = BasicController.normalizeDomain(model.domain);
				LocalStorage().consumer_key = model.consumer_key.trim();
				LocalStorage().consumer_secret = model.consumer_secret.trim();

				Navigator.pushReplacementNamed(context, '/home');
			} catch (error) {
				if (!mounted) {
					return;
				}

				ScaffoldMessenger.of(context).clearSnackBars();
				ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
						backgroundColor: Colors.red,
						content: Text(error.toString()),
					)
				);
			} finally {
				if (mounted) {
					setState(() {
						_loggingIn = false;
					});
				}
			}
		}
	}

	@override
	Widget build(BuildContext context) {
		final ColorScheme colorScheme = Theme.of(context).colorScheme;
		final TextTheme textTheme = Theme.of(context).textTheme;
		final bodyTextStyle = textTheme.bodyMedium!.apply(
			fontSizeFactor: 0.8
		);

		return Scaffold(
			body: Center(
				child: SingleChildScrollView(
					child: Container(
						padding: const EdgeInsets.only(
								left: 20.0, right: 20.0, top: 30.0, bottom: 30.0),
						child: Column(
								crossAxisAlignment: CrossAxisAlignment.center,
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									Container(
										constraints: const BoxConstraints(maxWidth: 600),
										padding: EdgeInsets.only(
												left: 20.0, right: 20.0, top: 30.0, bottom: 30.0),
										decoration: BoxDecoration(
											color: Colors.white,
											borderRadius: BorderRadius.all(Radius.circular(6)),
											boxShadow: [
												BoxShadow(
													color: Colors.grey.withOpacity(0.15),
													spreadRadius: 4,
													blurRadius: 16,
													offset: Offset(0, 10),
												),
											],
										),
										child: Column(children: [
											ElevatedButton.icon(
												onPressed: () => qr_code_scanner(),
												icon: Icon(Icons.qr_code_scanner),
												label: Text(
													AppLocalizations.of(context)!.scanQRCodeButtonText,
													style: const TextStyle(fontSize: 16),
												),
												style: ElevatedButton.styleFrom(
													padding: EdgeInsets.only(
														top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
													minimumSize: Size(double.infinity, 0),
												),
											),
											SizedBox(height: 20.0),
											Text(
												// _textInstructions,
												AppLocalizations.of(context)!.textInstructions,
												style: const TextStyle(fontSize: 12),
												textAlign: TextAlign.center,
											),
											SizedBox(height: 15.0),
											Form(
												key: _formKey,
												child: Column(
													children: [
														TextFormField(
															controller: domainController,
															decoration: InputDecoration(
																hintText: 'https://mywebsite.com',
																labelText: AppLocalizations.of(context)!.domainLabelText,
																border: OutlineInputBorder(),
															),
															validator: (value) {
																if (value == null || value.isEmpty) {
																	return AppLocalizations.of(context)!.domainValidatorMessage;
																}
																final uri = Uri.tryParse(value);
																if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
																	return 'Enter a valid HTTPS domain';
																}
																return null;
															},
															onSaved: (value) {
																model.domain = (value ?? '').trim();
															},
														),
														SizedBox(height: 10),
														TextFormField(
															controller: keyController,
															decoration: InputDecoration(
																hintText: 'ck_xxxxxxxxxx',
																labelText: AppLocalizations.of(context)!.keyLabelText,
																border: OutlineInputBorder(),
															),
															validator: (value) {
																if (value == null || value.isEmpty) {
																	return AppLocalizations.of(context)!.keyValidatorMessage;
																}
																return null;
															},
															onSaved: (value) {
																model.consumer_key = (value ?? '').trim();
															},
														),
														SizedBox(height: 10),
														TextFormField(
															controller: secretController,
															decoration: InputDecoration(
																hintText: 'cs_xxxxxxxxxx',
																labelText: AppLocalizations.of(context)!.secretLabelText,
																border: OutlineInputBorder(),
															),
															obscureText: true,
															validator: (value) {
																if (value == null || value.isEmpty) {
																	return AppLocalizations.of(context)!.secretValidatorMessage;
																}
																return null;
															},
															onSaved: (value) {
																model.consumer_secret = (value ?? '').trim();
															},
														),
														SizedBox(height: 25),
														OutlinedButton(
															style: OutlinedButton.styleFrom(
																minimumSize: Size(double.infinity, 0),
																padding: EdgeInsets.all(15),
															),
															onPressed: _loggingIn ? null : login,
															child: _loggingIn
																? SizedBox(
																	height: 18,
																	width: 18,
																	child: CircularProgressIndicator(strokeWidth: 2),
																)
																: Text(
																	AppLocalizations.of(context)!.submitButtonText,
																),
														),
													],
												),
											),
										]),
									),
								SizedBox(height: 25.0),
								SizedBox(height: 25.0),


									SizedBox(height: 25.0),


									SelectableText.rich(
										TextSpan(
											children: [
												TextSpan(
													style: bodyTextStyle,
													text: '${_packageInfo.appName} application by ',
												),
												TextSpan(
													text: 'MotoPress',
													style: bodyTextStyle.copyWith(
														color: colorScheme.primary,
													),
													recognizer: TapGestureRecognizer()
														..onTap = () async {
															final url = 'https://motopress.com';
															if (await canLaunch(url)) {
																await launch(
																	url,
																	forceSafariVC: false,
																);
															}
														},
												),
											],
										),
									),
									SizedBox(height: 5.0),
									Text(
										'Version: ${_packageInfo.version} build ${_packageInfo.buildNumber}',
										style: const TextStyle(fontSize: 11),
										textAlign: TextAlign.center,
									),
								]),
					),
				),
			),
		);
	}
}
