import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:meer_server/src/generated/protocol.dart';
import 'package:meer_server/src/generated/endpoints.dart';

const demoSellerEmail = 'demo-seed@meer.invalid';

Future<void> main(List<String> args) async {
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  // حماية من تشغيل بيانات الاختبار في بيئة غير التطوير.
  if (pod.runMode != 'development') {
    stderr.writeln(
      'تم إيقاف Seeder: يسمح بتشغيله في development فقط.',
    );
    exitCode = 1;
    return;
  }

  var started = false;

  try {
    await pod.start();
    started = true;

    final insertedCount = await pod.withSession((session) async {
      // البحث عن الأسرة التجريبية حتى لا تتكرر.
      var seller = await MeerUserProfile.db.findFirstRow(
        session,
        where: (profile) => profile.email.equals(demoSellerEmail),
      );

      if (seller == null) {
        seller = await MeerUserProfile.db.insertRow(
          session,
          MeerUserProfile(
            fullName: 'أسرة مِيْر التجريبية',
            phone: '0500000000',
            email: demoSellerEmail,
            role: 'seller',
            isSeller: true,
            address: 'المدينة المنورة - حي تجريبي',
            latitude: 24.5247,
            longitude: 39.5692,
            storeName: 'أسرة مِيْر التجريبية',
            storeDescription: 'أكلات منزلية للتجربة.',
            storeAddress: 'المدينة المنورة - حي تجريبي',
            storeCity: MeerCity.madinah,
            storeDistrict: 'حي تجريبي',
            storeLatitude: 24.5247,
            storeLongitude: 39.5692,
            createdAt: DateTime.now().toUtc(),
          ),
        );

        print('تم إنشاء الأسرة التجريبية.');
      } else {
        // الأسرة موجودة من تشغيل سابق: نحدّث بياناتها بدل تخطيها.
        seller.isSeller = true;
        seller.storeName ??= 'أسرة مِيْر التجريبية';
        seller.storeDescription ??= 'أكلات منزلية للتجربة.';
        seller.storeAddress ??= 'المدينة المنورة - حي تجريبي';
        seller.storeCity = MeerCity.madinah;
        seller.storeDistrict ??= 'حي تجريبي';
        seller.storeLatitude ??= 24.5247;
        seller.storeLongitude ??= 39.5692;

        seller = await MeerUserProfile.db.updateRow(session, seller);

        print('تم تحديث بيانات الأسرة التجريبية.');
      }

      final sellerId = seller.id;

      if (sellerId == null) {
        throw StateError(
          'لم يتم الحصول على معرّف الأسرة التجريبية.',
        );
      }

      final demoProducts =
          <
            ({
              String name,
              String description,
              double price,
              String imageUrl,
            })
          >[
            (
              name: 'كبسة دجاج منزلية',
              description: 'كبسة أرز بالدجاج مع التوابل المنزلية.',
              price: 38.0,
              imageUrl:
                  'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=800&q=80',
            ),
            (
              name: 'فطائر الجبن والزعتر',
              description: 'فطائر طازجة مناسبة للفطور.',
              price: 22.0,
              imageUrl:
                  'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=800&q=80',
            ),
            (
              name: 'كيكة الشوكولاتة',
              description: 'كيكة منزلية بطبقة من الشوكولاتة.',
              price: 65.0,
              imageUrl:
                  'https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=800&q=80',
            ),
            (
              name: 'معمول بالتمر',
              description: 'معمول منزلي محشو بالتمر.',
              price: 30.0,
              imageUrl:
                  'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=800&q=80',
            ),
            (
              name: 'سمبوسة الجبن',
              description: 'سمبوسة محضّرة منزليًا بحشوة الجبن.',
              price: 18.0,
              imageUrl:
                  'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=800&q=80',
            ),
            (
              name: 'صينية مكرونة بالبشاميل',
              description: 'صينية منزلية مناسبة للمشاركة العائلية.',
              price: 45.0,
              imageUrl:
                  'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=800&q=80',
            ),
            (
              name: 'لقيمات بالعسل',
              description: 'لقيمات محضّرة منزليًا.',
              price: 20.0,
              imageUrl:
                  'https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=800&q=80',
            ),
            (
              name: 'سلطة منزلية طازجة',
              description: 'سلطة خفيفة بمكونات طازجة.',
              price: 16.0,
              imageUrl:
                  'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=800&q=80',
            ),
          ];

      var inserted = 0;

      for (final demo in demoProducts) {
        // نتحقق من وجود المنتج بالاسم داخل الأسرة التجريبية.
        final existing = await Product.db.findFirstRow(
          session,
          where: (product) =>
              product.sellerId.equals(sellerId) &
              product.name.equals(demo.name),
        );

        if (existing != null) {
          print('تخطي المنتج الموجود: ${demo.name}');
          continue;
        }

        await Product.db.insertRow(
          session,
          Product(
            sellerId: sellerId,
            name: demo.name,
            description: demo.description,
            price: demo.price,
            imageUrl: demo.imageUrl,
            isAvailable: true,
            createdAt: DateTime.now().toUtc(),
          ),
        );

        inserted++;
        print('تمت إضافة المنتج: ${demo.name}');
      }

      return inserted;
    });

    print('');
    print('اكتمل Seeder بنجاح.');
    print('عدد المنتجات الجديدة: $insertedCount');
  } catch (error, stackTrace) {
    stderr.writeln('فشل تشغيل Seeder: $error');
    stderr.writeln(stackTrace);
    exitCode = 1;
  } finally {
    if (started) {
      await pod.shutdown(exitProcess: false);
    }
  }
}
