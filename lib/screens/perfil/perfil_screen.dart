import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

class PerfilScreen extends StatelessWidget {

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {

    Color primary = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Conta', style: TextStyle(color: Colors.white),),
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
                    Text(userManagerStore.user.email, style: TextStyle(fontSize: 18, color: primary),),
                    GestureDetector(
                        onTap: (){},
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
                child: Text('Empresa', style: TextStyle(fontSize: 18),)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16),
            child: Container(
                child: Text(userManagerStore.user.nomeEmpresa, style: TextStyle(fontSize: 18, color: primary),)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16),
            child: Container(
                child: Text('Cargo', style: TextStyle(fontSize: 18),)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16),
            child: Container(
                child: Text(userManagerStore.user.cargo, style: TextStyle(fontSize: 18, color: primary),)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16),
            child: Container(
                child: Text('Departamento', style: TextStyle(fontSize: 18),)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16),
            child: Container(
                child: Text(userManagerStore.user.departamento, style: TextStyle(fontSize: 18, color: primary),)),
          ),
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16),
            child: Container(
                child: Text('HORÁRIOS', style: TextStyle(fontSize: 18),)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16),
            child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO: ESPECIFICA HORARIO BANCO
                    Text('Segunda à sexta:', style: TextStyle(fontSize: 18, color: Colors.black),),
                    Text('08:00 as 12:00 / 14:00 as 18:00', style: TextStyle(fontSize: 18, color: primary),),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16),
            child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO: ESPECIFICA HORARIO BANCO
                    Text('Sábado:', style: TextStyle(fontSize: 18, color: Colors.black),),
                    Text('08:00 as 13:00', style: TextStyle(fontSize: 18, color: primary),),
                  ],
                )),
          ),
          SizedBox(height: 20,),
        ]
      ),
    );
  }
}
