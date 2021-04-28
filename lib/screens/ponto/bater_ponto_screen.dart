import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:mobx/mobx.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:viaponto_oficial/helpers/geolocalizacaoHelper.dart';
import 'package:viaponto_oficial/helpers/geralHelper.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/model/location/geolocalizacao.dart';
import 'package:viaponto_oficial/screens/base/base_screen.dart';
import 'package:viaponto_oficial/store/bater_ponto_store.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

class BaterPontoScreen extends StatefulWidget {
  BaterPontoScreen({this.ponto, this.myPontoStore});

  final BaterPonto ponto;
  final MyPontoStore myPontoStore;

  @override
  _BaterPontoScreenState createState() => _BaterPontoScreenState(ponto);
}

class _BaterPontoScreenState extends State<BaterPontoScreen> {

  bool carregando = false;
  bool gpsHabilitadoParaUso = false;
  bool configuracoesSalvas = false;
  String statusGPS;
  String ultimaLocalizacaoLatitude;
  String ultimaLocalizacaoLongitude;
  String ultimaLocalizacaoNome;
  String localizacaoAtualLatitude;
  String localizacaoAtualLongitude;
  String localizacaoAtualNome;
  PrecisaoLocalizacaoEnum precisaoLocalizacao = PrecisaoLocalizacaoEnum.melhorParaNavegacao;
  MetodoLocalizacaoEnum metodoLocalizacao = MetodoLocalizacaoEnum.sempre;
  GeolocalizacaoHelper _geolocalizacaoHelper = GeolocalizacaoHelper();

  _BaterPontoScreenState(BaterPonto ponto)
      : editing = ponto != null,
        store = BaterPontoStore(ponto: ponto ?? BaterPonto());

  final BaterPontoStore store;

  bool editing;

  DateTime date = DateTime.now();

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();


