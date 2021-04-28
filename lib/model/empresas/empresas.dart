import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:viaponto_oficial/repository/table_keys.dart';

class Empresas {

  Empresas({this.id,
    this.nomeEmpresa,
    this.bairro,
    this.cnpj,
    this.razaoSocial,
    this.emailEmpresa,
    this.atividade,
    this.cep,
    this.uf,
    this.logradouro,
    this.celEmpresa,
    // ignore: non_constant_identifier_names
    this.IE,
    this.numero,
    this.telComercial
  });

  Empresas.fromParse(ParseObject parseObject)
      : id = parseObject.objectId,
  nomeEmpresa = parseObject.get(keyEmpresaName),
  bairro = parseObject.get(keyEmpresaBairro),
  cnpj = parseObject.get(keyEmpresaCnpj),
  razaoSocial = parseObject.get(keyEmpresaRazaoSocial),
  emailEmpresa = parseObject.get(keyEmpresaEmail),
  atividade = parseObject.get(keyEmpresaAtividade),
  cep = parseObject.get(keyEmpresaCep),
  uf = parseObject.get(keyEmpresaUF),
  logradouro = parseObject.get(keyEmpresaLogradouro),
  telComercial = parseObject.get(keyEmpresaTelefone),
  numero = parseObject.get(keyEmpresaNumero),
  IE = parseObject.get(keyEmpresaIE),
  celEmpresa = parseObject.get(keyEmpresaCelular);


  final String id;
  final String nomeEmpresa;
  final String bairro;
  final String cnpj;
  final String razaoSocial;
  final String emailEmpresa;
  final String atividade;
  final String cep;
  final String uf;
  final String logradouro;
  final String telComercial;
  final String numero;
  // ignore: non_constant_identifier_names
  final String IE;
  final String celEmpresa;

  @override
  String toString() {
    return 'Empresas{id: $id, nomeEmpresa: $nomeEmpresa, bairro: $bairro, cnpj: $cnpj, razaoSocial: $razaoSocial, emailEmpresa: $emailEmpresa, atividade: $atividade, cep: $cep, uf: $uf, logradouro: $logradouro, telComercial: $telComercial, numero: $numero, IE: $IE, celEmpresa: $celEmpresa}';
  }
}