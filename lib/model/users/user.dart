import 'package:viaponto_oficial/model/empresas/empresas.dart';

class User {



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
  String semanaEntrada1;
  String semanaEntrada2;
  String semanaSaida1;
  String semanaSaida2;
  String sabadoEntrada1;
  String sabadoEntrada2;
  String sabadoSaida1;
  String sabadoSaida2;
  String domingoEntrada1;
  String domingoEntrada2;
  String domingoSaida1;
  String domingoSaida2;
  DateTime createdAt;

  @override
  String toString() {
    return 'User{id: $id, name: $name, userName: $userName, email: $email, cargo: $cargo, idEmpresa: $idEmpresa, nomeEmpresa: $nomeEmpresa, phone: $phone, cpf: $cpf, departamento: $departamento, dataNasc: $dataNasc, password: $password, createdAt: $createdAt}';
  }

  User({this.id,
      this.name,
      this.userName,
      this.email,
      this.cargo,
      this.idEmpresa,
      this.nomeEmpresa,
      this.phone,
      this.cpf,
      this.departamento,
      this.dataNasc,
      this.password,
      this.semanaEntrada1,
      this.semanaEntrada2,
      this.semanaSaida1,
      this.semanaSaida2,
      this.sabadoEntrada1,
      this.sabadoEntrada2,
      this.sabadoSaida1,
      this.sabadoSaida2,
      this.domingoEntrada1,
      this.domingoEntrada2,
      this.domingoSaida1,
      this.domingoSaida2,
      this.createdAt});
}