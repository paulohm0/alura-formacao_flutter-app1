import 'package:flutter/material.dart';

import '../data/task_inherited.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key, required this.taskContext});

  final BuildContext taskContext;

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void formValidator() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      setState(() {});
    }
  }

  bool valueValidator(String? value) {
    return value != null && value.isNotEmpty;
  }

  bool difficultyValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (int.parse(value) > 0 && int.parse(value) < 6) {
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    nameController.dispose();
    difficultyController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova Tarefa'),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    validator: (String? value) {
                      if (difficultyValidator(value)) {
                        return null;
                      }
                      return 'Digite um numero entre 1 e 5!';
                    },
                    keyboardType: TextInputType.number,
                    controller: difficultyController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Dificuldade',
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (text) {
                      setState(() {});
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(),
                  ),
                  width: 144,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.network(
                      imageController.text,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stacktrace) {
                        return Image.asset(
                          'assets/nophoto.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      TaskInherited.of(widget.taskContext).newTask(
                          nameController.text,
                          imageController.text,
                          int.parse(difficultyController.text));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Salvando nova tarefa'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
