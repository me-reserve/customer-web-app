
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PaymentPixMercadoPago extends StatefulWidget {
  const PaymentPixMercadoPago({Key? key}) : super(key: key);

  @override
  _PaymentPixMercadoPagoState createState() => _PaymentPixMercadoPagoState();
}

class _PaymentPixMercadoPagoState extends State<PaymentPixMercadoPago> {
  late PixObject objeto;
  late ValueNotifier<int> _contadorNotifier;
  late Timer _timer;
  bool _botaoDisponivel = true;

  @override
  void initState() {
    super.initState();
    //objeto = Get.arguments;
    _contadorNotifier = ValueNotifier<int>(40);
  }


  void _atualizarEstadoBotao(value) {
    setState(() {
      // Desativa o botão se _botaoDisponivel for falso
      _botaoDisponivel = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pagamento pix',
          style: TextStyle(color: Colors.white ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF00CCFF),
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Pagamento via Pix",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4E4E4E),
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Copie este código e cole no seu banco digital",
                  style: TextStyle(
                    color: Color(0xFF797979),
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                GetPlatform.isWeb
                    ? SizedBox(
                        width: 500,
                        child: QRCodeInput(text: "aHR0cHM6Ly90ZXN0ZS5tZXJlc2VydmUuY29tLmJyLw=="),
                      )
                    : const SizedBox(height: 0),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  width: 200,
                  child: Image.memory(base64Decode("aHR0cHM6Ly90ZXN0ZS5tZXJlc2VydmUuY29tLmJyLw==")),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      _botaoDisponivel ? _onButtonPressed : null;
                    },
                    child: ValueListenableBuilder<int>(
                      valueListenable: _contadorNotifier,
                      builder: (context, value, child) {
                        return _botaoDisponivel
                            ? const Text("Efetuei o pagamento")
                            : Text("Aguarde $value segundos");
                      },
                    )
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 100,
                    width: 400,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset('../../../../assets/images/logo.png')
                              ),
                            ),
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'MR',
                                    style: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                   Text(
                                    'Nº pedido 4',
                                    style: const TextStyle(
                                      color: Color(0xFF797979),
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Total",
                                        style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'R\$ 100',
                                        style: const TextStyle(
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onButtonPressed() async {
    _atualizarEstadoBotao(false);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_contadorNotifier.value > 0) {
          _contadorNotifier.value--;
        } else {
          timer.cancel();
          _atualizarEstadoBotao(true);
          _contadorNotifier.value = 40;
        }
      });

    /*await paymentConfirmed(objeto.orderRepo, objeto.paymentId);
    if (objeto.status != "success" && objeto.status != "cancelled") {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_contadorNotifier.value > 0) {
          _contadorNotifier.value--;
        } else {
          timer.cancel();
          _atualizarEstadoBotao(true);
          _contadorNotifier.value = 40;
        }
      });
    }

    if (objeto.status == "success") {
      String? contactNumber;
      Get.offNamed(RouteHelper.getOrderSuccessRoute(
          objeto.orderId, contactNumber));
    }
    if (objeto.status == "cancelled") {
      Get.back();
    }
  }
  */

  @override
  void dispose() {
    _timer.cancel();
    _contadorNotifier.dispose();
    super.dispose();
  }

  /*

  Future<void> paymentConfirmed(OrderRepo orderRepo, int id) async {
    Response response = await orderRepo.paymentConfirmed(
        '${AppConstants.baseUrl}${AppConstants.mercadoPagoUri}$id');
    if (response.statusCode == 200) {
      objeto.status = response.body[0]['status'];
      if (response.body[0]['status'] == 'success') {
        objeto.orderId = response.body[0]['order_id'];
      }
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
*/
}
}

class QRCodeInput extends StatelessWidget {
  final String text;

  const QRCodeInput({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: text,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        labelText: 'Código QR',
        suffixIcon: IconButton(
          icon: const Icon(Icons.content_copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: text));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Color(0xFF00CCFF),
                content:
                    Text('Código QR copiado para a área de transferência'),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PixObject {
  final String qrCode;
  final String qrCodeBase64;
  final double? transactionAmount;
  final String? storeName;
  final String? storeLogo;
  //final OrderRepo orderRepo;
  final int paymentId;
  String orderId = '';
  String status = '';
  //PlaceOrderBody? order;

  PixObject(this.qrCode, this.qrCodeBase64, this.transactionAmount,
      this.storeName, this.storeLogo, this.paymentId, this.orderId);
}



