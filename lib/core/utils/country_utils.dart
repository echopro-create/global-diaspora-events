/// Утилиты для работы со странами по ISO 3166-1 alpha-2.
library;

/// Информация о стране.
class CountryInfo {
  final String code;
  final String flag;
  final String nameEn;
  final String nameRu;
  final String nameUk;

  const CountryInfo({
    required this.code,
    required this.flag,
    required this.nameEn,
    required this.nameRu,
    required this.nameUk,
  });
}

/// Список стран бывшего СССР + ключевые страны диаспоры.
const countries = <String, CountryInfo>{
  // Бывший СССР
  'UA': CountryInfo(
    code: 'UA',
    flag: '🇺🇦',
    nameEn: 'Ukraine',
    nameRu: 'Украина',
    nameUk: 'Україна',
  ),
  'RU': CountryInfo(
    code: 'RU',
    flag: '🇷🇺',
    nameEn: 'Russia',
    nameRu: 'Россия',
    nameUk: 'Росія',
  ),
  'BY': CountryInfo(
    code: 'BY',
    flag: '🇧🇾',
    nameEn: 'Belarus',
    nameRu: 'Беларусь',
    nameUk: 'Білорусь',
  ),
  'KZ': CountryInfo(
    code: 'KZ',
    flag: '🇰🇿',
    nameEn: 'Kazakhstan',
    nameRu: 'Казахстан',
    nameUk: 'Казахстан',
  ),
  'UZ': CountryInfo(
    code: 'UZ',
    flag: '🇺🇿',
    nameEn: 'Uzbekistan',
    nameRu: 'Узбекистан',
    nameUk: 'Узбекистан',
  ),
  'GE': CountryInfo(
    code: 'GE',
    flag: '🇬🇪',
    nameEn: 'Georgia',
    nameRu: 'Грузия',
    nameUk: 'Грузія',
  ),
  'AZ': CountryInfo(
    code: 'AZ',
    flag: '🇦🇿',
    nameEn: 'Azerbaijan',
    nameRu: 'Азербайджан',
    nameUk: 'Азербайджан',
  ),
  'LT': CountryInfo(
    code: 'LT',
    flag: '🇱🇹',
    nameEn: 'Lithuania',
    nameRu: 'Литва',
    nameUk: 'Литва',
  ),
  'MD': CountryInfo(
    code: 'MD',
    flag: '🇲🇩',
    nameEn: 'Moldova',
    nameRu: 'Молдова',
    nameUk: 'Молдова',
  ),
  'LV': CountryInfo(
    code: 'LV',
    flag: '🇱🇻',
    nameEn: 'Latvia',
    nameRu: 'Латвия',
    nameUk: 'Латвія',
  ),
  'KG': CountryInfo(
    code: 'KG',
    flag: '🇰🇬',
    nameEn: 'Kyrgyzstan',
    nameRu: 'Кыргызстан',
    nameUk: 'Киргизстан',
  ),
  'TJ': CountryInfo(
    code: 'TJ',
    flag: '🇹🇯',
    nameEn: 'Tajikistan',
    nameRu: 'Таджикистан',
    nameUk: 'Таджикистан',
  ),
  'AM': CountryInfo(
    code: 'AM',
    flag: '🇦🇲',
    nameEn: 'Armenia',
    nameRu: 'Армения',
    nameUk: 'Вірменія',
  ),
  'TM': CountryInfo(
    code: 'TM',
    flag: '🇹🇲',
    nameEn: 'Turkmenistan',
    nameRu: 'Туркменистан',
    nameUk: 'Туркменістан',
  ),
  'EE': CountryInfo(
    code: 'EE',
    flag: '🇪🇪',
    nameEn: 'Estonia',
    nameRu: 'Эстония',
    nameUk: 'Естонія',
  ),

  // Ключевые страны диаспоры
  'DE': CountryInfo(
    code: 'DE',
    flag: '🇩🇪',
    nameEn: 'Germany',
    nameRu: 'Германия',
    nameUk: 'Німеччина',
  ),
  'PL': CountryInfo(
    code: 'PL',
    flag: '🇵🇱',
    nameEn: 'Poland',
    nameRu: 'Польша',
    nameUk: 'Польща',
  ),
  'CZ': CountryInfo(
    code: 'CZ',
    flag: '🇨🇿',
    nameEn: 'Czech Republic',
    nameRu: 'Чехия',
    nameUk: 'Чехія',
  ),
  'US': CountryInfo(
    code: 'US',
    flag: '🇺🇸',
    nameEn: 'United States',
    nameRu: 'США',
    nameUk: 'США',
  ),
  'CA': CountryInfo(
    code: 'CA',
    flag: '🇨🇦',
    nameEn: 'Canada',
    nameRu: 'Канада',
    nameUk: 'Канада',
  ),
  'GB': CountryInfo(
    code: 'GB',
    flag: '🇬🇧',
    nameEn: 'United Kingdom',
    nameRu: 'Великобритания',
    nameUk: 'Великобританія',
  ),
  'FR': CountryInfo(
    code: 'FR',
    flag: '🇫🇷',
    nameEn: 'France',
    nameRu: 'Франция',
    nameUk: 'Франція',
  ),
  'IT': CountryInfo(
    code: 'IT',
    flag: '🇮🇹',
    nameEn: 'Italy',
    nameRu: 'Италия',
    nameUk: 'Італія',
  ),
  'ES': CountryInfo(
    code: 'ES',
    flag: '🇪🇸',
    nameEn: 'Spain',
    nameRu: 'Испания',
    nameUk: 'Іспанія',
  ),
  'PT': CountryInfo(
    code: 'PT',
    flag: '🇵🇹',
    nameEn: 'Portugal',
    nameRu: 'Португалия',
    nameUk: 'Португалія',
  ),
  'IL': CountryInfo(
    code: 'IL',
    flag: '🇮🇱',
    nameEn: 'Israel',
    nameRu: 'Израиль',
    nameUk: 'Ізраїль',
  ),
  'TR': CountryInfo(
    code: 'TR',
    flag: '🇹🇷',
    nameEn: 'Turkey',
    nameRu: 'Турция',
    nameUk: 'Туреччина',
  ),
  'AU': CountryInfo(
    code: 'AU',
    flag: '🇦🇺',
    nameEn: 'Australia',
    nameRu: 'Австралия',
    nameUk: 'Австралія',
  ),
  'AT': CountryInfo(
    code: 'AT',
    flag: '🇦🇹',
    nameEn: 'Austria',
    nameRu: 'Австрия',
    nameUk: 'Австрія',
  ),
  'NL': CountryInfo(
    code: 'NL',
    flag: '🇳🇱',
    nameEn: 'Netherlands',
    nameRu: 'Нидерланды',
    nameUk: 'Нідерланди',
  ),
  'SE': CountryInfo(
    code: 'SE',
    flag: '🇸🇪',
    nameEn: 'Sweden',
    nameRu: 'Швеция',
    nameUk: 'Швеція',
  ),
  'NO': CountryInfo(
    code: 'NO',
    flag: '🇳🇴',
    nameEn: 'Norway',
    nameRu: 'Норвегия',
    nameUk: 'Норвегія',
  ),
  'FI': CountryInfo(
    code: 'FI',
    flag: '🇫🇮',
    nameEn: 'Finland',
    nameRu: 'Финляндия',
    nameUk: 'Фінляндія',
  ),
  'DK': CountryInfo(
    code: 'DK',
    flag: '🇩🇰',
    nameEn: 'Denmark',
    nameRu: 'Дания',
    nameUk: 'Данія',
  ),
  'CH': CountryInfo(
    code: 'CH',
    flag: '🇨🇭',
    nameEn: 'Switzerland',
    nameRu: 'Швейцария',
    nameUk: 'Швейцарія',
  ),
  'SK': CountryInfo(
    code: 'SK',
    flag: '🇸🇰',
    nameEn: 'Slovakia',
    nameRu: 'Словакия',
    nameUk: 'Словаччина',
  ),
  'RO': CountryInfo(
    code: 'RO',
    flag: '🇷🇴',
    nameEn: 'Romania',
    nameRu: 'Румыния',
    nameUk: 'Румунія',
  ),
  'HU': CountryInfo(
    code: 'HU',
    flag: '🇭🇺',
    nameEn: 'Hungary',
    nameRu: 'Венгрия',
    nameUk: 'Угорщина',
  ),
  'BG': CountryInfo(
    code: 'BG',
    flag: '🇧🇬',
    nameEn: 'Bulgaria',
    nameRu: 'Болгария',
    nameUk: 'Болгарія',
  ),
  'IE': CountryInfo(
    code: 'IE',
    flag: '🇮🇪',
    nameEn: 'Ireland',
    nameRu: 'Ирландия',
    nameUk: 'Ірландія',
  ),
};

/// Получить флаг по ISO-коду.
String countryFlag(String isoCode) =>
    countries[isoCode.toUpperCase()]?.flag ?? '🏳️';

/// Получить короткое имя по ISO-коду (английское, fallback).
String countryNameEn(String isoCode) =>
    countries[isoCode.toUpperCase()]?.nameEn ?? isoCode;

/// Получить отображаемую строку «🇺🇦 Ukraine».
String countryDisplay(String isoCode, {String locale = 'en'}) {
  final info = countries[isoCode.toUpperCase()];
  if (info == null) return isoCode;

  final name = switch (locale) {
    'ru' => info.nameRu,
    'uk' => info.nameUk,
    _ => info.nameEn,
  };

  return '${info.flag} $name';
}
