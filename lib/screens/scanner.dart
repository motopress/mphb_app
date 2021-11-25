import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mphb_app/models/form_model.dart';

class Scanner extends StatefulWidget {
	@override
	_ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {

	final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

	QRViewController? controller;

	Barcode? scannedCode;

	@override
	void dispose() {
		controller?.dispose();
		super.dispose();
	}

	@override
	void reassemble() {

		super.reassemble();
		if (Platform.isAndroid) {
			controller!.pauseCamera();
		} else if (Platform.isIOS) {
			controller!.resumeCamera();
		}
	}

	@override
	Widget build(BuildContext context) {

		var scanArea = (MediaQuery.of(context).size.width < 600 ||
					MediaQuery.of(context).size.height < 600)
				? 300.0
				: 400.0;

		return Scaffold(
			appBar: AppBar(
				title: Text("Scan a code"),
			),
			body: QRView(
				key: qrKey,
				onQRViewCreated: _onQRViewCreated,
				overlay: QrScannerOverlayShape(
					borderColor: Colors.red,
					borderRadius: 10,
					borderLength: 30,
					borderWidth: 10,
					cutOutSize: scanArea
				),
			),
			resizeToAvoidBottomInset: false,
		);
	}

	void _onQRViewCreated(QRViewController controller) {

		this.controller = controller;

		controller.scannedDataStream.listen((Barcode scanData) {

			// Stop repeatedly triggering onQRViewCreated
			if (this.scannedCode != null) {
				return;
			}

			controller.pauseCamera();
			this.scannedCode = scanData;

			String? rawData = scanData.code;
			FormModel formModel = FormModel();

			try {

				formModel = FormModel.fromRawData(rawData ?? '');				

			} on Exception catch (e) {}

			Navigator.pop( context, formModel );

		});
	}

}
