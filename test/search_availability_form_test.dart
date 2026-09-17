import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mphb_app/l10n/app_localizations.dart';
import 'package:mphb_app/screens/bookings/create/search_availability_form.dart';

void main() {
  testWidgets('single-date and range pickers stay synchronized', (
    tester,
  ) async {
    Map? submitted;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(
          body: SearchAvailabilityForm(
            callback: (params) => submitted = params,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final fields = find.byType(TextFormField);
    String value(int index) =>
        tester.widget<TextFormField>(fields.at(index)).controller!.text;
    final today = DateTime.parse(value(0));
    DateTime day(int offset) =>
        DateTime(today.year, today.month, today.day + offset);
    String formatted(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
    Future<void> openSingle(int index) async {
      await tester.tap(fields.at(index));
      await tester.pumpAndSettle();
    }

    Future<void> choose(DateTime date) async {
      tester
          .widget<CalendarDatePicker>(find.byType(CalendarDatePicker))
          .onDateChanged(date);
      await tester.pump();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
    }

    Future<void> openRange() async {
      await tester.tap(find.byIcon(Icons.date_range_outlined));
      await tester.pumpAndSettle();
    }

    await openSingle(1);
    var single = tester.widget<DatePickerDialog>(find.byType(DatePickerDialog));
    expect(single.firstDate, day(1));
    await choose(day(5));
    expect(value(0), formatted(today));
    expect(value(1), formatted(day(5)));

    await openSingle(0);
    await choose(day(2));
    expect(value(1), formatted(day(5)));
    await openSingle(0);
    await choose(day(5));
    expect(value(1), formatted(day(6)));

    await openRange();
    final rangeFinder = find.byType(DateRangePickerDialog);
    final range = tester.widget<DateRangePickerDialog>(rangeFinder);
    expect(range.initialDateRange, DateTimeRange(start: day(5), end: day(6)));
    expect(range.selectableDayPredicate!(day(5), day(5), null), isFalse);
    expect(range.selectableDayPredicate!(day(6), day(5), null), isTrue);
    expect(
      range.selectableDayPredicate!(range.lastDate, day(5), range.lastDate),
      isTrue,
    );
    Navigator.of(
      tester.element(rangeFinder),
    ).pop(DateTimeRange(start: day(7), end: day(10)));
    await tester.pumpAndSettle();
    expect(value(0), formatted(day(7)));
    expect(value(1), formatted(day(10)));

    await openSingle(1);
    single = tester.widget<DatePickerDialog>(find.byType(DatePickerDialog));
    expect(single.initialDate, day(10));
    expect(single.firstDate, day(8));
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    await openRange();
    Navigator.of(tester.element(find.byType(DateRangePickerDialog))).pop();
    await tester.pumpAndSettle();
    expect(value(0), formatted(day(7)));
    expect(value(1), formatted(day(10)));

    await tester.tap(find.byType(OutlinedButton));
    await tester.pump();
    expect(submitted!['check_in_date'], formatted(day(7)));
    expect(submitted!['check_out_date'], formatted(day(10)));
  });
}
