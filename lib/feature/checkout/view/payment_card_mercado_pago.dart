import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PaymentCardMercadoPago extends StatefulWidget {
  const PaymentCardMercadoPago({Key? key}) : super(key: key);

  @override
  State<PaymentCardMercadoPago> createState() =>
      _PaymentCardMercadoPagoState();
}

class _PaymentCardMercadoPagoState extends State<PaymentCardMercadoPago> {
  //final CardObject objeto = Get.arguments;
  late ValueNotifier<bool> _saveCard;
  late ValueNotifier<String> _issuerLogoNotifier;
  String selectedOption = 'CPF'; // Opção selecionada inicialmente
  String parcelaOption = '1'; // Opção selecionada inicialmente
  final List<String> items = ['CPF', 'CNPJ']; // Lista de opções
  final List<String> parcelas = ['1', '2', '3', '4', '5', '6']; // Lista de opções

  String documentMask = '###.###.###-##'; // Máscara padrão para CPF

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController documentoController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController mesController = TextEditingController();
  final TextEditingController anoController = TextEditingController();

  @override
  void initState() {
    super.initState();
     _issuerLogoNotifier = ValueNotifier<String>('');  
     _saveCard = ValueNotifier<bool>(false);  
    cardNumberController.addListener(checkCardInfo);
    documentoController.addListener(checkCardInfo);
    cvvController.addListener(checkCardInfo);
    nomeController.addListener(checkCardInfo);
    mesController.addListener(checkCardInfo);
    anoController.addListener(checkCardInfo);
  }

  @override
  void dispose() {
    cardNumberController.removeListener(checkCardInfo);
    documentoController.removeListener(checkCardInfo);
    cvvController.removeListener(checkCardInfo);
    nomeController.removeListener(checkCardInfo);
    mesController.removeListener(checkCardInfo);
    anoController.removeListener(checkCardInfo);
    super.dispose();
  }
       
