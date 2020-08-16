import 'package:aptus/services/list.i18n.dart';

class Sport {
  List<String> sport = [
    'Football',
    'Tennis',
    'Judo ',
    'Fitness',
    'BJJ',
    'BasketBall',
    'Yoga',
    'Dance',
    'Pole Dance',
    'Gym',
  ];
}

class SportLevel {
  List<String> level = [
    'Novice',
    'Good',
    'Pro',
    'Expert',
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
    'Morning',
    'Afternoon',
    'Evening',
    'Night',
    'Anytime',
    "I don't know",
  ];
}

class WeekOrWeekEnd {
  List<String> best = [
    'Week',
    'Weekend',
    "both",
    "I don' know",
  ];
}

class MyReason {
  List<String> reason = [
    'To challenge me',
    'lose weight',
    'having more energy',
    'meet someone and have fun',
    'having fun',
    'I want to compete with others',
    "I don't have a special reason",
  ];
}
