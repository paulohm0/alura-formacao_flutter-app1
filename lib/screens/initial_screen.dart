import 'package:alura/components/task.dart';
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
        ),
        body: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: opacidade ? 0 : 1,
          child: ListView(
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Tasks(
                    'Estudar Flutter',
                    'https://cdn-images-1.medium.com/v2/resize:fit:1024/0*vowtRZE_wvyVA7CB',
                    3),
              ),
              Tasks(
                  'Andar de Bike',
                  'https://jasminealimentos.com/wp-content/uploads/2022/06/Blog1_IMG_1-1-860x485.png',
                  2),
              Tasks(
                  'Ler',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu57TGsfJSBXb-Q1xmiOq_347IkjF_JpqgXw&s',
                  4),
              Tasks(
                  'Meditar',
                  'https://magscan.com.br/wp-content/uploads/2020/04/original-2ce8ad3de83875daa42bae2bc572c235.jpeg',
                  5),
              Tasks(
                  'Jogar',
                  'https://s2-techtudo.glbimg.com/7Mrs12ncF1vH9hMmUUQErjlbHcs=/0x0:695x463/984x0/smart/filters:strip_icc()/s.glbimg.com/po/tt2/f/original/2016/12/15/331.jpg',
                  1)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              opacidade = !opacidade;
            });
          },
          child: const Icon(Icons.remove_red_eye),
        ));
  }
}
