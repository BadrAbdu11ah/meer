import 'package:meer_client/meer_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// يحتفظ بالمدينة المختارة حاليًا ويحفظها على الجهاز.
class CityLocalRepository {
  static const _key = 'selected_city';

  MeerCity _current = MeerCity.madinah;

  /// المدينة المختارة حاليًا (الافتراضي: المدينة المنورة).
  MeerCity get current => _current;

  /// يحمّل المدينة المحفوظة. يرجع true إذا وُجدت مدينة محفوظة.
  Future<bool> load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = MeerCity.values.asNameMap()[prefs.getString(_key)];

    if (saved == null) {
      return false;
    }

    _current = saved;
    return true;
  }

  Future<void> save(MeerCity city) async {
    _current = city;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, city.name);
  }
}
