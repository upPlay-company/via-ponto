import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:viaponto_oficial/screens/base/base_screen.dart';
import 'package:viaponto_oficial/screens/login/login_screen.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

class InicialTile extends StatelessWidget {

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: 100,),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/logo_inicial.png'),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Ferramenta de registro de ponto',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18
                    ),
                  ),
                  Text(
                    'e localização digital',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18
                    ),
                  ),
                  SizedBox(height: 100,),
                  SizedBox(
                    height: 44,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: (){
                        if(userManagerStore.isLoggedIn)
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BaseScreen()
                          ));
                        else
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()
                          ));
                      },
                      child: Text('ENTRAR', style: TextStyle(color: Colors.white, fontSize: 16),),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Text(
                    'Quer utilizar o VIA PONTO?',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16
                    ),
                  ),
                  Text(
                    'Registre Agora',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
