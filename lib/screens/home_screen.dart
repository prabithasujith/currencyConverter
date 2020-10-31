import 'package:currencyConverter/models/CurrencyResponse.dart';
import 'package:currencyConverter/providers/auth_provider.dart';
import 'package:currencyConverter/providers/currency_provider.dart';
import 'package:currencyConverter/screens/add_base_currency.dart';
import 'package:currencyConverter/screens/add_currency_screen.dart';
import 'package:currencyConverter/screens/login_screen.dart';
import 'package:currencyConverter/widgets/button_widget.dart';
import 'package:currencyConverter/widgets/loading_widget.dart';
import 'package:currencyConverter/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const style1 =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18);

class HomeScreen extends StatefulWidget {
  static const String route = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _refresh = true;
  CurrencyResponse _currency;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CurrencyProvider>(context);
    var authProvider = Provider.of<Auth>(context);
    _currency = provider.getCurrency;
    if (_refresh) {
      provider.getCurrencies();
      _refresh = false;
    }
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //title
                TitleWidget(),
                //refresh button
                (_currency != null && _currency.rates != null)
                    ? Expanded(
                        flex: 3,
                        child: Container(
                          child: Column(
                            children: [
                              MaterialButton(
                                  child: ButtonWidget(
                                    icon: Icons.refresh,
                                    title: 'Refresh',
                                  ),
                                  onPressed: () {
                                    provider.getCurrencies();
                                  }),
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          _currency.base +
                                              ' Value : 1 ' +
                                              _currency.base,
                                          style: style1),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed(AddBaseCurrency.route);
                                        },
                                        child: ButtonWidget(
                                            icon: Icons.add,
                                            title: 'Edit Base currency'),
                                      )
                                    ]),
                              ),
                              Divider(
                                color: Colors.white,
                                height: 1,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(AddCurrencyScreen.route);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Today\'s value',
                                          style: style1,
                                        ),
                                        ButtonWidget(
                                            icon: Icons.add,
                                            title: 'Add more currency')
                                      ],
                                    ),
                                  )),

                              Expanded(
                                child: ListView.builder(
                                  itemBuilder: (ctx, i) {
                                    return Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _currency.rates[i].currency +
                                                ' Value: ' +
                                                _currency.rates[i].value
                                                    .toStringAsFixed(2),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Divider(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: _currency.rates.length,
                                ),
                              ),
                              //logout
                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'LOGOUT',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                onTap: () async {
                                  await authProvider.handleSignOut();
                                  Navigator.of(context)
                                      .popAndPushNamed(LoginScreen.route);
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    : LoadingWidget(),
              ],
            ),
          ),
        ));
  }
}
