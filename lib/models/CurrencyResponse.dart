import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CurrencyResponse extends Equatable {
   List<Rate> rates;
   String base;
   String date;

  CurrencyResponse({this.rates, this.base, this.date})
      : super([rates, base, date]);
  factory CurrencyResponse.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> map = json['rates'];
    List<Rate> rates = [];
    map.entries.forEach((element) {
      rates.add(Rate(currency: element.key, value: element.value));
    });
    return CurrencyResponse(
        base: json['base'], date: json['date'], rates: rates);
  }
}

class Rate extends Equatable {
  final String currency;
  final double value;
  Rate({@required this.currency, @required this.value});
}
