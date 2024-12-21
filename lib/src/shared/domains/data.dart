import 'package:awesome_extensions/awesome_extensions.dart';

class Data {
  final String name;
  final String surname;
  final String countryName;
  final String countryFlag;

  String generateInitial({required String name, required String surname}) {
    return name[0].capitalizeFirst + surname[0].capitalizeFirst;
  }

  Data({
    required this.name,
    required this.surname,
    required this.countryName,
    required this.countryFlag,
  });
}

final List<Data> data = [
  Data(
    name: "Daryl",
    surname: "Zambo",
    countryName: "Ivory Coast",
    countryFlag: "https://www.worldometers.info/img/flags/iv-flag.gif",
  ),
  Data(
    name: "Nono",
    surname: "Idriss",
    countryName: "Cameroon",
    countryFlag: "https://www.worldometers.info/img/flags/cm-flag.gif",
  ),
  Data(
    name: "Olivia",
    surname: "Stevens",
    countryName: "United States",
    countryFlag: "https://www.worldometers.info/img/flags/us-flag.gif",
  ),
  Data(
    name: "Kristi",
    surname: "Rhoades",
    countryName: "France",
    countryFlag: "https://www.worldometers.info/img/flags/fr-flag.gif",
  ),
  Data(
    name: "Cooper",
    surname: "Ulrich",
    countryName: "Canada",
    countryFlag: "https://www.worldometers.info/img/flags/ca-flag.gif",
  ),
  Data(
    name: "Crouch",
    surname: "Findlay",
    countryName: "Cameroon",
    countryFlag: "https://www.worldometers.info/img/flags/as-flag.gif",
  ),
];