import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'authWraped';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }

  get userPhone {
    return _prefs.getString('phone');
  }

  set userPhone(String phone) {
    _prefs.setString('phone', phone);
  }

  get userId {
    return _prefs.getString('userId');
  }

  set userId(String userName) {
    _prefs.setString('userId', userName);
  }
}
