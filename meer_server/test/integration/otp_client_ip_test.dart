import 'package:meer_server/src/services/otp_rate_limit_service.dart';
import 'package:test/test.dart';

void main() {
  // كل العناوين من نطاقات التوثيق (RFC 5737 / RFC 3849) أو نطاقات خاصة،
  // وليست نطاقات حقيقية لأي مزود استضافة.
  const client = '203.0.113.50';
  const forged = '198.51.100.77';
  const proxy = '10.0.0.1';
  const edgeProxy = '10.0.0.2';
  const proxyCidrs = ['10.0.0.0/8'];

  group('Given OTP client IP resolution without a trusted proxy', () {
    test(
      'when no trusted proxy is configured then forged headers are ignored',
      () {
        final ip = resolveOtpClientIp(
          socketAddress: client,
          forwardedFor: [forged],
        );

        expect(ip, client);
      },
    );

    test(
      'when the trusted proxy configuration is absent then forwarded headers '
      'are ignored even if the socket is a private address',
      () {
        final ip = resolveOtpClientIp(
          socketAddress: proxy,
          forwardedFor: [forged, client],
          trustedProxies: OtpTrustedProxies.parse(hops: null, cidrs: null),
        );

        expect(ip, proxy);
      },
    );

    test(
      'when hops are configured without CIDRs then forwarded headers are '
      'ignored',
      () {
        final proxies = OtpTrustedProxies(hops: 1, cidrs: const []);

        final ip = resolveOtpClientIp(
          socketAddress: proxy,
          forwardedFor: [forged, client],
          trustedProxies: proxies,
        );

        expect(proxies.isEnabled, isFalse);
        expect(proxies.configError, isNotNull);
        expect(ip, proxy);
      },
    );

    test(
      'when CIDRs are configured but hops are zero then forwarded headers '
      'are ignored',
      () {
        final ip = resolveOtpClientIp(
          socketAddress: proxy,
          forwardedFor: [forged, client],
          trustedProxies: OtpTrustedProxies(hops: 0, cidrs: proxyCidrs),
        );

        expect(ip, proxy);
      },
    );
  });

  group('Given OTP client IP resolution behind trusted proxies', () {
    test(
      'when the socket peer is not a trusted proxy then forged headers are '
      'ignored even though hops are configured',
      () {
        // الخادم قابل للوصول مباشرة: المهاجم يتصل بنفسه ويرسل الترويسة.
        final ip = resolveOtpClientIp(
          socketAddress: client,
          forwardedFor: [forged],
          trustedProxies: OtpTrustedProxies(hops: 1, cidrs: proxyCidrs),
        );

        expect(ip, client);
      },
    );

    test(
      'when one trusted proxy forwards the request then the address it '
      'appended is used',
      () {
        // الأول مزوّر من العميل، والأخير أضافه الوسيط الموثوق.
        final ip = resolveOtpClientIp(
          socketAddress: proxy,
          forwardedFor: [forged, client],
          trustedProxies: OtpTrustedProxies(hops: 1, cidrs: proxyCidrs),
        );

        expect(ip, client);
      },
    );

    test(
      'when two trusted proxies forward the request then the address before '
      'both of them is used',
      () {
        final ip = resolveOtpClientIp(
          socketAddress: proxy,
          forwardedFor: [forged, client, edgeProxy],
          trustedProxies: OtpTrustedProxies(hops: 2, cidrs: proxyCidrs),
        );

        expect(ip, client);
      },
    );

    test(
      'when an intermediate hop is not a trusted proxy then the socket '
      'address is used',
      () {
        final ip = resolveOtpClientIp(
          socketAddress: proxy,
          forwardedFor: [forged, client, '192.0.2.99'],
          trustedProxies: OtpTrustedProxies(hops: 2, cidrs: proxyCidrs),
        );

        expect(ip, proxy);
      },
    );

    test(
      'when the forwarded list is shorter than the trusted hops then the '
      'socket address is used',
      () {
        final proxies = OtpTrustedProxies(hops: 2, cidrs: proxyCidrs);

        expect(
          resolveOtpClientIp(
            socketAddress: proxy,
            forwardedFor: const [],
            trustedProxies: proxies,
          ),
          proxy,
        );
        expect(
          resolveOtpClientIp(
            socketAddress: proxy,
            forwardedFor: [client],
            trustedProxies: proxies,
          ),
          proxy,
        );
      },
    );

    test(
      'when the forwarded client address is not a valid IP then the socket '
      'address is used',
      () {
        final proxies = OtpTrustedProxies(hops: 1, cidrs: proxyCidrs);

        for (final invalid in [
          'unknown',
          '',
          '   ',
          '203.0.113.999',
          '203.0.113.50:8080',
          'example.com',
          "203.0.113.50' OR '1'='1",
        ]) {
          final ip = resolveOtpClientIp(
            socketAddress: proxy,
            forwardedFor: [invalid],
            trustedProxies: proxies,
          );

          expect(ip, proxy, reason: 'forwarded value: "$invalid"');
        }
      },
    );

    test(
      'when the socket address is not a valid IP then it is never treated as '
      'a trusted proxy',
      () {
        final proxies = OtpTrustedProxies(hops: 1, cidrs: proxyCidrs);

        for (final invalid in ['', 'not-an-ip', '10.0.0.1.evil', '10.0.0']) {
          final ip = resolveOtpClientIp(
            socketAddress: invalid,
            forwardedFor: [client],
            trustedProxies: proxies,
          );

          expect(ip, isNot(client), reason: 'socket value: "$invalid"');
          expect(ip, invalid);
        }
      },
    );

    test('when addresses carry surrounding whitespace then it is trimmed', () {
      final ip = resolveOtpClientIp(
        socketAddress: ' $proxy ',
        forwardedFor: [' $client '],
        trustedProxies: OtpTrustedProxies(hops: 1, cidrs: proxyCidrs),
      );

      expect(ip, client);
    });
  });

  group('Given IPv4 trusted proxy CIDRs', () {
    test('when the socket is inside the subnet then it is trusted', () {
      final proxies = OtpTrustedProxies(
        hops: 1,
        cidrs: const ['192.0.2.128/25'],
      );

      expect(
        resolveOtpClientIp(
          socketAddress: '192.0.2.129',
          forwardedFor: [client],
          trustedProxies: proxies,
        ),
        client,
      );
      expect(
        resolveOtpClientIp(
          socketAddress: '192.0.2.255',
          forwardedFor: [client],
          trustedProxies: proxies,
        ),
        client,
      );
    });

    test('when the socket is just outside the subnet then it is untrusted', () {
      final ip = resolveOtpClientIp(
        socketAddress: '192.0.2.127',
        forwardedFor: [client],
        trustedProxies: OtpTrustedProxies(
          hops: 1,
          cidrs: const ['192.0.2.128/25'],
        ),
      );

      expect(ip, '192.0.2.127');
    });

    test('when a single address is configured then only it is trusted', () {
      for (final cidrs in [
        const ['10.0.0.1'],
        const ['10.0.0.1/32'],
      ]) {
        final proxies = OtpTrustedProxies(hops: 1, cidrs: cidrs);

        expect(
          resolveOtpClientIp(
            socketAddress: '10.0.0.1',
            forwardedFor: [client],
            trustedProxies: proxies,
          ),
          client,
        );
        expect(
          resolveOtpClientIp(
            socketAddress: '10.0.0.2',
            forwardedFor: [client],
            trustedProxies: proxies,
          ),
          '10.0.0.2',
        );
      }
    });

    test(
      'when the socket is an IPv4-mapped IPv6 address then it matches the '
      'IPv4 subnet',
      () {
        final ip = resolveOtpClientIp(
          socketAddress: '::ffff:10.0.0.1',
          forwardedFor: [client],
          trustedProxies: OtpTrustedProxies(hops: 1, cidrs: proxyCidrs),
        );

        expect(ip, client);
      },
    );

    test(
      'when no proxy is trusted then an IPv4-mapped socket address is '
      'reported as IPv4',
      () {
        final ip = resolveOtpClientIp(
          socketAddress: '::ffff:203.0.113.50',
          forwardedFor: const [],
        );

        expect(ip, client);
      },
    );
  });

  group('Given IPv6 trusted proxy CIDRs', () {
    const proxy6 = '2001:db8:aaaa::1';
    const client6 = '2001:db8:ffff::50';
    const cidrs6 = ['2001:db8:aaaa::/48'];

    test('when the socket is inside the subnet then it is trusted', () {
      final ip = resolveOtpClientIp(
        socketAddress: proxy6,
        forwardedFor: ['2001:db8:dead::beef', client6],
        trustedProxies: OtpTrustedProxies(hops: 1, cidrs: cidrs6),
      );

      expect(ip, client6);
    });

    test('when the socket is outside the subnet then it is untrusted', () {
      final ip = resolveOtpClientIp(
        socketAddress: '2001:db8:aaab::1',
        forwardedFor: [client6],
        trustedProxies: OtpTrustedProxies(hops: 1, cidrs: cidrs6),
      );

      expect(ip, '2001:db8:aaab::1');
    });

    test('when the prefix is not byte aligned then matching is exact', () {
      // /46 يغطي aaa8 إلى aaab فقط.
      final proxies = OtpTrustedProxies(
        hops: 1,
        cidrs: const ['2001:db8:aaa8::/46'],
      );

      expect(
        resolveOtpClientIp(
          socketAddress: '2001:db8:aaab::1',
          forwardedFor: [client6],
          trustedProxies: proxies,
        ),
        client6,
      );
      expect(
        resolveOtpClientIp(
          socketAddress: '2001:db8:aaac::1',
          forwardedFor: [client6],
          trustedProxies: proxies,
        ),
        '2001:db8:aaac::1',
      );
    });

    test('when the client address is not canonical then it is normalised', () {
      final ip = resolveOtpClientIp(
        socketAddress: proxy6,
        forwardedFor: ['2001:0DB8:FFFF:0000:0000:0000:0000:0050'],
        trustedProxies: OtpTrustedProxies(hops: 1, cidrs: cidrs6),
      );

      expect(ip, client6);
    });

    test(
      'when an IPv4 proxy forwards an IPv6 client behind mixed CIDRs then '
      'the client is resolved',
      () {
        final ip = resolveOtpClientIp(
          socketAddress: proxy,
          forwardedFor: [client6, proxy6],
          trustedProxies: OtpTrustedProxies(
            hops: 2,
            cidrs: const ['10.0.0.0/8', '2001:db8:aaaa::/48'],
          ),
        );

        expect(ip, client6);
      },
    );

    test(
      'when an IPv6 socket meets an IPv4-only CIDR then it is untrusted',
      () {
        final ip = resolveOtpClientIp(
          socketAddress: proxy6,
          forwardedFor: [client6],
          trustedProxies: OtpTrustedProxies(hops: 1, cidrs: proxyCidrs),
        );

        expect(ip, proxy6);
      },
    );
  });

  group('Given an invalid trusted proxy configuration', () {
    test('when a CIDR is malformed then no proxy is trusted', () {
      for (final invalid in [
        '10.0.0.0/33',
        '10.0.0.0/-1',
        '10.0.0.0/',
        '10.0.0.0/8/8',
        '10.0.0.0/abc',
        '10.0.0/8',
        '2001:db8::/129',
        'proxy.example.com/24',
        '/8',
      ]) {
        // نطاق صالح بجانب نطاق خاطئ: الخطأ يعطّل الإعداد كله.
        final proxies = OtpTrustedProxies(
          hops: 1,
          cidrs: ['10.0.0.0/8', invalid],
        );

        expect(proxies.isEnabled, isFalse, reason: 'cidr: "$invalid"');
        expect(proxies.configError, isNotNull, reason: 'cidr: "$invalid"');
        expect(
          resolveOtpClientIp(
            socketAddress: proxy,
            forwardedFor: [client],
            trustedProxies: proxies,
          ),
          proxy,
          reason: 'cidr: "$invalid"',
        );
      }
    });

    test('when a CIDR would trust every address then it is rejected', () {
      for (final cidr in ['0.0.0.0/0', '::/0']) {
        final proxies = OtpTrustedProxies(hops: 1, cidrs: [cidr]);

        expect(proxies.isEnabled, isFalse, reason: 'cidr: "$cidr"');
        expect(
          resolveOtpClientIp(
            socketAddress: client,
            forwardedFor: [forged],
            trustedProxies: proxies,
          ),
          client,
          reason: 'cidr: "$cidr"',
        );
      }
    });

    test('when the hop count is invalid then no proxy is trusted', () {
      for (final hops in ['-1', '6', '100', 'abc', '1.5', '1 2']) {
        final proxies = OtpTrustedProxies.parse(
          hops: hops,
          cidrs: '10.0.0.0/8',
        );

        expect(proxies.isEnabled, isFalse, reason: 'hops: "$hops"');
        expect(proxies.configError, isNotNull, reason: 'hops: "$hops"');
        expect(
          resolveOtpClientIp(
            socketAddress: proxy,
            forwardedFor: [client],
            trustedProxies: proxies,
          ),
          proxy,
          reason: 'hops: "$hops"',
        );
      }
    });

    test('when the configuration is empty then it is valid and disabled', () {
      for (final proxies in [
        OtpTrustedProxies.parse(hops: null, cidrs: null),
        OtpTrustedProxies.parse(hops: '', cidrs: ' '),
        OtpTrustedProxies.parse(hops: '0', cidrs: ''),
      ]) {
        expect(proxies.isEnabled, isFalse);
        expect(proxies.configError, isNull);
      }
    });

    test('when the configuration is a valid string then it is parsed', () {
      final proxies = OtpTrustedProxies.parse(
        hops: ' 2 ',
        cidrs: ' 10.0.0.0/8 , 2001:db8:aaaa::/48 ,',
      );

      expect(proxies.isEnabled, isTrue);
      expect(proxies.configError, isNull);
      expect(proxies.hops, 2);
      expect(
        resolveOtpClientIp(
          socketAddress: '2001:db8:aaaa::1',
          forwardedFor: [forged, client, edgeProxy],
          trustedProxies: proxies,
        ),
        client,
      );
    });
  });
}
