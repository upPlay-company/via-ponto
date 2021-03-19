import 'package:flutter/material.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:viaponto_oficial/screens/home/home_screen.dart';
import 'package:viaponto_oficial/screens/perfil/perfil_screen.dart';

class BaseScreen extends StatefulWidget {

  @override
  _BaseScreenState createState() => _BaseScreenState();
}


class _BaseScreenState extends State<BaseScreen> {

  int _selectedIndex = 0;
  /*static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);*/
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Container(color: Colors.grey,),
    PerfilScreen()
  ];

  Widget currentScreen =  HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 65,
        child: bmnav.BottomNav(
          iconStyle: bmnav.IconStyle(color: Colors.black, onSelectColor: Theme.of(context).primaryColor),
          index: _selectedIndex,
          labelStyle: bmnav.LabelStyle(textStyle: TextStyle(color: Colors.black, fontSize: 10), onSelectTextStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14)),
          onTap: (i){
            setState(() {
              _selectedIndex = i;
              currentScreen = _widgetOptions[i];
            });
          },
          items: [
            bmnav.BottomNavItem(Icons.home, label: 'Home'),
            bmnav.BottomNavItem(Icons.description, label: 'Relatorio'),
            bmnav.BottomNavItem(Icons.person, label: 'Perfil'),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
