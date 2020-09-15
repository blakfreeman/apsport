import 'package:aptus/services/list.i18n.dart';

class Sport {
  List<String> sport = [
    'BJJ'.i18n,
    'Boxing'.i18n,
    'Basketball'.i18n,
    'Cycling/Spinning'.i18n,
    'Crossfit'.i18n,
    'Dance'.i18n,
    'Fitness'.i18n,
    'Football'.i18n,
    'Gym'.i18n,
    'Hockey'.i18n,
    'Judo'.i18n,
    'Pilates'.i18n,
    'Pole Dance'.i18n,
    'Running'.i18n,
    'Swimming'.i18n,
    'Tennis'.i18n,
    'Yoga'.i18n,
    'Other'.i18n,
  ];
}

class SportLevel {
  List<String> level = [
    'Beginner'.i18n,
    'Intermediate'.i18n,
    'Advanced'.i18n,
    'Expert'.i18n,
  ];
}

// I know it's quite some work and their other way to do it but for the MVP It 's easier for me to go faster, and the advantage here is we can control the city we need be present for the next 3 month at least
class City {
  List<String> city = [
    'Antwerp'.i18n,
    'Brussels'.i18n,
    'Charleroi'.i18n,
    'Ghent'.i18n,
    'Liege'.i18n,
    'Other'.i18n,
  ];
}

class Gender {
  List<String> sex = [
    'Male'.i18n,
    'Female'.i18n,
    'Other'.i18n,
  ];
}

// Question, better to use Sting or int for the categories ?
class Ages {
  List<String> numbers = [
    '18-24',
    '25-35',
    '36-50',
    '50-65',
    '65+',
  ];
}

class Moment {
  List<String> best = [
    'Morning'.i18n,
    'Lunch break'.i18n,
    'Afternoon'.i18n,
    'Evening'.i18n,
    'Night'.i18n,
    'Anytime'.i18n,
    "I don't know".i18n,
  ];
}

class WeekOrWeekEnd {
  List<String> best = [
    'Week'.i18n,
    "Weekends".i18n,
    "Both".i18n,
    "I don't know".i18n,
  ];
}

class MyReason {
  List<String> reason = [
    "Surpass myself".i18n,
    "Loose weight".i18n,
    "Gain muscle mass".i18n,
    "Be fit".i18n,
    "Be summer-ready".i18n,
    "Get my body back after giving birth".i18n,
    "Fun".i18n,
    "Fight a disease".i18n,
    "Practise with nice people".i18n,
    "Find a sporting rhythm".i18n,
    "Be healthier".i18n,
    "Have a better lifestyle".i18n,
    "Be a better version of myself".i18n,
    "Clear my head".i18n,
    "Channel my energy",
    "Have a better relation with food".i18n,
    "Be a winner".i18n,
    "Prepare for a competition".i18n,
    "Have a healthy mind in a healthy body".i18n,
    'Competing with others'.i18n,
    "Curiosity".i18n,
    "No special goal".i18n,
    "Other".i18n,
  ];
}
