import 'package:flutter/material.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({Key key}) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  //Gerencia qual formulario estara em foco
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  void _updateImage() {
    setState(() {});
  }

//Dispose libera o uso de memoria
  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImage);
    _imageUrlFocusNode.dispose();
  }

  @override
  //Avisa que agora existe uma imagem a ser carregada
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImage);
  }

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
          children: <Widget>[
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
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Descrição'),
              maxLines: 3,
              focusNode: _descriptionFocusNode,
              keyboardType: TextInputType.multiline,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Url Da Imagem'),
                    keyboardType: TextInputType.url,
                    focusNode: _imageUrlFocusNode,
                    controller: _imageUrlController,
                    //Finaliza o formulario
                    textInputAction: TextInputAction.done,
                  ),
                ),

                //Container onde a imagem sera exibida
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(top: 8, left: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  alignment: Alignment.center,

                  //Utiliza do controller pra saber quando exibir oque,se estiver vazia exibe o texto e quando completa exibe a imagem
                  child: _imageUrlController.text.isEmpty
                      ? Text('Infome a Url')
                      : FittedBox(
                          child: Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
