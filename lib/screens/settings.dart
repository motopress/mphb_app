import 'package:flutter/material.dart';
import 'package:mphb_app/local_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {

	const SettingsPage({Key? key}) : super(key: key);

	@override
	_SettingsPageState createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage> {

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

	_showAlertDialog(BuildContext context) {

		// set up the buttons
		Widget cancelButton = TextButton(
			child: Text(AppLocalizations.of(context).cancelButttonText),
			onPressed:  () {
				Navigator.of(context).pop(); // dismiss dialog
			},
		);
		Widget continueButton = TextButton(
			child: Text(AppLocalizations.of(context).logoutButtonText),
			onPressed:  () {
				LocalStorage().clear();
				Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
			},
		);

		// set up the AlertDialog
		AlertDialog alert = AlertDialog(
			title: Text(AppLocalizations.of(context).confirmLogoutMessage),
			actions: [
				cancelButton,
				continueButton,
			],
		);

		// show the dialog
		showDialog(
			context: context,
			builder: (BuildContext context) {
				return alert;
			},
		);
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: AppBar(
				title: Text(AppLocalizations.of(context).settingsLabelText),
				shape: Border(
					bottom: BorderSide(
						color: const Color(0xFFF4F5F8),
						width: 1
					)
				),
			),
			body: Center(
				child: Container(
					padding: const EdgeInsets.all(20.0),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.center,
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Text(
								LocalStorage().domain.replaceAll('/wp-json/mphb/v1', ''),
								textAlign: TextAlign.center,
							),
							SizedBox(height: 10.0),
							Text(
								AppLocalizations.of(context).consumerKeyEndingInLabelText + ': ' +
								LocalStorage().consumer_key.substring(
									LocalStorage().consumer_key.length - 7),
							),
							SizedBox(height: 25.0),
							Text(
								'Version: ${_packageInfo.version} build ${_packageInfo.buildNumber}',
								style: const TextStyle(fontSize: 11),
								textAlign: TextAlign.center,
							),
							SizedBox(height: 25.0),
							OutlinedButton(
								onPressed: () {
									_showAlertDialog(context);
								},
								child: Text(AppLocalizations.of(context).logoutButtonText),
							),
						]
					),
				),
			),
		);
	}
}
