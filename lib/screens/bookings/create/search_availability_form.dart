import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchAvailabilityForm extends StatefulWidget {

	final Function callback;

	const SearchAvailabilityForm({
		required this.callback,
		Key? key
	}) : super(key: key);

	@override
	_SearchAvailabilityFormState createState() => _SearchAvailabilityFormState();

}

class _SearchAvailabilityFormState extends State<SearchAvailabilityForm> {

	final _formKey = GlobalKey<FormState>();

	String _checkInDate = DateFormat('yyyy-MM-dd').format( DateTime.now() );
	String _checkOutDate = DateFormat('yyyy-MM-dd').format( DateTime.now().add(const Duration(days: 1)) );
	String _adults = '1';
	String _children = '0';

	@override
	Widget build(BuildContext context) {

		return Form(
			key: _formKey,
			child: Column(
				children: [
					Row(
						children: [
							Expanded(
								child: TextFormField(
									initialValue: _checkInDate,
									decoration: const InputDecoration(
										isDense: true,
										hintText: '1970-12-31',
										labelText: 'Check-in',
										floatingLabelBehavior: FloatingLabelBehavior.always,
										border: OutlineInputBorder(),
									),
									validator: (value) {
										if (value == null || value.isEmpty) {
											return 'Please enter date';
										}
										return null;
									},
									onChanged: (newValue) {
										setState(() {
											_checkInDate = newValue;
										});
									},
								),
							),
							SizedBox(width: 10),
							Expanded(
								child: TextFormField(
									initialValue: _checkOutDate,
									decoration: const InputDecoration(
										isDense: true,
										hintText: '1970-12-31',
										labelText: 'Check-in',
										floatingLabelBehavior: FloatingLabelBehavior.always,
										border: OutlineInputBorder(),
									),
									validator: (value) {
										if (value == null || value.isEmpty) {
											return 'Please enter date';
										}
										return null;
									},
									onChanged: (newValue) {
										setState(() {
											_checkOutDate = newValue;
										});
									},
								),
							),
						],
					),
					SizedBox(height: 10),
					Row(
						children: [
							Expanded(
								child: DropdownButtonFormField<String>(
									decoration: const InputDecoration(
										isDense: true,
										labelText: 'Adults',
										border: OutlineInputBorder(),
									),
									value: _adults,
									items: List<String>.generate(10, (i) => (i + 1).toString()).map((String value) {
										return DropdownMenuItem<String>(
											value: value,
											child: Text(value),
										);
									}).toList(),
									onChanged: (String? newValue) {
										setState(() {
											_adults = newValue!;
										});
									},
								)
							),
							SizedBox(width: 10),
							Expanded(
								child: DropdownButtonFormField<String>(
									decoration: const InputDecoration(
										isDense: true,
										labelText: 'Children',
										border: OutlineInputBorder(),
									),
									value: _children,
									items: List<String>.generate(11, (i) => (i).toString()).map((String value) {
										return DropdownMenuItem<String>(
											value: value,
											child: Text(value),
										);
									}).toList(),
									onChanged: (String? newValue) {
										setState(() {
											_children = newValue!;
										});
									},
								)
							),
						],
					),
					SizedBox(height: 10),
					Row(
						children: [
							Expanded(
								child: OutlinedButton(
									onPressed: () {
										if (_formKey.currentState!.validate()) {

											var params = {
												'check_in_date': _checkInDate,
												'check_out_date': _checkOutDate,
												'adults': _adults,
												'children': _children
											};
											widget.callback( params );
										}
									},
									child: const Text('Search',),
								),
							),
						]
					),
				]
			),
		);

	}

}
