import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:viaponto_oficial/common/error_box.dart';
import 'package:viaponto_oficial/store/login_store.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore loginStore = LoginStore();

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();

    when((_) => userManagerStore.user != null, () {
      Navigator.of(context).pushNamed('/base');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Funcionário', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Insira seus dados por favor', style: TextStyle(fontSize: 18, color: Colors.white),),
                  ],
                ),
              ),
            ),
            SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Observer(builder: (_){
                    return Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 8),
                              child: TextFormField(
                                onChanged: loginStore.setEmail,
                                enabled: !loginStore.loading,
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20),
                                    border: InputBorder.none,
                                    icon: Icon(Icons.email, color: Theme.of(context).primaryColor,),
                                    hintText: 'Informe seu email',
                                    hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w800)
                                ),
                              )
                          ),
                        ));
                  }),
                  Observer(builder: (_){
                    return Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 8),
                            child: TextFormField(
                              onChanged: loginStore.setPassword,
                              enabled: !loginStore.loading,
                              obscureText: true,
                              autocorrect: false,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20),
                                  border: InputBorder.none,
                                  icon: Icon(Icons.lock, color: Theme.of(context).primaryColor,),
                                  hintText: 'Informe sua senha',
                                  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w800)
                              ),
                            ),
                          ),
                        ));
                  }),
                  Observer(builder: (_){
                    return Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
                      child: SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: loginStore.loginPressed,
                          child: loginStore.loading
                          ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(
                            Colors.white
                            ),
                          ): Text('CONTINUAR', style: TextStyle(color: Colors.white, fontSize: 16),),
                        ),
                      ),
                    );
                  }),
                  Observer(builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ErrorBox(
                        message: loginStore.error,
                      ),
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
