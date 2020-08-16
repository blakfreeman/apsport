import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en_us") +
      {
        "en_us": "Sign up",
        "fr_be": "M'inscrire",
      } +
      {
        "en_us": "Choose a longer name",
        "fr_be": "Choisis un nom plus long",
      } +
      {
        "en_us": "Choose a shorter name",
        "fr_be": "Choisis une nom plus court",
      } +
      {
        "en_us": "User name",
        "fr_be": "Identifiant",
      } +
      {
        "en_us": "Choose another name, this one is already taken",
        "fr_be": "Choisis un autre identifiant, celui-là est déjà pris",
      } +
      {
        "en_us": "This email address is already registered in Aptus",
        "fr_be": "Cette adresse mail est déjà enregistrée chez Aptus",
      } +
      {
        "en_us": "Correct the email address format",
        "fr_be": "Corrige le format de l'adresse mail",
      } +
      {
        "en_us": "Email",
        "fr_be": "Email",
      } +
      {
        "en_us": "Password",
        "fr_be": "Mot de passe",
      } +
      {
        "en_us": "Password confirmation",
        "fr_be": "Confirmation du mot de passe",
      } +
      {
        "en_us": "Register",
        "fr_be": "Enregistrer",
      } +
      {
        "en_us": "Passwords don't match",
        "fr_be": "Les mots de passe ne correspondent pas",
      } +
      {
        "en_us": "Gender",
        "fr_be": "Genre",
      } +
      {
        "en_us": "Select a gender",
        "fr_be": "Selectionne un genre",
      } +
      {
        "en_us": "Age",
        "fr_be": "Age",
      } +
      {
        "en_us": "Select your age category",
        "fr_be": "Selectionne ta catégorie d'age",
      } +
      {
        "en_us": "City",
        "fr_be": "Ville",
      } +
      {
        "en_us": "Select the closest city",
        "fr_be": "Selectionne la ville la plus proche",
      } +
      {
        "en_us": "Sport",
        "fr_be": "Sport",
      } +
      {
        "en_us": "Select your main sport",
        "fr_be": "Selectionne ton sport principal",
      } +
      {
        "en_us": "Sport level",
        "fr_be": "Niveau sportif",
      } +
      {
        "en_us": "Tell us about your level for your main sport",
        "fr_be": "Partage ton niveau dans ton sport principal",
      } +
      {
        "en_us": "Goodbye",
        "pt_br": "Adeus",
      };

  String get i18n => localize(this, _t);
}
