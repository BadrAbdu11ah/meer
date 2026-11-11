import 'package:geolocator/geolocator.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/constant/city_info.dart';

class LocationService {
  /// يحاول تحديد مدينة المستخدم من موقعه الحالي.
  /// يرجع null إذا رُفض الإذن أو الخدمة مغلقة أو كان خارج المدن المدعومة.
  Future<MeerCity?> detectCity() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return null;
      }

      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 10),
        ),
      );

      return nearestCity(position.latitude, position.longitude);
    } catch (_) {
      return null;
    }
  }

  /// أقرب مدينة مدعومة، أو null إذا كان الموقع بعيدًا عن جميع المدن.
  MeerCity? nearestCity(double latitude, double longitude) {
    MeerCity? nearest;
    var nearestDistance = double.infinity;

    for (final city in MeerCity.values) {
      final distance = Geolocator.distanceBetween(
        latitude,
        longitude,
        city.centerLatitude,
        city.centerLongitude,
      );

      if (distance < nearestDistance) {
        nearest = city;
        nearestDistance = distance;
      }
    }

    if (nearestDistance > cityDetectionRadiusMeters) {
      return null;
    }

    return nearest;
  }
}
