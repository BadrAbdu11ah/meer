import 'package:meer_client/meer_client.dart';

/// أقصى مسافة (بالمتر) بين موقع المستخدم ومركز المدينة
/// لاعتباره داخل المدينة عند التحديد التلقائي.
const double cityDetectionRadiusMeters = 60000;

/// بيانات عرض المدن المدعومة.
/// عند إضافة مدينة: أضفها في MeerCity (ملف meer_city.spy.yaml)
/// ثم أضف حالتها هنا، وسيطلب منك المترجم ذلك تلقائيًا.
extension MeerCityInfo on MeerCity {
  String get label => switch (this) {
    MeerCity.madinah => 'المدينة المنورة',
  };

  double get centerLatitude => switch (this) {
    MeerCity.madinah => 24.4686,
  };

  double get centerLongitude => switch (this) {
    MeerCity.madinah => 39.6142,
  };
}
