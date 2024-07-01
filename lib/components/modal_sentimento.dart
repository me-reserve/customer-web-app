import 'package:demandium/components/core_export.dart';
import 'package:flutter/material.dart';

class ModalSentimento extends StatefulWidget {
  final VoidCallback onClose;

  ModalSentimento({required this.onClose});

  @override
  _ModalSentimentoState createState() => _ModalSentimentoState();
}

class _ModalSentimentoState extends State<ModalSentimento> {
  List<bool> _checkboxValues = List<bool>.filled(5, false);
  bool botaoHabilitado = false;
  TextEditingController observacao_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Como você está se sentindo hoje?'),
        
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: widget.onClose,
                ),
              ],
            ),
            
            SizedBox(height: 20),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCheckboxRow(0, 'assets/images/muito_triste.png'),
                _buildCheckboxRow(1, 'assets/images/triste.png'),
                _buildCheckboxRow(2, 'assets/images/normal.png'),
                _buildCheckboxRow(3, 'assets/images/feliz.png'),
                _buildCheckboxRow(4, 'assets/images/muito_feliz.png'),
              ],
            ),
            SizedBox(height: 20),

            Center(
              child: Column(children: [
                const Text("Adicione uma observação"),

                const SizedBox(
                  height: 10,
                ),

                Container(
                decoration: BoxDecoration(
                  color: Colors.transparent, // Cor de fundo desejada
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(style: BorderStyle.solid, color: Color(0xFFB4B4B4)) // Borda arredondada
                ),
                child: TextFormField(
                  controller: observacao_controller,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // Espaçamento interno do campo de texto
                    border: InputBorder.none, // Remover a borda padrão
                    hintText: 'Observação', // Texto de sugestão
                  ),
                ),
              ),
              ],),
            ),

            const SizedBox(height: 20),
        
            botaoHabilitado
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      backgroundColor: const Color(0xFF00CCFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: _areAnyCheckboxesChecked() ? _handleSubmit : null,
                    child: const Text(
                      'Enviar Feedback',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )
                : SizedBox(width: 0),
          ],
        ),
      ),
    );
  }

  Column _buildCheckboxRow(int index, String imagePath) {
    return Column(
      children: [
        Checkbox(
          value: _checkboxValues[index],
          onChanged: (bool? value) {
            setState(() {
              _checkboxValues[index] = value ?? false;
              _updateButtonState();
            });
          },
        ),
        SizedBox(height: 10),
        Image.asset(
          imagePath,
          width: 50,
          height: 50,
        ),
      ],
    );
  }

  bool _areAnyCheckboxesChecked() {
    return _checkboxValues.contains(true);
  }

  void _updateButtonState() {
    setState(() {
      botaoHabilitado = _checkboxValues.contains(true);
    });
  }

  void _handleSubmit() {
    List<int> selectedIndexes = [];
    for (int i = 0; i < _checkboxValues.length; i++) {
      if (_checkboxValues[i]) {
        selectedIndexes.add(i);
      }
    }
    print('Checkboxes selecionados: $selectedIndexes');
    print(observacao_controller.text);
    widget.onClose();
  }
}