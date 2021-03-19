import 'package:viaponto_oficial/model/empresas/empresas.dart';

class User {

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.createdAt,
    this.cargo,
    this.cpf,
    this.dataNasc,
    this.departamento,
    this.idEmpresa,
    this.userName,
    this.nomeEmpresa
  });

  String id;
  String name;
  String userName;
  String email;
  String cargo;
  Empresas idEmpresa;
  String nomeEmpresa;
  String phone;
  String cpf;
  String departamento;
  String dataNasc;
  String password;
  DateTime createdAt;

  @override
  String toString() {
    return 'User{id: $id, name: $name, userName: $userName, email: $email, cargo: $cargo, idEmpresa: $idEmpresa, nomeEmpresa: $nomeEmpresa, phone: $phone, cpf: $cpf, departamento: $departamento, dataNasc: $dataNasc, password: $password, createdAt: $createdAt}';
  }
}