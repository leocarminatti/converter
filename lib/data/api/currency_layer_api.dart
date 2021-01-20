import 'package:currency_converter/domain/mapper/currecies_mapper.dart';
import 'package:currency_converter/domain/model/convert.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class CurrencyLayerApi {
  final Dio _dio = Dio();
  final String baseUrl = "http://api.currencylayer.com/";
  final String key = "?access_key=e4c36f3ef3148e10a665b71208e40629";

  Stream listCode() {
    final _endpoint = "${baseUrl}list$key";
    return Stream.fromFuture(_dio.get(_endpoint)).map((response) => CurrenciesMapper.toListCode(response.data['currencies']));
  }

  Stream list() {
    final _endpoint = "${baseUrl}list$key";
    return Stream.fromFuture(_dio.get(_endpoint)).map((response) => CurrenciesMapper.toList(response.data['currencies']));
  }

  Stream convert(Convert convert) {
    final _endpoint =
        "${baseUrl}live$key&currencies=${convert.from},${convert.to}"
        "&source=USD&format=1";

    return Stream.fromFuture(_dio.post(_endpoint)).map((response) =>
        CurrenciesMapper.toConvert(response.data["quotes"], convert.from, convert.to)
    );
  }
}