import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:viaponto_oficial/common/error_box.dart';
import 'package:viaponto_oficial/screens/inicial/components/inicial_tile.dart';
import 'package:viaponto_oficial/store/edit_account_store.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';


class EditAccountScreen extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {

  final EditAccountStore store = EditAccountStore();

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();

    when((_) => store.saveAd, () {
        userManagerStore.logout();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => InicialTile()));
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Conta', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  Observer(builder: (_) {
                    return TextFormField(
                      initialValue: store.email,
                      enabled: !store.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Nome*',
                        errorText: store.emailError,
                      ),
                      onChanged: store.setEmail,
                    );
                  }),
                  const SizedBox(height: 8),
                  Observer(builder: (_) {
                    return TextFormField(
                      enabled: !store.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Nova Senha',
                      ),
                      obscureText: true,
                      onChanged: store.setPass1,
                    );
                  }),
                  const SizedBox(height: 8),
                  Observer(builder: (_) {
                    return TextFormField(
                      enabled: !store.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Confirmar Nova Senha',
                        errorText: store.passError,
                      ),
                      obscureText: true,
                      onChanged: store.setPass2,
                    );
                  }),
                  const SizedBox(height: 12),
                  Observer(builder: (_) {
                    return SizedBox(
                      height: 40,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                        elevation: 0,
                        textColor: Colors.white,
                        child: store.loading
                            ? CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation(Colors.white),
                        )
                            : Text('Salvar'),
                        onPressed: store.savePressed,
                      ),
                    );
                  }),
                  Observer(builder: (_) {
                    return ErrorBox(
                      message: store.error,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

