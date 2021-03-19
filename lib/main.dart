import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:viaponto_oficial/screens/base/base_screen.dart';
import 'package:viaponto_oficial/screens/inicial/inicial_screen.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setupLocation();
  runApp(MyApp());
}

  GetIt location = GetIt.instance;

void setupLocation(){
  location.registerSingleton(UserManagerStore());
}

Future<void> initializeParse() async {
  await Parse().initialize(
    'Sgx1E183pBATq8APs006w2ACmAPqpkk33jJwRGC6',
    'https://parseapi.back4app.com/',
    clientKey: 'X7t0Z2Zzu00dy1KSfpr4KkiJ5bhZneldgZrpPzOf',
    debug: false,
    autoSendSessionId: true,
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Via Ponto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff1dbf73),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      initialRoute: 'inicial',
      onGenerateRoute: (settings){
        switch(settings.name){
          case '/base':
            return MaterialPageRoute(
              builder: (_) => BaseScreen()
            );
          case '/inicial':
            default:
              return MaterialPageRoute(
                builder: (_) => InicialScreen()
            );
        }
      },
    );
  }
}