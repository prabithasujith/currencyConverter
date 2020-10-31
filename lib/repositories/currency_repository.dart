import 'dart:convert';

import 'package:currencyConverter/models/CurrencyResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const String BASE_CURRENCY = 'BASE_CURRENCY';

const String CURRENCY_LIST = 'CURRENCY_LIST';

const String CACHED_RESULT = 'CACHED_RESULT';

abstract class CurrencyRepositiory {
  Future<CurrencyResponse> getCurrency();
  Future<void> saveBaseCurrency(String base);
  Future<void> addCurrencyToConvert(String currency);
  Future<String> getSavedBaseCurrency();
  Future<List<String>> getSavedCurrenciesTOConvert();
}

class CurrencyRepositoryImpl extends CurrencyRepositiory {
  http.Client client = http.Client();
  @override
  Future<CurrencyResponse> getCurrency() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String base = sharedPreferences.getString(BASE_CURRENCY);
    String url = 'https://api.exchangeratesapi.io/latest?base=' + base;
    final response = await client.get(url);
    if (response.statusCode == 200) {
      var currencyResponse =
          CurrencyResponse.fromJson(json.decode(response.body));
      List<String> currencies = [];
      currencies = sharedPreferences.getStringList(CURRENCY_LIST);
      List<Rate> tempRate = [];
      currencies.forEach((currency) {
        currencyResponse.rates.forEach((rate) {
          if (rate.currency == currency) {
            tempRate.add(rate);
          }
        });

        
      });
currencyResponse.rates = tempRate;
      return currencyResponse;
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> addCurrencyToConvert(String currency) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> currencies = [];
    if (sharedPreferences.containsKey(CURRENCY_LIST)) {
      currencies = sharedPreferences.getStringList(CURRENCY_LIST);
      currencies.add(currency);
      sharedPreferences.setStringList(CURRENCY_LIST, currencies);
    } else {
      currencies.add(currency);
      sharedPreferences.setStringList(CURRENCY_LIST, currencies);
    }
  }

  @override
  Future<void> saveBaseCurrency(String base) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(BASE_CURRENCY, base);
  }

  @override
  Future<String> getSavedBaseCurrency() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(BASE_CURRENCY)) {
      return sharedPreferences.getString(BASE_CURRENCY);
    } else
      return "";
  }

  @override
  Future<List<String>> getSavedCurrenciesTOConvert() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> _currencyList = [];
    if (sharedPreferences.containsKey(CURRENCY_LIST))
      _currencyList = (sharedPreferences.getStringList(CURRENCY_LIST));

    return _currencyList;
  }
}
