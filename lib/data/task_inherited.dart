// import 'package:alura/components/task.dart';
// import 'package:flutter/material.dart';
//
// class TaskInherited extends InheritedWidget {
//   TaskInherited({
//     super.key,
//     required super.child,
//   });
//
//   final List<Task> taskList = [
//     Task(
//         'Estudar Flutter',
//         'https://cdn-images-1.medium.com/v2/resize:fit:1024/0*vowtRZE_wvyVA7CB',
//         3),
//     Task(
//         'Andar de Bike',
//         'https://jasminealimentos.com/wp-content/uploads/2022/06/Blog1_IMG_1-1-860x485.png',
//         2),
//     Task(
//         'Ler',
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu57TGsfJSBXb-Q1xmiOq_347IkjF_JpqgXw&s',
//         4),
//     Task(
//         'Meditar',
//         'https://magscan.com.br/wp-content/uploads/2020/04/original-2ce8ad3de83875daa42bae2bc572c235.jpeg',
//         5),
//     Task(
//         'Jogar',
//         'https://s2-techtudo.glbimg.com/7Mrs12ncF1vH9hMmUUQErjlbHcs=/0x0:695x463/984x0/smart/filters:strip_icc()/s.glbimg.com/po/tt2/f/original/2016/12/15/331.jpg',
//         1)
//   ];
//
//   void newTask(String name, String photo, int difficulty) {
//     taskList.add(Task(
//       name,
//       photo,
//       difficulty,
//       onDelete: () {},
//     ));
//   }
//
//   static TaskInherited of(BuildContext context) {
//     final TaskInherited? result =
//         context.dependOnInheritedWidgetOfExactType<TaskInherited>();
//     assert(result != null, 'No TaskInherited found in context');
//     return result!;
//   }
//
//   @override
//   // responsavel por monitorar o estado do widget, sempre comparando ao estado anterior
//   bool updateShouldNotify(TaskInherited oldWidget) {
//     return oldWidget.taskList.length != taskList.length;
//     // no estado anterior o tamanho da lista de tasks é diferente do tamanho atual ?
//   }
// }
