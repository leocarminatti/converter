import 'package:currency_converter/data/api/currency_layer_api.dart';
import 'package:currency_converter/domain/mapper/error_mapper.dart';
import 'package:currency_converter/domain/model/convert.dart';
import 'package:rxdart/rxdart.dart';

class CurrencyLayerRepository {

  final CurrencyLayerApi _api = CurrencyLayerApi();

  Stream getCurrenciesCode() {
    return _api.listCode()
        .onErrorResume((error) => Stream.error(ErrorMapper.toConsultantError(error)));
  }

  Stream getCurrencies() {
    return _api.list()
        .onErrorResume((error) => Stream.error(ErrorMapper.toConsultantError(error)));
  }

  Stream convert(Convert convert) {
    return _api.convert(convert)
        .onErrorResume((error) => Stream.error(ErrorMapper.toConsultantError(error)));
  }
}