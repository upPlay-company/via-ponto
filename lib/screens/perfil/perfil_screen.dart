import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:viaponto_oficial/screens/account/edit_account_screen.dart';
import 'package:viaponto_oficial/screens/inicial/components/inicial_tile.dart';
import 'package:viaponto_oficial/screens/perfil/dia_semana_screen.dart';
import 'package:viaponto_oficial/store/my_turno_store.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

class PerfilScreen extends StatelessWidget {

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  final MyTurnoStore store = MyTurnoStore();

  @override
  Widget build(BuildContext context) {

    Color primary = Theme.of(context).primaryColor;
     return Scaffold(
        appBar: AppBar(
          title: Text('Minha Conta', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: Container(
                  child: Text('Nome', style: TextStyle(fontSize: 18),)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: Container(
                  child: Text(userManagerStore.user.name, style: TextStyle(fontSize: 18, color: primary),)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: Container(
                  child: Text('Email', style: TextStyle(fontSize: 18),)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(userManagerStore.user.email, style: TextStyle(fontSize: 18, color: primary)),
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditAccountScreen()));
                          },
                          child: Icon(Icons.edit, color: primary,))
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: Container(
                  child: Text('Celular', style: TextStyle(fontSize: 18),)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: Container(
                  child: Text(userManagerStore.user.phone, style: TextStyle(fontSize: 18, color: primary),)),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: Container(
                  child: Text('HORÁRIOS', style: TextStyle(fontSize: 18),)),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                  itemCount: store.allAds.length,
                  itemBuilder: (_, index){
                    if(store.allAds[index].empresas.id == userManagerStore.user.idEmpresa.id)
                      return DiaSemanaScreen(store.allAds[index]);
                    else
                      return Container();
                  }
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.grey[300],
            ),
            Container(
              height: 40,
              color: Colors.grey[200],
              child: Center(
                  child: GestureDetector(
                    onTap: (){
                        userManagerStore.logout();
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => InicialTile()));
                    },
                    child: Text('Sair', style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.grey[300],
            ),
            SizedBox(height: 25,)
          ]
        ),
      );
  }
}
