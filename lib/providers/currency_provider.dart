import 'package:currencyConverter/core/network_info.dart';
import 'package:currencyConverter/models/CurrencyResponse.dart';
import 'package:currencyConverter/repositories/currency_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyProvider with ChangeNotifier {
  CurrencyRepositiory currencyRepositiory;
  String base = '';
  List<String> userSelectedCurrenciesList = [];
  String user = '';
  CurrencyProvider(CurrencyRepositiory currencyRepositiory) {
    this.currencyRepositiory = currencyRepositiory;
  }

  Future<void> update(String user) async {
    this.user = user;
    await init();
  }

  CurrencyResponse _currency = CurrencyResponse();
  CurrencyResponse get getCurrency {
    return _currency;
  }

  Future<void> init() async {
    userSelectedCurrenciesList =
        await currencyRepositiory.getSavedCurrenciesTOConvert();
    base = await currencyRepositiory.getSavedBaseCurrency();
  }

  List<String> currenciesList = [
    "CAD",
    "HKD",
    "ISK",
    "PHP",
    "DKK",
    "HUF",
    "CZK",
    "AUD",
    "RON",
    "SEK",
    "IDR",
    "INR",
    "BRL",
    "RUB",
    "HRK",
    "JPY",
    "THB",
    "CHF",
    "SGD",
    "PLN",
    "BGN",
    "TRY",
    "CNY",
    "NOK",
    "NZD",
    "ZAR",
    "USD",
    "MXN",
    "ILS",
    "GBP",
    "KRW",
    "MYR"
  ];

  Future<void> getCurrencies() async {
    try {
      NetworkInfo networkInfo = NetworkInfo();
      if (await networkInfo.isNetworkConnected()) {
        CurrencyResponse currencyResponse =
            await currencyRepositiory.getCurrency();
        _currency = currencyResponse;
        notifyListeners();
      } else {}
    } catch (e) {
      throw UnimplementedError(e);
    }
  }

  Future<void> addBaseCurrency(String base) async {
    try {
      await currencyRepositiory.saveBaseCurrency(base);
      this.base = base;
      _currency.base = base;
      notifyListeners();
    } catch (e) {
      throw UnimplementedError(e);
    }
  }

  Future<void> addCurrency(String currency) async {
    try {
      await currencyRepositiory.addCurrencyToConvert(currency);
      userSelectedCurrenciesList.add(currency);
      notifyListeners();
    } catch (e) {
      throw UnimplementedError(e);
    }
  }

  List<String> dropDownitems() {
    List<String> _dropDownItems = currenciesList;
    userSelectedCurrenciesList.forEach((element) {
      _dropDownItems.remove(element);
    });
    return _dropDownItems;
  }
}
