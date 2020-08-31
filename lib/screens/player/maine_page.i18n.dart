import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en_us") +
      {
        "en_us": "Near me",
        "fr_be": "Près de moi",
      } +
      {
        "en_us": "My sport",
        "fr_be": "Mon sport",
      } +
      {
        "en_us": "My likes",
        "fr_be": "Mes likes",
      } +
      {
        "en_us": "My coaches",
        "fr_be": "Mes coaches",
      } +
      {
        "en_us": "Log in",
        "fr_be": "Me connecter",
      } +
      {
        "en_us": "Don't have an account yet? Register ",
        "fr_be": "Pas encore de compte? Inscris-toi ",
      } +
      {
        "en_us": "here",
        "fr_be": "ici",
      } +
      {
        "en_us": "Goodbye",
        "pt_br": "Adeus",
      };

  String get i18n => localize(this, _t);
}
