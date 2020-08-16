import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en_us") +
      {
        "en_us": "Email",
        "fr_be": "Email",
      } +
      {
        "en_us": "Correct the email address format",
        "fr_be": "Corrige le format de l'adresse mail",
      } +
      {
        "en_us": "This email address is not registered in Aptus",
        "fr_be": "Cette adresse email n'est pas enregistrée chez Aptus",
      } +
      {
        "en_us": "Password",
        "fr_be": "Mot de passe",
      } +
      {
        "en_us": "Sign in",
        "fr_be": "Me connecter",
      } +
      {
        "en_us": "Don't have an account yet? Sign up ",
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