  @override
  void initState() {
    super.initState();
    _verificaStatusAcessoGPS();
    when((_) => store.savedAd, () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => BaseScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Observer(builder: (_) {
                  if (store.loading)
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'REGISTRANDO PONTO',
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).primaryColor),
                          ),

                        ],
                      ),
                    );
                  else
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text('PONTO DE ENTRADA E SAÍDA',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 15, right: 8),
                                child: TextFormField(
                                  initialValue: DateFormat(
                                      " d 'de' MMMM 'de' y", "pt_BR")
                                      .format(date),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  enabled: false,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        Icons.calendar_today,
                                        color: Colors.black,
                                      ),
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w800)),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 15, right: 8),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.alarm),
                                      DigitalClock(
                                        areaDecoration: BoxDecoration(
                                            color: Colors.transparent),
                                        areaAligment:
                                        AlignmentDirectional.center,
                                        hourMinuteDigitDecoration:
                                        BoxDecoration(
                                            color: Colors.transparent),
                                        secondDigitDecoration: BoxDecoration(
                                            color: Colors.transparent),
                                        hourMinuteDigitTextStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black),
                                        secondDigitTextStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        if(localizacaoAtualNome != null)
                          _constroiBlocoResultado(localizacaoAtualLatitude, localizacaoAtualLongitude, nomeLocalizacao: localizacaoAtualNome),
                        if(localizacaoAtualNome == null)
                          Padding(
                            padding: const EdgeInsets.only(right: 10, top: 5),
                            child: _constroiBotoes(),
                          ),
                        if(localizacaoAtualNome != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: Navigator.of(context).pop,
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                Observer(
                                  builder: (_) {
                                    return TextButton(
                                      onPressed: store.sendPressed,
                                      child: Text(
                                        'Enviar',
                                        style: TextStyle(
                                            color:
                                            Theme.of(context).primaryColor),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          )
                      ],
                    );
                }),
              )),
        ),
      ),
    );
  }

  Widget _constroiBotoes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 44,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
            ),
              child: carregando ?  CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                    Colors.blue),
              ) : Text("Obter Localização", style: TextStyle(color: Colors.blue),), onPressed: () => _navegaParaView()),
        ),
      ],
    );
  }

  Future _navegaParaView() async {
    await _verificaStatusAcessoGPS();
    if (gpsHabilitadoParaUso) {
      _recuperaLocalizacoes();
    }
  }

  Future _verificaStatusAcessoGPS() async {
    setState(() {
      carregando = true;
      statusGPS = "Verificando ...";
      gpsHabilitadoParaUso = false;
    });

    AcessoGPSDeviceEnum acessoGPSDevice;
    AcessoGPSAplicativoEnum acessoGPSAplicativo;

    acessoGPSDevice = await _geolocalizacaoHelper.verificaPermissaoDoDispositivoAcessoGPS();
    if (acessoGPSDevice == AcessoGPSDeviceEnum.disponivel) {
      acessoGPSAplicativo = await _geolocalizacaoHelper.verificaPermissaoDoAplicativoAcessoGPS();

      if (acessoGPSAplicativo != AcessoGPSAplicativoEnum.permitido) {
        PermissionStatus permissaoAplicativo = await LocationPermissions().requestPermissions();

        if (permissaoAplicativo != PermissionStatus.granted && permissaoAplicativo != PermissionStatus.restricted) {
          if (await GeralHelper.instancia.exibirMensagemAcaoUsuario(context, "Atenção", "Para usar este aplicativo, é necessário dar permissão para acessar sua localização.\nDeseja abrir as preferências de localizaçaão agora?", "Sim", "Não") == ResultadoMensagemEnum.ok) {
            await LocationPermissions().openAppSettings();
          }
        }

        acessoGPSAplicativo = await _geolocalizacaoHelper.verificaPermissaoDoAplicativoAcessoGPS();
      }
    }
    gpsHabilitadoParaUso = acessoGPSAplicativo == AcessoGPSAplicativoEnum.permitido;

    setState(() {
      statusGPS = acessoGPSDevice == null ? "Erro ao verificar status" : acessoGPSDevice == AcessoGPSDeviceEnum.indisponivel ? "O GPS do dispositivo está indisponível / desabilitado" : describeEnum(acessoGPSAplicativo);
      carregando = false;
    });
  }

  Widget _constroiBlocoResultado(String latitude, String longitude, {String nomeLocalizacao}) {
    store.setLocation(localizacaoAtualNome);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Icon(Icons.location_on_rounded),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 15, right: 10),
                  child: Text(nomeLocalizacao ?? "", style: TextStyle(fontWeight: FontWeight.bold), softWrap: true,),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Future _recuperaLocalizacoes() async {
    setState(() => carregando = true);

    GeolocalizacaoHelper geolocalizacaoHelper = GeolocalizacaoHelper.dadosMemoria();
    var ultimaPosicaoConhecida = await geolocalizacaoHelper.recuperarUltimaPosicaoConhecida();
    if (ultimaPosicaoConhecida != null) {
      ultimaLocalizacaoLatitude = ultimaPosicaoConhecida.latitude.toString();
      ultimaLocalizacaoLongitude = ultimaPosicaoConhecida.longitude.toString();

      var listaLocalizacoesEncontradas = await geolocalizacaoHelper.recuperarLocalizacaoDeUmaPosicao(ultimaPosicaoConhecida.latitude, ultimaPosicaoConhecida.longitude);
      ultimaLocalizacaoNome = listaLocalizacoesEncontradas == null ? "" : geolocalizacaoHelper.retornaNomeLocalizacao(listaLocalizacoesEncontradas[0]);
    }

    var posicaoAtual = await geolocalizacaoHelper.recuperarPosicaoAtual();
    if (posicaoAtual != null) {
      localizacaoAtualLatitude = posicaoAtual.latitude.toString();
      localizacaoAtualLongitude = posicaoAtual.longitude.toString();

      var listaLocalizacoesEncontradas = await geolocalizacaoHelper.recuperarLocalizacaoDeUmaPosicao(posicaoAtual.latitude, posicaoAtual.longitude);
      localizacaoAtualNome = listaLocalizacoesEncontradas == null ? "" : geolocalizacaoHelper.retornaNomeLocalizacao(listaLocalizacoesEncontradas[0]);
    }

    setState(() => carregando = false);
  }

}
