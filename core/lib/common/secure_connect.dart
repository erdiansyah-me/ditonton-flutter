import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

abstract class SecureConnect {
  static Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('packages/core/certificates/certificate.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  static Future<http.Client> SecureHttp() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    return ioClient;
  }
}