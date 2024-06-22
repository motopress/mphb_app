class BookingInternalNote {

    final String note;
    final String date_utc;
    final int user;

	BookingInternalNote({
		required this.note,
		required this.date_utc,
		required this.user,
	});

	factory BookingInternalNote.fromJson(Map<String, dynamic> json) {
		return BookingInternalNote(
			note: json['note'] as String,
			date_utc: json['date_utc'] as String,
			user: json['user'] is int ? json['user'] : int.tryParse( json['user'] ),
		);
	}

}
