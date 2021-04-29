import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:viaponto_oficial/screens/base/base_screen.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

import 'components/inicial_tile.dart';

class InicialScreen extends StatefulWidget {
  @override
  _InicialScreenState createState() => _InicialScreenState();
}

class _InicialScreenState extends State<InicialScreen> {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 1)).then((_) {
      if (!userManagerStore.isLoggedIn)
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => InicialTile()));
      else
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BaseScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/logo.png'),
          )),
        ),
      ),
    );
  }
}
