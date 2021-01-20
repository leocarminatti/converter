import 'dart:collection';

import 'package:currency_converter/domain/model/convert.dart';
import 'package:currency_converter/domain/repository/currency_layer_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class ConvertProvider extends ChangeNotifier {
  final _repository = CurrencyLayerRepository();

  final _errorController = BehaviorSubject<void>();
  Stream<void> get errorStateStream => _errorController.stream;

  final List<String> _items = [];
  get items => UnmodifiableListView(_items);
  String _selectedFrom;
  String _selectedTo;
  double _convertedValue = 0;

  getCurrenciesCode() async {
   _repository.getCurrenciesCode().listen((event) {
     _items.addAll(event);
     notifyListeners();
   }).onError((handleError) {
      _errorController.addError(handleError);
   });
  }

  String get selectedFrom {
    return _selectedFrom;
  }

  set selectedFrom(final String item) {
    _selectedFrom = item;
    notifyListeners();
  }

  String get selectedTo {
    return _selectedTo;
  }

  set selectedTo(final String item) {
    _selectedTo = item;
    notifyListeners();
  }

  double get convertedValue {
    return _convertedValue;
  }

  set convertedValue(final double item) {
    _convertedValue = item;
    notifyListeners();
  }

  amountConvert(final double amount) async {
    _repository.convert(Convert(from: _selectedFrom, to: _selectedTo, amount: amount))
    .listen((event) {
      final Convert convert = event;
      try {
        _convertedValue = (amount / convert.fromValue) * convert.toValue;
        notifyListeners();
      } catch(e) {
        _errorController.addError(e);
      }
    }).onError((handleError) {
      _errorController.addError(handleError);
    });
  }

  void Dispose(){
    _errorController.close();
  }
}