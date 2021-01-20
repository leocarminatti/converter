import 'package:currency_converter/domain/model/convert.dart';
import 'package:currency_converter/domain/model/currency.dart';

class CurrenciesMapper {
  static List<Currency> toList(Map<String, dynamic> data) {
    List<Currency> cl = List<Currency>();

    data.forEach((key, value) {
      cl.add(Currency.fromMap(key, value));
    });

    return cl;
  }

  static List<String> toListCode(Map<String, dynamic> data) {
    return data.keys.toList();
  }

  static Convert toConvert(Map<String, dynamic> data, String from, String to) {
    final fromValue = data["USD$from"];
    final toValue = data["USD$to"];
    return Convert(fromValue: fromValue, toValue: toValue);
  }
}