  int lastCardNumberLength = 0;
  Future<void> checkCardInfo() async {
      if(cardNumberController.text.length == 3 && cardNumberController.text.length != lastCardNumberLength && _issuerLogoNotifier.value != ''){
        lastCardNumberLength = cardNumberController.text.length;
        _issuerLogoNotifier.value = '';
      }
      if(cardNumberController.text.length == 6 && cardNumberController.text.length != lastCardNumberLength){
        lastCardNumberLength =  cardNumberController.text.length;
      }
    if (cardNumberController.text.length == 7 && cardNumberController.text.length != lastCardNumberLength) {
      lastCardNumberLength = cardNumberController.text.length;
      //await cardInfoInstallments(objeto.orderRepo, cardNumberController.text, objeto.order!.orderAmount!);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text(
          'Informações do cartão',
          style: TextStyle(color: Colors.white),
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
            child: Form(
              child: Column(
                children: [
                  SizedBox(
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: selectedOption,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedOption = newValue!;
                                      // Atualiza a máscara do documento com base no tipo selecionado
                                      documentMask = selectedOption == 'CPF'
                                          ? '###.###.###-##'
                                          : '##.###.###/####-##';
                                    });
                                  },
                                  items: items.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  decoration: const InputDecoration(
                                    labelText: 'Tipo de documento',
                                    enabledBorder: InputBorder.none,
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: documentoController,
                                  inputFormatters: [
                                    MaskTextInputFormatter(
                                        mask: documentMask,
                                        filter: {
                                          "#": RegExp(r'[0-9]'),
                                        })
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: "Número do documento",
                                    enabledBorder: InputBorder.none,
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Color(0xFFFFFFFF),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: const BoxDecoration(
                                border: BorderDirectional(bottom: BorderSide(width: 1, color: Color(0xFFE0DFDF),))
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                             Expanded(
                              child: TextFormField(
                                controller: cardNumberController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  MaskTextInputFormatter(
                                    mask: '#### #### #### ####',
                                    filter: {"#": RegExp(r'[0-9]')})
                                ],
                                onChanged: (value) => checkCardInfo(),
                                decoration: InputDecoration(
                                  labelText: "Número do cartão",
                                  enabledBorder: InputBorder.none,
                                  border: const OutlineInputBorder(),
                                  filled: true,
                                  fillColor: const Color(0xFFFFFFFF),
                                  suffixIcon: ValueListenableBuilder<String>(
                                    valueListenable: _issuerLogoNotifier,
                                    builder: (context, value, child) {
                                      return Visibility(
                                      visible: value == '' ? false : true,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset('../../../../assets/images/logo.png'),
                                      ),
                                    );
                                    },
                                  ),
                                ),
                              ),
                            ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: cvvController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    MaskTextInputFormatter(
                                        mask: '###',
                                        filter: {"#": RegExp(r'[0-9]')})
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: "CVV",
                                    border: OutlineInputBorder(),
                                    enabledBorder: InputBorder.none,
                                    filled: true,
                                    fillColor: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          TextFormField(
                            controller: nomeController,
                            decoration: const InputDecoration(
                              labelText: "Nome do titular",
                              border: OutlineInputBorder(),
                              enabledBorder: InputBorder.none,
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                            ),
                          ),

                          SizedBox(height: 10),

                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Expanded(
                                  child: TextFormField(
                                    controller: mesController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      MaskTextInputFormatter(
                                          mask: '##',
                                          filter: {"#": RegExp(r'[0-9]')})
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: "(MM)",
                                      enabledBorder: InputBorder.none,
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 80,
                                child: Expanded(
                                  child: TextFormField(
                                    controller: anoController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      MaskTextInputFormatter(
                                          mask: '####',
                                          filter: {"#": RegExp(r'[0-9]')})
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: "(AAAA)",
                                      enabledBorder: InputBorder.none,
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                              ),
                                  const SizedBox(width: 10),

                                  ValueListenableBuilder<String>(
                                    valueListenable: _issuerLogoNotifier,
                                    builder: (context, value, child) {
                                      return Visibility(
                                      visible: value == '' ? false : true,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset('../../../../assets/images/logo.png')
                                      ),
                                    );
                                    },
                                  ),
                              ValueListenableBuilder<bool>(
                                valueListenable: _saveCard,
                                builder: (context, value, child) {
                                  return Visibility(
                                    //visible: objeto.isGuest == false,
                                    child:    Checkbox(
                                  value: _saveCard.value,
                                  onChanged: (value) {
                                        _saveCard.value = value!;
                                  },
                                ));
                                }
                              
                              ),
                              const Text('Salvar cartão?'),

                            ],
                          ),
                          
                          const SizedBox(height: 10),
                          Visibility
                          (
                            //visible: objeto.installmentable && objeto.paymentTypeId == "credit_card",
                            child: DropdownButtonFormField<String>(
                              value: parcelaOption,
                              onChanged: (String? newValue) {
                                setState(() {
                                  parcelaOption = newValue!;
                                });
                              },
                              items: parcelas.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                labelText: 'Parcelas',
                                enabledBorder: InputBorder.none,
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                              ),
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
                                          child:  Image.asset('../../../../assets/images/logo.png')
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                          10), // Espaçamento entre a imagem e o texto
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Loja',
                                              style:const TextStyle(
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'N pedido 000',
                                              style: const TextStyle(
                                                color: Color(0xFF797979),
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text(
                                                  "Total",
                                                  style: TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const SizedBox(width: 80),
                                                Text(
                                                  '20',
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
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 350,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00CCFF)
                      ),
                      onPressed: () {
                        print("clicou");
                        print("Tipo de documento: $selectedOption");
                        print("Documento: ${documentoController.text}");
                        print("Número do cartão: ${cardNumberController.text}");
                        print("CVV: ${cvvController.text}");
                        print("Nome do titular: ${nomeController.text}");
                        print("Mês de validade: ${mesController.text}");
                        print("Ano de validade: ${anoController.text}");
                        print("Parcelas: $parcelaOption");
                      },
                      child: const Text(
                        'Confirmar pagamento',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*void makeCardPayment() async{
    var paymentData = CardPaymentBody(
    orderId: objeto.orderId,
    saveCard: _saveCard.value,
    isGuest: objeto.isGuest,
    customerId: objeto.userId,
    cardNumber: cardNumberController.text,
    expirationYear: int.tryParse(anoController.text),
    expirationMonth: int.tryParse(mesController.text),
    email: objeto.guestEmail,
    transactionAmount: objeto.order!.orderAmount!,
    issuerId: objeto.issuerId,
    paymentMethodId: objeto.paymentMethodId,
    paymentTypeId: objeto.paymentTypeId,
    identification: Identification(type: selectedOption, number: documentoController.text),
    securityCode: 123,
  );
  var response = await objeto.orderRepo.makeCardPayment(paymentData);
  if (response.statusCode == 200) {

  } else {
      ApiChecker.checkApi(response);
    }
  

  }

  Future<void> cardInfoInstallments(OrderRepo orderRepo, String card, double amount) async {
    Response response = await orderRepo.cardInfoInstallments(
      '${AppConstants.baseUrl}${RouteHelper.getMercadoPagoInstallmentsRoute(card.removeAllWhitespace, amount)}'
    );
    if (response.statusCode == 200) {
      var responseBody = response.body;
      print(responseBody);
      if (responseBody is List && responseBody.isNotEmpty) {
        objeto.paymentMethodId = responseBody[0]['payment_method_id'];
        objeto.paymentTypeId = responseBody[0]['payment_type_id'];
        objeto.issuerId = responseBody[0]['issuer']['id'];
        _issuerLogoNotifier.value = responseBody[0]['issuer']['secure_thumbnail'];
        objeto.installments = responseBody[0]['payer_costs'];
      }
    } else {
      ApiChecker.checkApi(response);
    }
  }

}

*/
}

/*
class CardObject extends ChangeNotifier {
  final String? storeName;
  final String? storeLogo;
  final PlaceOrderBody? order;
  final OrderRepo orderRepo;
  final String orderId;
  String issuerId = '';
  String issuerLogo = '';
  String paymentTypeId = '';
  String paymentMethodId = '';
  List installments = [];
  bool installmentable = false;
  bool isGuest = false;
  String? guestEmail;
  int? userId;

  CardObject(this.storeName, this.storeLogo, this.orderId, this.installmentable, this.isGuest, this.guestEmail, this.userId);
}

*/