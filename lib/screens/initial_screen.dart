import 'package:alura/data/task_inherited.dart';
import 'package:alura/screens/new_task_screen.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Tarefas'),
          leading: Container(),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    opacidade = !opacidade;
                  });
                },
                icon: const Icon(Icons.remove_red_eye),
              ),
            )
          ],
        ),
        body: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: opacidade ? 1 : 0,
          child: ListView(
            padding: const EdgeInsets.only(top: 8, bottom: 70),
            children: TaskInherited.of(context).taskList,
            // taskinherited tem esse metodo "of" que pede um contexto e retorna esse objeto
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contextNew) => NewTaskScreen(
                  taskContext: context,
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ));
  }
}
