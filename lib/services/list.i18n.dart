import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en_us") +
      {
        "en_us": "Male",
        "fr_be": "Homme",
      } +
      {
        "en_us": "Female",
        "fr_be": "Femme",
      } +
      {
        "en_us": "Other",
        "fr_be": "Autre",
      } +
      {
        "en_us": "Antwerp",
        "fr_be": "Anvers",
      } +
      {
        "en_us": "Brussels",
        "fr_be": "Bruxelles",
      } +
      {
        "en_us": "Charleroi",
        "fr_be": "Charleroi",
      } +
      {
        "en_us": "Ghent",
        "fr_be": "Gand",
      } +
      {
        "en_us": "Liege",
        "fr_be": "Liège",
      };

  String get i18n => localize(this, _t);
}
