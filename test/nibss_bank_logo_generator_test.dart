import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nibss_bank_logo_generator/nibss_bank_logo_generator.dart';

void main() {
  // Ensure Flutter binding is initialized for assets
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NibssBankLogo Tests', () {
    test('Resolves valid bank logo by code', () {
      // Access Bank
      final asset = NibssBankLogo.getLogoAssetByBankCode('000014');
      expect(asset.path, equals('assets/images/access.png'));

      // Zenith Bank
      final zenithAsset = NibssBankLogo.getLogoAssetByBankCode('000015');
      expect(zenithAsset.path, equals('assets/images/Zenith.png'));

      // 9 payment service Bank
      final ninePsbAsset = NibssBankLogo.getLogoAssetByBankCode('120001');
      expect(ninePsbAsset.path, equals('assets/images/9payment_psb.png'));
    });

    test('Resolves valid bank logo by name (normalized & loose)', () {
      // Access Bank name lookup
      final assetByName1 = NibssBankLogo.getLogoAssetByBankName('Access Bank');
      expect(assetByName1.path, equals('assets/images/access.png'));

      final assetByName2 =
          NibssBankLogo.getLogoAssetByBankName('ACCESS BANK PLC (DIAMOND)');
      expect(assetByName2.path, equals('assets/images/access.png'));

      // Zenith name lookup
      final zenithAsset = NibssBankLogo.getLogoAssetByBankName('Zenith Bank');
      expect(zenithAsset.path, equals('assets/images/Zenith.png'));

      // Ecobank Express/Xpress Account lookup
      final ecobankExpress =
          NibssBankLogo.getLogoAssetByBankName('Ecobank express account');
      expect(ecobankExpress.path, equals('assets/images/ecobank.png'));

      final ecobankXpress =
          NibssBankLogo.getLogoAssetByBankName('ECOBANK XPRESS ACCOUNT');
      expect(ecobankXpress.path, equals('assets/images/ecobank.png'));

      // FCMB Easy Account lookup
      final fcmbEasy =
          NibssBankLogo.getLogoAssetByBankName('FCMB Easy Account');
      expect(fcmbEasy.path, equals('assets/images/fcmb.png'));

      // Fidelity Mobile lookup
      final fidelityMobile =
          NibssBankLogo.getLogoAssetByBankName('Fidelity Mobile');
      expect(fidelityMobile.path, equals('assets/images/fidelity.png'));
    });

    test('Resolves shared parent bank logos correctly', () {
      // Zenth Easy Wallet -> Zenith
      final zenthWallet = NibssBankLogo.getLogoAssetByBankCode('100034');
      expect(zenthWallet.path, equals('assets/images/Zenith.png'));

      // ACCESSMONEY -> access
      final accessmoney = NibssBankLogo.getLogoAssetByBankCode('100013');
      expect(accessmoney.path, equals('assets/images/access.png'));

      // Stanbic @Ease Wallet -> stanbic
      final stanbicEase = NibssBankLogo.getLogoAssetByBankCode('100007');
      expect(stanbicEase.path, equals('assets/images/stanbic.png'));
    });

    test('Falls back to default logo for unknown code/name', () {
      // Unknown code
      final fallbackAsset1 = NibssBankLogo.getLogoAssetByBankCode('999999');
      expect(
          fallbackAsset1.path, equals('assets/images/default_bank_logo.png'));

      // Unknown name
      final fallbackAsset2 =
          NibssBankLogo.getLogoAssetByBankName('Fake Bank Microfinance Ltd');
      expect(
          fallbackAsset2.path, equals('assets/images/default_bank_logo.png'));
    });

    test('Returns Image widget successfully', () {
      final widget =
          NibssBankLogo.getLogoByBankCode('000014', width: 50, height: 50);
      expect(widget, isA<Image>());

      final imageWidget = widget as Image;
      expect(imageWidget.width, equals(50));
      expect(imageWidget.height, equals(50));
    });
  });
}
