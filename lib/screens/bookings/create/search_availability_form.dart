import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mphb_app/l10n/app_localizations.dart';

class SearchAvailabilityForm extends StatefulWidget {
  final Function callback;

  const SearchAvailabilityForm({required this.callback, Key? key})
    : super(key: key);

  @override
  _SearchAvailabilityFormState createState() => _SearchAvailabilityFormState();
}

class _SearchAvailabilityFormState extends State<SearchAvailabilityForm> {
  final _formKey = GlobalKey<FormState>();

  String _checkInDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _checkOutDate = DateFormat(
    'yyyy-MM-dd',
  ).format(DateTime.now().add(const Duration(days: 1)));

  String _adults = '1';
  String _children = '0';

  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();

  DateTime _nextDay(DateTime date) =>
      DateTime(date.year, date.month, date.day + 1);

  void _updateDates(DateTime checkIn, DateTime checkOut) {
    setState(() {
      _checkInDate = DateFormat('yyyy-MM-dd').format(checkIn);
      _checkOutDate = DateFormat('yyyy-MM-dd').format(checkOut);
      checkInController.text = _checkInDate;
      checkOutController.text = _checkOutDate;
    });
  }

  Future<void> _showSingleDatePicker({required bool checkIn}) async {
    final today = DateUtils.dateOnly(DateTime.now());
    final arrival = DateTime.parse(_checkInDate);
    final departure = DateTime.parse(_checkOutDate);
    final limit = DateTime(today.year + 10, 12, 31);
    final first = checkIn ? today : _nextDay(arrival);
    final current = checkIn ? arrival : departure;
    final selected = await showDatePicker(
      context: context,
      initialDate: current.isBefore(first) ? first : current,
      firstDate: first,
      lastDate: checkIn
          ? DateTime(limit.year, limit.month, limit.day - 1)
          : limit,
      helpText: checkIn
          ? AppLocalizations.of(context)!.checkInLabelText
          : AppLocalizations.of(context)!.checkOutLabelText,
      builder: _pickerTheme,
    );
    if (!mounted || selected == null) return;
    if (checkIn) {
      _updateDates(
        selected,
        departure.isAfter(selected) ? departure : _nextDay(selected),
      );
    } else {
      _updateDates(arrival, selected);
    }
  }

  Widget _pickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: ThemeData.light().copyWith(
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Color(0xFFF4F5F8),
          surfaceTintColor: Colors.transparent,
          rangePickerBackgroundColor: Color(0xFFF4F5F8),
          rangePickerSurfaceTintColor: Colors.transparent,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.indigo),
      ),
      child: child!,
    );
  }

  Future<void> _showDateRangePicker() async {
    final today = DateUtils.dateOnly(DateTime.now());
    final arrival = DateTime.parse(_checkInDate);
    final departure = DateTime.parse(_checkOutDate);
    final initialStart = arrival.isBefore(today) ? today : arrival;
    final limit = DateTime(today.year + 10, 12, 31);
    final range = await showDateRangePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDateRange: DateTimeRange(
        start: initialStart,
        end: departure.isAfter(initialStart)
            ? departure
            : _nextDay(initialStart),
      ),
      firstDate: today,
      lastDate: limit,
      selectableDayPredicate: (day, start, end) {
        if (start == null || end != null) return true;
        return !DateUtils.isSameDay(day, start);
      },
      builder: _pickerTheme,
    );
    if (!mounted || range == null) return;
    _updateDates(range.start, range.end);
  }

  @override
  void initState() {
    super.initState();

    checkInController.text = _checkInDate;
    checkOutController.text = _checkOutDate;
  }

  @override
  void dispose() {
    checkInController.dispose();
    checkOutController.dispose();

    super.dispose();
  }

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
                  controller: checkInController,
                  readOnly: true,
                  onTap: () => _showSingleDatePicker(checkIn: true),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: '1970-12-31',
                    labelText: AppLocalizations.of(context)!.checkInLabelText,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.dateValidatorMessage;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: checkOutController,
                  readOnly: true,
                  onTap: () => _showSingleDatePicker(checkIn: false),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: '1970-12-31',
                    labelText: AppLocalizations.of(context)!.checkOutLabelText,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.dateValidatorMessage;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.date_range_outlined),
                  onPressed: _showDateRangePicker,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: AppLocalizations.of(context)!.adultsLabelText,
                  ),
                  value: _adults,

                  items: List<String>.generate(30, (i) => (i + 1).toString())
                      .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),

                  onChanged: (String? newValue) {
                    setState(() {
                      _adults = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: AppLocalizations.of(context)!.childrenLabelText,
                  ),
                  value: _children,
                  items: List<String>.generate(31, (i) => (i).toString()).map((
                    String value,
                  ) {
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
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    //remove focus from fields
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }

                    if (_formKey.currentState!.validate()) {
                      var params = {
                        'check_in_date': _checkInDate,
                        'check_out_date': _checkOutDate,
                        'adults': _adults,
                        'children': _children,
                      };
                      widget.callback(params);
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.searchButtonText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
