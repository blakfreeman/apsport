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
      } +
      {
        "en_us": "Beginner",
        "fr_be": "Débutant",
      } +
      {
        "en_us": "Intermediate",
        "fr_be": "Intermédiaire",
      } +
      {
        "en_us": "Advanced",
        "fr_be": "Avancé",
      } +
      {
        "en_us": "Expert",
        "fr_be": "Expert",
      } +
      {
        "en_us": "BJJ",
        "fr_be": "BJJ",
      } +
      {
        "en_us": "Boxing",
        "fr_be": "Boxe",
      } +
      {
        "en_us": "Basketball",
        "fr_be": "Basketball",
      } +
      {
        "en_us": "Cycling/Spinning",
        "fr_be": "Cyclisme/Spinning",
      } +
      {
        "en_us": "Crossfit",
        "fr_be": "Crossfit",
      } +
      {
        "en_us": "Dance",
        "fr_be": "Danse",
      } +
      {
        "en_us": "Fitness",
        "fr_be": "Fitness",
      } +
      {
        "en_us": "Football",
        "fr_be": "Football",
      } +
      {
        "en_us": "Gym",
        "fr_be": "Gym",
      } +
      {
        "en_us": "Hockey",
        "fr_be": "Hockey",
      } +
      {
        "en_us": "Judo",
        "fr_be": "Judo",
      } +
      {
        "en_us": "Pilates",
        "fr_be": "Pilates",
      } +
      {
        "en_us": "Pole Dance",
        "fr_be": "Pole Dance",
      } +
      {
        "en_us": "Running",
        "fr_be": "Course à pied",
      } +
      {
        "en_us": "Swimming",
        "fr_be": "Natation",
      } +
      {
        "en_us": "Tennis",
        "fr_be": "Tenis",
      } +
      {
        "en_us": "Yoga",
        "fr_be": "Yoga",
      } +
      {
        "en_us": "Morning",
        "fr_be": "Matinée",
      } +
      {
        "en_us": "Lunch break",
        "fr_be": "Pause de midi",
      } +
      {
        "en_us": "Afternoon",
        "fr_be": "Après-midi",
      } +
      {
        "en_us": "Evening",
        "fr_be": "Soirée",
      } +
      {
        "en_us": "Night",
        "fr_be": "Nuit",
      } +
      {
        "en_us": "Anytime",
        "fr_be": "A tout moment",
      } +
      {
        "en_us": "I don't know",
        "fr_be": "Je ne sais pas",
      } +
      {
        "en_us": "Week",
        "fr_be": "En semaine",
      } +
      {
        "en_us": "Weekend'",
        "fr_be": "Le weekend",
      } +
      {
        "en_us": "Both",
        "fr_be": "Les deux",
      } +
      {
        "en_us": "Surpass myself",
        "fr_be": "Me surpasser",
      } +
      {
        "en_us": "Loose weight",
        "fr_be": "Perdre du poid",
      } +
      {
        "en_us": "Gain muscle mass",
        "fr_be": "Prendre de la masse musculaire",
      } +
      {
        "en_us": "Be fit",
        "fr_be": "Etre en forme",
      } +
      {
        "en_us": "Be summer-ready",
        "fr_be": "Me préparer à l'été",
      } +
      {
        "en_us": "Get my body back after giving birth",
        "fr_be": "Retrouver mon corp après un accouchement",
      } +
      {
        "en_us": "Fun",
        "fr_be": "Le fun",
      } +
      {
        "en_us": "Fight a disease",
        "fr_be": "Combattre une maladie",
      } +
      {
        "en_us": "Practise with nice people",
        "fr_be": "Faire du sport avec des gens sympa",
      } +
      {
        "en_us": "Find a sporting rhythm",
        "fr_be": "Trouver un rythme sportif",
      } +
      {
        "en_us": "Be healthier",
        "fr_be": "Etre en meilleure santé",
      } +
      {
        "en_us": "Have a better lifestyle",
        "fr_be": "Avoir un meilleur lifestyle",
      } +
      {
        "en_us": "Be a better version of myself",
        "fr_be": "M'améliorer",
      } +
      {
        "en_us": "Clear my head",
        "fr_be": "Me vider la tête",
      } +
      {
        "en_us": "Channel my energy",
        "fr_be": "Canaliser mon énergie",
      } +
      {
        "en_us": "Have a better relation with food",
        "fr_be": "Améliorer ma relation avec la nourriture",
      } +
      {
        "en_us": "Be a winner",
        "fr_be": "",
      } +
      {
        "en_us": "Prepare for a competition",
        "fr_be": "Me préparer à une compétition",
      } +
      {
        "en_us": "Have a healthy mind in a healthy body",
        "fr_be": "Avoir un esprit sain dans un corp sain",
      } +
      {
        "en_us": "Competing with others",
        "fr_be": "Me mesurer aux autres",
      } +
      {
        "en_us": "Curiosity",
        "fr_be": "La curiosité",
      } +
      {
        "en_us": "No special goal",
        "fr_be": "Pas d'objectif particulier",
      };

  String get i18n => localize(this, _t);
}
