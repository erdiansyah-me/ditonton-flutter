import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

abstract class SecureHttpClient {
  static Future<Client> secureCertificatedClient() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    return IOClient(client);
  }

  static Future<SecurityContext> get globalContext async {
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    try {
      final sslCertificate =
          await rootBundle.load('certificates/certificate.pem');
      securityContext.setTrustedCertificatesBytes(sslCertificate.buffer.asInt8List());
    } catch (e) {
      print(e.toString());
    }
    return securityContext;
  }
}
