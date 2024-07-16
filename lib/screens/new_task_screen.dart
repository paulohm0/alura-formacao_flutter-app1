import 'package:alura/components/task.dart';
import 'package:alura/data/task_dao.dart';
import 'package:flutter/material.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key, required this.taskContext, this.task});

  final BuildContext taskContext;
  final Task? task;

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  late TextEditingController nameController;
  late TextEditingController imageController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.task?.nome ?? '');
    imageController = TextEditingController(text: widget.task?.imagem ?? '');
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
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        TaskDao().save(Task(
                          nameController.text,
                          imageController.text,
                          onDelete: () {},
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
