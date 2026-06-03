# NIBSS Bank Logo Generator

A Flutter package to easily generate and map NIBSS bank list entries to their corresponding logos. This package matches bank records dynamically by institution code or bank name, and provides a default fallback logo for missing or unknown entries.

Ideal for Nigerian fintech apps, wallet systems, and payment portals that load dynamic bank lists from NIBSS or other APIs.

## Features

- **Institution Code Lookup**: Instantly get the corresponding logo `Widget` using the bank's NIBSS institution code.
- **Fuzzy Name Lookup**: Retrieve the logo using the bank name. The search normalization is case-insensitive, ignores noise terms (e.g., *Plc, Ltd, Limited, Bank, Microfinance, Mfb*), and has custom parent-brand maps.
- **Custom Widget Parameters**: Configure standard image properties such as `width`, `height`, and `BoxFit` directly through the getter.
- **Raw Asset Access**: Get the underlying `AssetGenImage` to use with your own `DecorationImage`, `ImageProvider`, or custom layout.
- **Robust Fallback**: Includes a generic fallback logo for any bank not in the asset database, ensuring your UI never crashes or shows empty space.

## Installation

Add `nibss_bank_logo_generator` to your `pubspec.yaml` dependencies:

```yaml
dependencies:
  nibss_bank_logo_generator:
    path: # path to package or use pub.dev version once published
```

Run:
```bash
flutter pub get
```

## Usage

Import the package in your Dart code:

```dart
import 'package:nibss_bank_logo_generator/nibss_bank_logo_generator.dart';
```

### 1. Retrieve Logo Widget by Bank Code

Use the bank's NIBSS institution code (a string representation of the bank code) to show the logo:

```dart
// Returns an Image widget for Access Bank
NibssBankLogo.getLogoByBankCode(
  '000014',
  width: 48,
  height: 48,
  fit: BoxFit.contain,
)
```

### 2. Retrieve Logo Widget by Bank Name

If your API response only returns names, you can query by the bank name. It handles case mismatches, sub-brands, and variations automatically:

```dart
// Returns the Zenith Bank logo
NibssBankLogo.getLogoByBankName(
  'Zenith Bank PLC',
  width: 48,
  height: 48,
  fit: BoxFit.contain,
)

// Also resolves to the Zenith Bank logo (fuzzy matching / sub-brand mapping)
NibssBankLogo.getLogoByBankName(
  'Zenth Easy Wallet', 
  width: 48,
  height: 48,
)
```

### 3. Retrieve Raw Assets (ImageProvider or Path)

For custom widgets, containers, or backgrounds, retrieve the raw `AssetGenImage`:

```dart
final AssetGenImage logoAsset = NibssBankLogo.getLogoAssetByBankCode('000014');

// Get the asset path
String path = logoAsset.path; // "packages/nibss_bank_logo_generator/assets/images/access.png"

// Use with a custom DecorationImage
Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: logoAsset.provider(),
      fit: BoxFit.cover,
    ),
  ),
)
```

### 4. Default Fallback Logo

Any non-existent code or unknown bank name will automatically fall back to the default package logo:

```dart
// Returns the default package bank logo (default_bank_logo.png)
NibssBankLogo.getLogoByBankCode('999999')
```

To fetch the raw default asset directly:

```dart
final AssetGenImage defaultAsset = NibssBankLogo.getDefaultLogoAsset();
```

## Contributing & Issues

### Missing Banks or Logos?
If you discover a bank that does not exist in the package, or has a missing or outdated logo:
1. Open an issue on our [GitHub repository](https://github.com/ayanfeafolabi/nibss_bank_logo_generator).
2. Include the bank's NIBSS **Institution Code**, **Official Name**, and optionally a high-resolution logo link or image file.

### Collaboration & Support
We are fully open to collaboration! If you want to contribute updates, optimize mapping algorithms, or add new assets:
- Feel free to fork the repository and submit a Pull Request.
- Ensure all existing unit tests pass by running `flutter test` before submitting your PR.
