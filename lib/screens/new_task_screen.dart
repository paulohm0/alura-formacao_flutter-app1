import 'dart:io';

import 'package:alura/components/task_model.dart';
import 'package:alura/data/database.dart';
import 'package:flutter/material.dart';

class NewTaskWidget extends StatefulWidget {
  const NewTaskWidget({
    super.key,
    required this.taskContext,
    this.task,
  });

  final BuildContext taskContext;
  final TaskModel? task;

  @override
  State<NewTaskWidget> createState() => _NewTaskWidgetState();
}

class _NewTaskWidgetState extends State<NewTaskWidget> {
  late TextEditingController nameController;
  late TextEditingController imageController;

  final _formKey = GlobalKey<FormState>();
  late Future<bool> imageExists;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.task?.nome ?? '');
    imageController = TextEditingController(text: widget.task?.imagem ?? '');
    imageExists = checkImage(imageController.text);
  }

  bool valueValidator(String? value) {
    return value != null && value.isNotEmpty;
  }

  Future<bool> checkImage(String url) async {
    try {
      final request = await HttpClient().headUrl(
          Uri.parse(url)); // Faz uma solicitação HTTP HEAD para a URL fornecida
      final response = await request.close(); // Aguarda resposta do servidor
      return response.statusCode ==
          200; // Verifica se o status da requisição HTTP é 200, indicando que a imagem é válida
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.task == null ? 'Nova Tarefa' : 'Editar Tarefa'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (valueValidator(value)) {
                          return null;
                        }
                        return 'Digite o nome da tarefa!';
                      },
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nome',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() {
                          imageExists = checkImage(
                              text); // Revalida a imagem ao alterar o texto
                        });
                      },
                      validator: (String? value) {
                        if (valueValidator(value)) {
                          return null;
                        }
                        return 'Insira a URL de uma imagem!';
                      },
                      keyboardType: TextInputType.url,
                      controller: imageController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Imagem',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(),
                      ),
                      width: 144,
                      height: 200,
                      child: FutureBuilder<bool>(
                        future: imageExists,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError ||
                              !snapshot.hasData ||
                              !snapshot.data!) {
                            return Image.asset(
                              'assets/nophoto.jpg',
                              fit: BoxFit.cover,
                            );
                          } else {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: Image.network(
                                imageController.text,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.task == null
                            ? DatabaseSQFlite.instance.insertTask(TaskModel(
                                null,
                                nameController.text,
                                imageController.text,
                              ))
                            : DatabaseSQFlite.instance.updateTask(TaskModel(
                                widget.task?.id,
                                nameController.text,
                                imageController.text,
                              ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(widget.task == null
                                ? 'Salvando nova tarefa'
                                : 'Atualizando tarefa'),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child:
                        Text(widget.task == null ? 'Adicionar' : 'Atualizar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
