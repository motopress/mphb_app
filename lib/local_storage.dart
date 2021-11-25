import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

	static final LocalStorage _instance = LocalStorage._privateConstructor();

	factory LocalStorage() {
		return _instance;
	}

	late SharedPreferences _prefs;
	final Future<SharedPreferences> _prefsFuture = SharedPreferences.getInstance();

	LocalStorage._privateConstructor() {

		_prefsFuture.then((SharedPreferences prefs) {
			_prefs = prefs;
		});
	}

	set domain(String value) => (
		_prefs.setString('domain', value)
	);

	String get domain => (
		_prefs.getString('domain') ?? ''
	);

	set consumer_key(String value) => (
		_prefs.setString('consumer_key', value)
	);

	String get consumer_key => (
		_prefs.getString('consumer_key') ?? ''
	);

	set consumer_secret(String value) => (
		_prefs.setString('consumer_secret', value)
	);

	String get consumer_secret => (
		_prefs.getString('consumer_secret') ?? ''
	);

	bool hasData() {

		return (
			! LocalStorage().domain.isEmpty &&
			! LocalStorage().consumer_key.isEmpty &&
			! LocalStorage().consumer_secret.isEmpty
		);
	}

	void clear() async {
		await _prefs.clear();
	}

}
