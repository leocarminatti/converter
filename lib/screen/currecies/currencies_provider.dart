import 'dart:collection';

import 'package:currency_converter/domain/model/currency.dart';
import 'package:currency_converter/domain/repository/currency_layer_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CurrenciesProvider extends ChangeNotifier {
  final _repository = CurrencyLayerRepository();

  final _errorController = BehaviorSubject<void>();
  Stream<void> get errorStateStream => _errorController.stream;

  final List<Currency> _items = [];
  get items => UnmodifiableListView(_items);

  getCurrencies() async {
    _repository.getCurrencies().listen((event) {
      _items.addAll(event);
      notifyListeners();
    }).onError((handleError) {
      _errorController.addError(handleError);
    });
  }
}