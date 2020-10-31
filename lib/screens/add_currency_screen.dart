import 'package:currencyConverter/providers/currency_provider.dart';
import 'package:currencyConverter/screens/home_screen.dart';
import 'package:currencyConverter/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCurrencyScreen extends StatefulWidget {
  static const String route = 'AddCurrency';
  @override
  _AddCurrencyScreenState createState() => _AddCurrencyScreenState();
}

class _AddCurrencyScreenState extends State<AddCurrencyScreen> {
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

    provider.currenciesList.forEach((element) {
      currencies.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });

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
                        'Currencies to compare',
                        style: style1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                decoration: BoxDecoration(color: Colors.white),
                                child: DropdownButton(
                                    hint: Text(
                                        'Currency Code \'INR\',\'USD\'... '),
                                    style: TextStyle(color: Colors.black),
                                    items: currencies,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCurrency = value;
                                      });
                                    })),
                            IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (_selectedCurrency != null &&
                                      _selectedCurrency.isNotEmpty)
                                    provider.addCurrency(_selectedCurrency);
                                  setState(() {});
                                })
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (ctx, i) {
                            return Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider.userSelectedCurrenciesList[i],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Divider(
                                    height: 10,
                                  )
                                ],
                              ),
                            );
                          },
                          itemCount: provider.userSelectedCurrenciesList.length,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'NEXT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).popAndPushNamed(HomeScreen.route);
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
