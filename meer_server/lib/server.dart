import 'dart:io';

import 'package:serverpod_auth_idp_server/core.dart';
// import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_auth_idp_server/providers/google.dart';
import 'package:serverpod_cloud_storage/serverpod_cloud_storage.dart';

import 'src/cache_busting.dart';
import 'src/future_calls/notification_outbox_future_call.dart';
import 'src/generated/serverpod.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/auth/phone_otp_idp_config.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod. The generated Serverpod class is already connected
  // with your project's generated code.
  final pod = Serverpod(args);

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      GoogleIdpConfigFromPasswords(),
      PhoneOtpIdpConfig(),
      // ServerpodCloudEmailIdpConfig(
      //   appDisplayName: 'meer',
      // ),
    ],
  );

  // Serve all files in the web/static relative directory under /web.
  // These are used by the default web page.
  pod.webServer.addRoute(
    StaticRoute.withCacheBusting(cacheBustingConfig),
    cacheBustingConfig.mountPrefix,
  );

  // Setup the app config route.
  // We build this configuration based on the servers api url and serve it to
  // the flutter app.
  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/assets/assets/config.json',
  );

  // Checks if the flutter web app has been built and serves it if it has.
  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    // Serve the flutter web app under /.
    pod.webServer.addRoute(
      FlutterRoute(
        appDir,
        // If building the Flutter app with WASM, set the below parameter to
        // true and add the --wasm flag to the flutter build command.
        enableWasmHeaders: false,
      ),
      '/',
    );
  } else {
    // If the flutter web app has not been built, serve the build app page.
    final defaultRoute = StaticRoute.file(
      File(
        Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
      ),
    );

    pod.webServer.addMiddleware(
      FallbackMiddleware(
        fallback: defaultRoute,
        on: (response) => response.statusCode == 404,
      ).call,
      '/',
    );

    pod.webServer.addRoute(
      defaultRoute,
      '/**',
    );
  }

  // Configure cloud storage.
  // This setup works with Serverpod Cloud without extra configuration.
  // If you want to use a custom provider for cloud storage, replace these
  // with your preferred provider.
  pod.addCloudStorage(
    await ServerpodCloudProvider.private(
      fallback: () => DatabaseCloudStorage('private'),
    ),
  );
  pod.addCloudStorage(
    await ServerpodCloudProvider.public(
      fallback: () => DatabaseCloudStorage('public'),
    ),
  );

  // Start the server.
  await pod.start();

  await _scheduleNotificationOutboxDispatch(pod);
}

/// Schedules the recurring call that delivers the notification outbox.
///
/// Recurring calls are stored in the database and survive restarts, so the
/// stored one is replaced instead of adding one more on every start. The
/// advisory lock makes instances that start together do this one at a time.
/// An instance that is running the call at that very moment can still leave a
/// second chain behind: it only causes extra dispatcher runs, which claim
/// records safely, and the next start removes it.
Future<void> _scheduleNotificationOutboxDispatch(Serverpod pod) async {
  // Future calls can only be scheduled once the server has started, and only
  // when they are enabled in the config.
  if (!pod.config.futureCall.enabled) return;

  final session = await pod.createSession();

  try {
    await session.db.transaction((transaction) async {
      await session.db.unsafeExecute(
        "SELECT pg_advisory_xact_lock(hashtext('"
        "${NotificationOutboxFutureCall.recurringIdentifier}'))",
        transaction: transaction,
      );

      await pod.futureCalls.cancel(
        NotificationOutboxFutureCall.recurringIdentifier,
      );

      await pod.futureCalls
          .callRecurring(
            identifier: NotificationOutboxFutureCall.recurringIdentifier,
          )
          .every(NotificationOutboxFutureCall.interval)
          .notificationOutbox
          .dispatch();
    });
  } finally {
    await session.close();
  }
}
