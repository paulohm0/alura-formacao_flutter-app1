import 'package:alura/data/task_dao.dart';
import 'package:alura/screens/new_task_screen.dart';
import 'package:flutter/material.dart';

import '../components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  void rebuildList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Lista de Tarefas',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
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
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 70),
            child: FutureBuilder<List<Task>>(
                future: TaskDao().findAll(),
                builder: (context, snapshot) {
                  List<Task>? items = snapshot.data;
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text('Carregando'),
                          ],
                        ),
                      );
                    case ConnectionState.waiting:
                      return Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text('Carregando'),
                          ],
                        ),
                      );
                    case ConnectionState.active:
                      return Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text('Carregando'),
                          ],
                        ),
                      );
                    case ConnectionState.done:
                      if (snapshot.hasData && items != null) {
                        if (items.isNotEmpty) {
                          return ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, int index) {
                                final Task tarefa = items[index];
                                return Task(tarefa.nome, tarefa.imagem,
                                    onDelete: rebuildList);
                              });
                        }
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                              ),
                              Text(
                                'Não há nenhuma tarefa',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      }
                      return Text('Erro ao carregar as tarefas');
                  }
                }),
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
            ).then(
              (value) => setState(() {}),
            );
          },
          child: const Icon(Icons.add),
        ));
  }
}
