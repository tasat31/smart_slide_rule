import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// commons
import 'package:smart_slide_rule/commons/themes/default.dart';
//models
import 'package:smart_slide_rule/models/login.dart';
import 'package:smart_slide_rule/models/cart.dart';
import 'package:smart_slide_rule/models/catalog.dart';
import 'package:smart_slide_rule/models/strength.dart';
import 'package:smart_slide_rule/models/link_budget.dart';

// screens
import 'package:smart_slide_rule/screens/login.dart';
import 'package:smart_slide_rule/screens/home.dart';
import 'package:smart_slide_rule/screens/settings.dart';
import 'package:smart_slide_rule/screens/catalog.dart';
import 'package:smart_slide_rule/screens/cart.dart';
import 'package:smart_slide_rule/screens/strength.dart';
import 'package:smart_slide_rule/screens/multi_media.dart';
import 'package:smart_slide_rule/screens/link_budget.dart';
import 'package:smart_slide_rule/screens/hydropump.dart';
import 'package:smart_slide_rule/screens/regression.dart';
import 'package:smart_slide_rule/screens/easy_ml.dart';

class ProviderApp extends StatelessWidget {
  const ProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => LoginModel()),
        Provider(create: (context) => CatalogModel()),
        Provider(create: (context) => StrengthModel()),
        Provider(create: (context) => LinkBudgetModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProvider<LoginModel>(
          create: (context) => LoginModel(),
        ),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
        ChangeNotifierProvider<StrengthModel>(
          create: (context) => StrengthModel(),
        ),
        ChangeNotifierProvider<LinkBudgetModel>(
          create: (context) => LinkBudgetModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const Login(),
          '/home': (context) => const Home(),
          '/settings': (context) => const Settings(),
          '/catalog': (context) => const Catalog(),
          '/cart': (context) => const Cart(),
          '/strength': (context) => const Strength(),
          '/multi-media': (context) => const MultiMedia(),
          '/link-budget': (context) => const LinkBudget(),
          '/hydropump': (context) => const Hydropump(),
          '/regression': (context) => const Regression(),
          '/easy-ml': (context) => const EasyML(),
        },
      ),
    );
  }
}
