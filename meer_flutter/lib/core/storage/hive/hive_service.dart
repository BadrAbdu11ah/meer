import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();

  factory HiveService() => _instance;

  HiveService._internal();

  static const String cartBoxName = 'meer_cart';

  static const String favoritesBoxName = 'meer_favorites';

  late final Box<dynamic> cartBox;

  late final Box<dynamic> favoritesBox;

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();

    cartBox = await Hive.openBox<dynamic>(cartBoxName);

    favoritesBox = await Hive.openBox<dynamic>(
      favoritesBoxName,
    );

    _initialized = true;
  }
}
