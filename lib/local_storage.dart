import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

	static final LocalStorage _instance = LocalStorage._privateConstructor();

	factory LocalStorage() {
		return _instance;
	}

	late SharedPreferences _prefs;

	LocalStorage._privateConstructor() {
		SharedPreferences.getInstance().then((prefs) {
			if ( prefs != null) {
				_prefs = prefs;
			}
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
			! domain.isEmpty &&
			! consumer_key.isEmpty &&
			! consumer_secret.isEmpty
		);
	}

	void clear() async {
		await _prefs.clear();
	}

}
