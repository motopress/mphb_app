import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {

	static final LocalStorage _instance = LocalStorage._privateConstructor();

	factory LocalStorage() {
		return _instance;
	}

	late SharedPreferences _prefs;
	final Future<SharedPreferences> _prefsFuture = SharedPreferences.getInstance();
	final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

	static const String _domainKey = 'domain';
	static const String _consumerKeyKey = 'consumer_key';
	static const String _consumerSecretKey = 'consumer_secret';

	String _consumerKey = '';
	String _consumerSecret = '';
	bool _initialized = false;

	LocalStorage._privateConstructor() {

		_prefsFuture.then((SharedPreferences prefs) {
			_prefs = prefs;
		});
	}

	Future<void> init() async {
		if (_initialized) {
			return;
		}

		_prefs = await _prefsFuture;

		_consumerKey = await _secureStorage.read(key: _consumerKeyKey) ?? '';
		_consumerSecret = await _secureStorage.read(key: _consumerSecretKey) ?? '';

		final prefsConsumerKey = _prefs.getString(_consumerKeyKey) ?? '';
		final prefsConsumerSecret = _prefs.getString(_consumerSecretKey) ?? '';

		if (_consumerKey.isEmpty && prefsConsumerKey.isNotEmpty) {
			_consumerKey = prefsConsumerKey;
			await _secureStorage.write(key: _consumerKeyKey, value: prefsConsumerKey);
			await _prefs.remove(_consumerKeyKey);
		}

		if (_consumerSecret.isEmpty && prefsConsumerSecret.isNotEmpty) {
			_consumerSecret = prefsConsumerSecret;
			await _secureStorage.write(key: _consumerSecretKey, value: prefsConsumerSecret);
			await _prefs.remove(_consumerSecretKey);
		}

		_initialized = true;
	}

	set domain(String value) => (
		_prefs.setString(_domainKey, value)
	);

	String get domain => (
		_prefs.getString(_domainKey) ?? ''
	);

	set consumer_key(String value) {
		_consumerKey = value;
		_secureStorage.write(key: _consumerKeyKey, value: value);
	}

	String get consumer_key => (
		_consumerKey
	);

	set consumer_secret(String value) {
		_consumerSecret = value;
		_secureStorage.write(key: _consumerSecretKey, value: value);
	}

	String get consumer_secret => (
		_consumerSecret
	);

	bool hasData() {

		return (
			! LocalStorage().domain.isEmpty &&
			! LocalStorage().consumer_key.isEmpty &&
			! LocalStorage().consumer_secret.isEmpty
		);
	}

	void clear() async {
		_consumerKey = '';
		_consumerSecret = '';
		await _secureStorage.delete(key: _consumerKeyKey);
		await _secureStorage.delete(key: _consumerSecretKey);
		await _prefs.clear();
	}

}
