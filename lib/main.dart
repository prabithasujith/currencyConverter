import 'package:currencyConverter/providers/auth_provider.dart';
import 'package:currencyConverter/providers/currency_provider.dart';
import 'package:currencyConverter/repositories/currency_repository.dart';
import 'package:currencyConverter/screens/add_base_currency.dart';
import 'package:currencyConverter/screens/add_currency_screen.dart';
import 'package:currencyConverter/screens/home_screen.dart';
import 'package:currencyConverter/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext mContext) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, CurrencyProvider>(create: (_) {
            return CurrencyProvider(CurrencyRepositoryImpl());
          }, update: (_, value, previous) {
            previous.update(value.user);
            return previous;
          }),
        ],
        child: Consumer<Auth>(builder: (ctx, auth, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Currency Converter',
            theme: ThemeData(
              primaryColor: Color(0xff005C9A),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: LoginScreen(),
            routes: {
              AddBaseCurrency.route: (ctx) => AddBaseCurrency(),
              HomeScreen.route: (ctx) => HomeScreen(),
              AddCurrencyScreen.route: (ctx) => AddCurrencyScreen(),
              LoginScreen.route: (ctx) => LoginScreen()
            },
          );
        }));
  }
}
