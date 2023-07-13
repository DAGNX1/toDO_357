
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/screen/home_layout.dart';
import 'package:to_do/screen/login_screen.dart';
import 'package:to_do/screen/regester_screen.dart';
import 'package:to_do/screen/update_screen.dart';
import 'package:to_do/style/theme.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async{

// Ideal time to initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) { return MyProvider(); },
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var prov=Provider.of<MyProvider>(context);
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate, // A
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
      locale: Locale(prov.langcode),
      debugShowCheckedModeBanner: false,
      initialRoute:prov.firebaseUser!=null?
      HomeLayout.routeName
      :LoginScreen.routeName ,
      routes: {
        HomeLayout.routeName:(context)=> HomeLayout(),
        UpdateScreen.routeName:(context)=> UpdateScreen(),
        LoginScreen.routeName:(context)=> LoginScreen(),
        RegisterScreen.routeName:(context)=> RegisterScreen(),

      },
      themeMode:prov.themeMode ,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
    );
  }
}
