import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mphb_app/models/form_model.dart';

class Scanner extends StatefulWidget {
	@override
	_ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {

	final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
	QRViewController? controller;

	@override
	void dispose() {
		controller?.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
	return Scaffold(
		appBar: AppBar(
			title: Text("Scanner"),
		),
		body: Stack(
			children: [
				Column(
					children: <Widget>[
						Expanded(
							flex: 5,
							child: Stack(
								children: [
									QRView(
										key: qrKey,
										onQRViewCreated: _onQRViewCreated,
									),
									Center(
										child: Container(
											width: 300,
											height: 300,
											decoration: BoxDecoration(
												border: Border.all(
													color: Colors.red,
													width: 4,
												),
												borderRadius: BorderRadius.circular(12),
											),
										),
									)
								],
							),
						),
						Expanded(
							flex: 1,
							child: Center(
								child: Text('Scan a code'),
							),
						)
					],
				),
			],
		),
	);
	}

	void _onQRViewCreated(QRViewController controller) {

		this.controller = controller;

		controller.scannedDataStream.listen((scanData) async {

			controller.pauseCamera();

			String? rawData = scanData.code;
			FormModel formModel = FormModel();
			
			try {
				formModel = FormModel.fromRawData(rawData ?? '');
			} on Exception catch (e) {
				print(e);
				controller.resumeCamera();
			}

			showDialog(
				context: context,
				builder: (BuildContext context) {
					return AlertDialog(
						title: Text('QRCode Data'),
						content: SingleChildScrollView(
							child: ListBody(
								children: <Widget>[
									Text('Data: ${formModel.domain}'),
									Text('Data: ${formModel.consumer_key}'),
									Text('Data: ${formModel.consumer_secret}'),
								],
							),
						),
						actions: <Widget>[
							TextButton(
								child: Text('Apply'),
								onPressed: () {
									Navigator.of(context).pop( formModel );
								},
							),
						],
					);
				},
			).then((value) => controller.resumeCamera());

		});
	}

}
