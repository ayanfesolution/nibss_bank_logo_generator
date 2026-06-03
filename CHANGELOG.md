## 0.0.1

* Initial release of the NIBSS bank list logo generator package.
* Expose `NibssBankLogo` utility class for retrieving bank logos.
* Implement mapping from NIBSS institution codes to bank logo assets.
* Provide `getLogoByBankCode` to return an `Image` widget for a given institution code.
* Provide `getLogoByBankName` to return an `Image` widget for a given bank name.
* Provide `getLogoAssetByBankCode` and `getLogoAssetByBankName` to return the underlying `AssetGenImage` for custom styling or path retrieval.
* Include fallback support to a default logo for unknown codes, names, or missing bank logos.
