import 'package:flutter/material.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({Key key}) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  //Gerencia qual formulario estara em foco
  final _priceFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario do Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Titulo'),
              //faz com que ao terminar de digitar o texto o formulario jogue para o proximo campo
              textInputAction: TextInputAction.next,
              //Quando o campo for preenchido ele ativa a variavel de controle e muda pro proximo que sera o de preço
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
            ),
            TextFormField(
                decoration: InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                initialValue: 'R\$ ',
                //Utiliza da variavel de foco pra quando o usuario clicar em next o campo ser focado
                focusNode: _priceFocusNode,
                //Faz o teclado so mostrar numeros,que no caso e o campo de preço
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                )),
          ],
        )),
      ),
    );
  }
}
