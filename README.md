# mphb_app

## How to start
1. open command line
1. run `flutter run -d web-server --web-port 9999`
1. open `http://localhost:9999/` in browser

`port` paramenter is set to save SharedPreferences for each session, [more](https://stackoverflow.com/questions/59503499/flutter-web-shared-preferences-not-available-when-tab-is-closed-and-reopened).