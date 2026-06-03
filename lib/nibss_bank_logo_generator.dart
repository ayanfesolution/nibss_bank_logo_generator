import 'package:flutter/widgets.dart';
import 'gen/assets.gen.dart';
import 'nibss_bank_logo_mapping.gen.dart';

export 'gen/assets.gen.dart' show AssetGenImage;

class NibssBankLogo {
  /// Normalization helper to match bank names case-insensitively and remove common noise.
  static String _normalize(String input) {
    var name = input.toLowerCase();
    name = name.replaceAll('microfinance bank', 'mfb');
    name = name.replaceAll('microfinancebank', 'mfb');
    name = name.replaceAll('microfinance', 'mfb');
    name = name.replaceAll('payment service bank', 'psb');
    name = name.replaceAll('paymentservicebank', 'psb');
    name = name.replaceAll('paymentservice', 'psb');
    name = name.replaceAll('finace', 'finance');
    name = name.replaceAll('mortgage bank', 'mortgage');
    name = name.replaceAll('mortgagebank', 'mortgage');
    name = name.replaceAll('savings and loans', 'savingsloans');
    name = name.replaceAll('savings & loans', 'savingsloans');
    name = name.replaceAll(RegExp(r'\bplc\b'), '');
    name = name.replaceAll(RegExp(r'\bltd\b'), '');
    name = name.replaceAll(RegExp(r'\blimited\b'), '');
    name = name.replaceAll(RegExp(r'[^a-z0-9]'), '');
    return name;
  }

  static String _normalizeLoose(String input) {
    var s = _normalize(input);
    s = s.replaceAll('mfb', '');
    s = s.replaceAll('bank', '');
    s = s.replaceAll('finance', '');
    return s;
  }

  /// Returns the [AssetGenImage] bank logo for the given NIBSS institution code.
  /// If the code is not found or has no logo, returns the default fallback logo.
  static AssetGenImage getLogoAssetByBankCode(String institutionCode) {
    final logo = institutionCodeToLogo[institutionCode];
    return logo ?? Assets.images.defaultBankLogo;
  }

  /// Returns the [AssetGenImage] bank logo for the given bank name.
  /// If the name is not matched, returns the default fallback logo.
  static AssetGenImage getLogoAssetByBankName(String bankName) {
    final norm = _normalize(bankName);
    var logo = nameToLogo[norm];
    if (logo == null) {
      final loose = _normalizeLoose(bankName);
      logo = looseNameToLogo[loose];
    }
    return logo ?? Assets.images.defaultBankLogo;
  }

  /// Returns the default fallback logo asset.
  static AssetGenImage getDefaultLogoAsset() {
    return Assets.images.defaultBankLogo;
  }

  /// Returns an [Image] widget for the bank logo given its NIBSS institution code.
  /// If the code is not found, returns the default fallback logo.
  static Widget getLogoByBankCode(
    String institutionCode, {
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return getLogoAssetByBankCode(institutionCode).image(
      width: width,
      height: height,
      fit: fit,
      package: 'nibss_bank_logo_generator',
    );
  }

  /// Returns an [Image] widget for the bank logo given its name.
  /// If the name is not matched, returns the default fallback logo.
  static Widget getLogoByBankName(
    String bankName, {
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return getLogoAssetByBankName(bankName).image(
      width: width,
      height: height,
      fit: fit,
      package: 'nibss_bank_logo_generator',
    );
  }
}
