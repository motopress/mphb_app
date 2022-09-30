import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mphb_app/controller/bookings_controller.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:mphb_app/screens/calendar/booking_list_item.dart';
import 'package:mphb_app/screens/calendar/calendar_filter.dart';
import 'package:mphb_app/models/calendar_filters.dart';
import 'package:mphb_app/screens/bookings/create/create_booking.dart';

class CalendarPage extends StatefulWidget {
	@override
	_TableEventsState createState() => _TableEventsState();
}

class _TableEventsState extends State<CalendarPage> {

	bool _loading = false;

	final StartingDayOfWeek startingDayOfWeek = StartingDayOfWeek.monday;
	final bool sixWeekMonthsEnforced = false;

	CalendarFormat _calendarFormat = CalendarFormat.month;
	RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.disabled;

	late final ValueNotifier<List<Booking>> _selectedEvents;

	DateTime _focusedDay = DateTime.now();
	DateTime? _selectedDay;

	late DateTime _firstDay;
	late DateTime _lastDay;

	LinkedHashMap? kEvents;

	late final BookingsController _bookingsController;
	late Calendar_Filters _calendar_filters;

	Map<DateTimeRange, List<Booking>> _dataProvider = {};

	@override
	void initState() {

		super.initState();

		//today
		_focusedDay = DateUtils.dateOnly( _focusedDay );

		_firstDay = DateTime(_focusedDay.year - 1);
		_lastDay = DateTime(_focusedDay.year + 1, 12, 31);

		_selectedEvents = ValueNotifier( [] );

		_bookingsController = new BookingsController();
		_calendar_filters = new Calendar_Filters();

		_getData();
	}

	void _getData( {bool forceUpdate = false} ) async {

		setState(() {
			_loading = true;
		});

		DateTimeRange visibleRange = _getVisibleRange( _calendarFormat, _focusedDay );

		String start = new DateFormat("yyyy-MM-dd").format( visibleRange.start );
		String end   = new DateFormat("yyyy-MM-dd").format( visibleRange.end );

		//print(start);
		//print(end);

		List<Booking> bookings = [];

		if ( _dataProvider.containsKey( visibleRange ) && ! forceUpdate ) {

			bookings = _dataProvider[ visibleRange ] ?? [];

		} else {

			Map<String, dynamic>filters = _calendar_filters.toMap();

			filters['filter[meta_key]'] = 'mphb_check_in_date';
			filters['filter[orderby]'] = 'meta_value';
			filters['filter[meta_type]'] = 'DATE';

			filters['filter[meta_query][1][key]'] = 'mphb_check_in_date';
			filters['filter[meta_query][1][compare]'] = 'BETWEEN';
			filters['filter[meta_query][1][type]'] = 'DATE';
			filters['filter[meta_query][1][value]'] = '$start,$end'; //'2022-07-01,2022-12-31'

			/*
			* TODO: limit, https://developer.wordpress.org/rest-api/using-the-rest-api/pagination/
			*/
			int offset = 0;
			int limit = 100;

			List<Booking> _bookings = [];

			try {

				await Future.doWhile( () async {
					
					_bookings = await _bookingsController.wpGetAllBookings( offset, limit, filters);

					bookings.addAll( _bookings );
					offset += _bookings.length;

					return _bookings.length == limit;
				});

				_dataProvider[ visibleRange ] = bookings;

			} catch (error) {

				print(error);
				ScaffoldMessenger.of(context).clearSnackBars();
				ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(content: Text(error.toString()))
				);
			}
		}

		Map<DateTime, List<Booking>> kEventSource = {};
		kEvents?.clear();

		bookings.forEach((element) {

			var check_in_date = DateTime.parse( element.check_in_date );
			var key = DateTime(
				check_in_date.year,
				check_in_date.month,
				check_in_date.day,
			);

			kEventSource[ key ] = kEventSource[ key ] != null ?
				[ ...kEventSource[ key ]!, element ] : [element];

		});

