import 'dart:convert';

import 'package:crypto/crypto.dart';

class CodeCalculator {
  CodeCalculator({required this.publicApiKey, required this.privateApiKey});
  final String publicApiKey;
  final String privateApiKey;

  /// **code** it's the getter does work to generate a code
  String get code => calculateCode();

  /// **calculateCode** is a method that generate hash
  String calculateCode() {
    final Digest code =
        md5.convert(utf8.encode("1$privateApiKey$publicApiKey"));
    return code.toString();
  }
}
