import 'package:currencyConverter/providers/currency_provider.dart';
import 'package:currencyConverter/screens/add_currency_screen.dart';
import 'package:currencyConverter/screens/home_screen.dart';
import 'package:currencyConverter/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBaseCurrency extends StatefulWidget {
  static const String route = 'AddCurrencyRoute';
  @override
  _AddBaseCurrencyState createState() => _AddBaseCurrencyState();
}

class _AddBaseCurrencyState extends State<AddBaseCurrency> {
  String _selectedCurrency;
  bool isFirstTime = true;

  List<DropdownMenuItem<String>> currencies = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CurrencyProvider>(context, listen: false);

    if (isFirstTime) {
      provider.currenciesList.forEach((element) {
        currencies.add(DropdownMenuItem(
          child: Text(element),
          value: element,
        ));
      });
      isFirstTime = false;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TitleWidget(),
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select your base',
                        style: style1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(color: Colors.white),
                                child: DropdownButtonFormField(
                                    value: _selectedCurrency,
                                    hint: Text(
                                        'Currency Code \'INR\',\'USD\'... '),
                                    style: TextStyle(color: Colors.black),
                                    items: currencies,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCurrency = value;
                                      });
                                    })),
                            MaterialButton(
                                child: Text(
                                  'NEXT',
                                  style: style,
                                ),
                                onPressed: () {
                                  if (_selectedCurrency != null &&
                                      _selectedCurrency.isNotEmpty)
                                    provider.addBaseCurrency(_selectedCurrency);

                                  Navigator.of(context)
                                      .popAndPushNamed(AddCurrencyScreen.route);
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