		kEvents = LinkedHashMap<DateTime, List<Booking>>(
			equals: isSameDay,
			hashCode: getHashCode,
		)..addAll(kEventSource);

		setState(() {
			_loading = false;
		});
	}

	List<Booking> _getEventsForDay(DateTime day) {

		return kEvents?[day] ?? [];
	}

	void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {

		if ( ! isSameDay(_selectedDay, selectedDay) ) {

			setState(() {
				_selectedDay = selectedDay;
				_focusedDay = focusedDay;
			});

			_selectedEvents.value = _getEventsForDay(selectedDay);
		} else {

			setState(() {
				_selectedDay = null;
				_selectedEvents.value = [];
			});
		}
	}

	void _onFormatChanged( CalendarFormat format ) {
		if (_calendarFormat != format) {
			setState(() {
				_calendarFormat = format;
			});

			_getData();
		}
	}

	void _onPageChanged( DateTime focusedDay ) {
		// No need to call `setState()` here
		_focusedDay = focusedDay;

		_getData();
	}

	void _onHeaderTapped( DateTime focusedDay ) {
		setState(() {
			_focusedDay = DateTime.now();
			_selectedDay = null;
			_selectedEvents.value = [];
		});
	}

	void createBookingCallback( Booking booking ) {
		//TODO
	}

	void deleteBookingCallback( int index ) {

		Booking booking;

		//update list & calendar
		booking = _selectedEvents.value.removeAt( index );
		_selectedEvents.notifyListeners();

		//update dataProvider
		DateTimeRange visibleRange = _getVisibleRange( _calendarFormat, _focusedDay );

		if ( (booking is Booking) && _dataProvider.containsKey( visibleRange ) ) {

			List<Booking> bookings = _dataProvider[ visibleRange ] ?? [];
			bookings.removeWhere((item) => item.id == booking.id);
		}

		setState(() {});
	}

	void updateBookingCallback( int index ) {

		_selectedEvents.notifyListeners();
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: AppBar(
				title: Text('Calendar'),
				shape: Border(
					bottom: BorderSide(
						color: const Color(0xFFF4F5F8),
						width: 1
					)
				),
				actions: <Widget>[
					
					if ( _loading == true )
						Center(
							child: Padding(
								padding: const EdgeInsets.all(14),
								child: SizedBox(
									child: CircularProgressIndicator(
										color: Colors.black,
										strokeWidth: 2.0,
									),
									height: 20.0,
									width: 20.0,
								),
							),
						),
					// endif
					IconButton(
						icon: const Icon(Icons.add_circle_outline),
						tooltip: 'New Booking',
						onPressed: () async {
							await Navigator.push(context, MaterialPageRoute (
								builder: (BuildContext context) {
									return CreateBookingPage(
										createBookingCallback:createBookingCallback
									);
								},
							)).then((value) {
							});
						},
					),
					IconButton(
						icon: const Icon(Icons.sync),
						tooltip: 'Refresh',
						onPressed: () {
							setState(() {
								_selectedDay = null;
								_selectedEvents.value = [];
							});
							_getData( forceUpdate: true );
						},
					),
					Stack(
						alignment: Alignment.center,
						children: <Widget>[
							IconButton(
								icon: const Icon(Icons.filter_list),
								tooltip: 'Filter',
								onPressed: () async {
									await Navigator.push(context, MaterialPageRoute (
										builder: (BuildContext context) {
											return CalendarFilter(
												calendar_filters: _calendar_filters.clone()
											);
										},
									)).then((calendar_filters) {

										if ( ! calendar_filters.equals(_calendar_filters) ) {
											setState(() {
												_calendar_filters = calendar_filters;
												_selectedDay = null;
												_selectedEvents.value = [];
											});
											
											_dataProvider.clear();
											_getData();
										}
									});
								},
							),
							if ( ! _calendar_filters.isEmpty() )
								IgnorePointer(
									child: Center(
										child: Container(
											height: 24.0,
											width: 24.0,
											child: Align(
												alignment: Alignment.topRight,
												child: Container(
													width: 10,
													height: 10,
													decoration: BoxDecoration(
														shape: BoxShape.circle,
														color: Colors.yellow,
													),
												),
											),
										),
									),
								),
						],
					),
				],
			),
			body: SingleChildScrollView(
				child: Column(
					children: [
						Container(
							decoration: BoxDecoration(
								gradient: LinearGradient(
									begin: Alignment.topCenter,
									end: FractionalOffset.bottomCenter,
									colors: [Colors.white, Color(0xFFF4F5F8)],
									stops: [0, 1],
								),
							),
							//https://github.com/aleksanderwozniak/table_calendar
							child: TableCalendar<Booking>(
								firstDay: _firstDay,
								lastDay: _lastDay,
								focusedDay: _focusedDay,
								selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
								calendarFormat: _calendarFormat,
								rangeSelectionMode: _rangeSelectionMode,
								eventLoader: _getEventsForDay,
								startingDayOfWeek: startingDayOfWeek,
								availableGestures: AvailableGestures.horizontalSwipe,
								sixWeekMonthsEnforced: sixWeekMonthsEnforced,
								daysOfWeekHeight: 50.0,
								calendarStyle: CalendarStyle(
									defaultTextStyle: TextStyle(color: Colors.black),
									weekendTextStyle: TextStyle(color: Colors.black),
									todayTextStyle: TextStyle(color: Colors.black),
									cellMargin: EdgeInsets.all(5.0),
									selectedDecoration: BoxDecoration(
										color: Colors.indigo,
										shape: BoxShape.circle,
									),
									todayDecoration: BoxDecoration(
										color: Colors.white,
										border: Border.all(color: Colors.indigo),
										shape: BoxShape.circle,
									),
									defaultDecoration: BoxDecoration(
										color: Colors.white,
										shape: BoxShape.circle,
										border: Border.all(color: Colors.indigo.shade50),
									),
									weekendDecoration: BoxDecoration(
										color: Colors.white,
										shape: BoxShape.circle,
										border: Border.all(color: Colors.indigo.shade50),
									),
								),
								headerStyle: HeaderStyle(
									formatButtonDecoration: BoxDecoration(
										border: Border.fromBorderSide(BorderSide(color: Colors.indigo.shade50),),
										borderRadius: BorderRadius.all(Radius.circular(12.0)),
									),
									headerPadding: EdgeInsets.only(top: 16.0),
								),
								onDaySelected: _onDaySelected,
								onFormatChanged: _onFormatChanged,
								onPageChanged: _onPageChanged,
								onHeaderTapped: _onHeaderTapped,
								calendarBuilders: CalendarBuilders(

									markerBuilder: (context, date, events) {
										if (events.isNotEmpty) {
											return Positioned(
												right: 4,
												top: 4,
												child: _buildEventsMarker(date, _focusedDay, events),
											);
										}
									},
								),
							),
						),
						const SizedBox(height: 16.0),
						ValueListenableBuilder<List<Booking>>(
							valueListenable: _selectedEvents,
							builder: (context, value, _) {

								return ListView.builder(
									physics: const NeverScrollableScrollPhysics(),
									shrinkWrap: true,
									padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
									itemCount: value.length,
									itemBuilder: (context, index) {

										return BookingListItem(
											index: index,
											booking: value[index],
											key: ObjectKey(value[index]),
											deleteBookingCallback: deleteBookingCallback,
											updateBookingCallback: updateBookingCallback,
										);
									},
								);
							},
						),
					],
				),
			),
		);
	}

	int getHashCode(DateTime key) {

		return key.day * 1000000 + key.month * 10000 + key.year;
	}

	bool isSameDay(DateTime? a, DateTime? b) {

		if (a == null || b == null) {
			return false;
		}

		return a.year == b.year && a.month == b.month && a.day == b.day;
	}

	DateTimeRange _getVisibleRange(CalendarFormat format, DateTime focusedDay) {
		switch (format) {
			case CalendarFormat.month:
				return _daysInMonth(focusedDay);
			case CalendarFormat.twoWeeks:
				return _daysInTwoWeeks(focusedDay);
			case CalendarFormat.week:
				return _daysInWeek(focusedDay);
			default:
				return _daysInMonth(focusedDay);
		}
	}

	DateTimeRange _daysInWeek(DateTime focusedDay) {
		final daysBefore = _getDaysBefore(focusedDay);
		final firstToDisplay = focusedDay.subtract(Duration(days: daysBefore));
		final lastToDisplay = firstToDisplay.add(const Duration(days: 7));
		return DateTimeRange(start: firstToDisplay, end: lastToDisplay);
	}

	DateTimeRange _daysInTwoWeeks(DateTime focusedDay) {
		final daysBefore = _getDaysBefore(focusedDay);
		final firstToDisplay = focusedDay.subtract(Duration(days: daysBefore));
		final lastToDisplay = firstToDisplay.add(const Duration(days: 14));
		return DateTimeRange(start: firstToDisplay, end: lastToDisplay);
	}

	DateTimeRange _daysInMonth(DateTime focusedDay) {
		final first = _firstDayOfMonth(focusedDay);
		final daysBefore = _getDaysBefore(first);
		final firstToDisplay = first.subtract(Duration(days: daysBefore));

		if (sixWeekMonthsEnforced) {
		  final end = firstToDisplay.add(const Duration(days: 42));
		  return DateTimeRange(start: firstToDisplay, end: end);
		}

		final last = _lastDayOfMonth(focusedDay);
		final daysAfter = _getDaysAfter(last);
		final lastToDisplay = last.add(Duration(days: daysAfter));

		return DateTimeRange(start: firstToDisplay, end: lastToDisplay);
	}

	DateTime _firstDayOfMonth(DateTime month) {
		return DateTime.utc(month.year, month.month, 1);
	}

	DateTime _lastDayOfMonth(DateTime month) {
		final date = month.month < 12
		    ? DateTime.utc(month.year, month.month + 1, 1)
		    : DateTime.utc(month.year + 1, 1, 1);
		return date.subtract(const Duration(days: 1));
	}

	int _getDaysBefore(DateTime firstDay) {
		return (firstDay.weekday + 7 - getWeekdayNumber(startingDayOfWeek)) % 7;
	}

	int _getDaysAfter(DateTime lastDay) {
		int invertedStartingWeekday = 8 - getWeekdayNumber(startingDayOfWeek);

		int daysAfter = 7 - ((lastDay.weekday + invertedStartingWeekday) % 7);
		if (daysAfter == 7) {
		  daysAfter = 0;
		}

		return daysAfter;
	}

	@override
	void dispose() {

		_selectedEvents.dispose();
		super.dispose();
	}

}
 
Widget _buildEventsMarker(DateTime date, DateTime focusedDay, List events) {
	return Container(
		decoration: BoxDecoration(
			shape: BoxShape.rectangle,
			borderRadius: BorderRadius.circular(10),
			color: 
				focusedDay.month != date.month ? Colors.grey.shade600 :
					DateTime.now().isBefore( date ) ? Colors.indigo : Colors.black,
		),
		width: 16.0,
		height: 16.0,
		padding: const EdgeInsets.all(1.0),
		child: Center(
			child: FittedBox(
				fit: BoxFit.fitWidth,
				child: Text(
					'${events.length}',
					style: TextStyle().copyWith(
						color: Colors.white,
						fontSize: 11.0,
					),
				),
			),
		),
	);
}
