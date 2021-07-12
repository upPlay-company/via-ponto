import 'package:viaponto_oficial/model/bater_ponto/departament.dart';
import 'package:viaponto_oficial/model/empresas/empresas.dart';

class User {

  String id;
  String name;
  String userName;
  String email;
  Empresas idEmpresa;
  String nomeEmpresa;
  String phone;
  String cpf;
  Departament departamento;
  String dataNasc;
  String password;
  bool demitido;
  DateTime createdAt;

  User({this.id,
      this.name,
      this.userName,
      this.email,
      this.idEmpresa,
      this.nomeEmpresa,
      this.phone,
      this.cpf,
      this.departamento,
      this.dataNasc,
      this.password,
      this.createdAt,
      this.demitido});

  @override
  String toString() {
    return 'User{id: $id, name: $name, userName: $userName, email: $email, idEmpresa: $idEmpresa, nomeEmpresa: $nomeEmpresa, phone: $phone, cpf: $cpf, departamento: $departamento, dataNasc: $dataNasc, password: $password, demitido: $demitido, createdAt: $createdAt}';
  }
}