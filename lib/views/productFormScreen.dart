import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';

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

//Recebe os dados do formulario
  final _formData = Map<String, Object>();

  //Gerenciar o Formulario(GlobalKey vem do material)
  final _form = GlobalKey<FormState>();

  void _updateImage() {
    if (isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }

//Validação da Url
  bool isValidImageUrl(String url) {
    bool startsWithHttp = url.toLowerCase().startsWith('http://');
    bool startsWithHttps = url.toLowerCase().startsWith('https://');
    bool endsWithPng = url.toLowerCase().endsWith('.png');
    bool endsWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endsWithJpeg = url.toLowerCase().endsWith('.jpeg');

    //Caso alguma das condições forem verdadeiras das duas diferentes validações a url e valida
    return (startsWithHttps || startsWithHttp) &&
        (endsWithJpeg || endsWithJpg || endsWithPng);
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

//Metodo para salvar
  void _saveForm() {
    //Valida o Formulario
    var isValid = _form.currentState.validate();
    //So salva as informações caso todos os dados sejam validos
    if (!isValid) {
      return;
    }

    //Salva o formulario
    _form.currentState.save();
//Cria um produto novo recebendo os dados do usuario
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      title: _formData['title'],
      price: _formData['price'],
      description: _formData['description'],
      imageUrl: _formData['imageUrl'],
    );
    print(newProduct.id);
    print(newProduct.title);
    print(newProduct.price);
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: _form,
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
                  onSaved: (value) => _formData['title'] = value,
                  validator: (value) {
                    //Se o valor digitado pelo usuario for vazio ou espaços em branco,isso e retornado
                    if (value.trim().isEmpty) {
                      return 'Informe um titulo válido!';
                    }
                    //Se o valor digitado pelo usuario for menor que 3 ou espaços em branco,isso e retornado
                    if (value.trim().length < 3) {
                      return 'Informe um titulo com no mínimo 3 letras!';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Preço'),
                  textInputAction: TextInputAction.next,

                  //Utiliza da variavel de foco pra quando o usuario clicar em next o campo ser focado
                  focusNode: _priceFocusNode,

                  //Faz o teclado so mostrar numeros,que no caso e o campo de preço
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onSaved: (value) => _formData['price'] = double.parse(value),
                  validator: (value) {
                    bool isEmpty = value.trim().isEmpty;
                    var newPrice = double.tryParse(value);
                    bool isInvalid = newPrice == null || newPrice <= 0;

                    if (isEmpty || isInvalid) {
                      return 'Informe um Preço Valido!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Descrição'),
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) => _formData['description'] = value,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Informe uma descrição válido!';
                    }

                    if (value.trim().length < 4) {
                      return 'Informe um descrição com no mínimo 4 letras!';
                    }

                    return null;
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
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        textInputAction: TextInputAction.done,
                        onSaved: (value) => _formData['imageUrl'] = value,
                        validator: (value) {
                          bool urlVazia = value.trim().isEmpty;
                          bool urlInvalida = !isValidImageUrl(value);
                          if (urlVazia || urlInvalida) {
                            return 'Informe uma url valida!';
                          }
                          return null;
                        },
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
