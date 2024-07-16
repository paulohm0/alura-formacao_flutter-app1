import 'package:alura/components/task.dart';
import 'package:alura/data/database.dart';
import 'package:sqflite/sqflite.dart';

// Data Access Object => funciona como um Model
// responsavel por qualquer comunicacao com o db

class TaskDao {
  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _image = 'image';

  static const String tableSql =
      'CREATE TABLE $_tablename ($_name TEXT,$_image TEXT)';

  /// responsavel por salvar ou editar uma task no db
  Future<int> save(Task tarefa) async {
    final Database bancoDeDados =
        await getDatabase(); // entra no banco de dados
    var itemExists = await find(tarefa.nome); // verifica se a tarefa ja existe
    Map<String, dynamic> taskMap =
        toMap(tarefa); // responsavel por transformar a tarefa em um map
    if (itemExists.isEmpty) {
      print('inserindo uma nova tarefa: ${tarefa.nome}');
      // se a tarefa nao existia sera inserida uma nova task no db
      return await bancoDeDados.insert(
        _tablename,
        taskMap,
      );
    } else {
      print('atualizando a tarefa: ${tarefa.nome}');
      // se a tarefa ja existir sera feito um update na task
      return await bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [tarefa.nome],
      );
    }
  }

  /// responsavel por transformar uma task em um Map para poder ser inserido no db
  Map<String, dynamic> toMap(Task tarefa) {
    final Map<String, dynamic> mapaDeTarefas = {};
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_image] = tarefa.imagem;
    return mapaDeTarefas;
  }

  /// responsavel por deletar uma task no db
  Future<int> delete(String nomeDaTarefa) async {
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
  }

  /// responsavel por buscar uma task especifica no db
  Future<List<Task>> find(String nomeDaTarefa) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
    return toList(result);
  }

  /// responsavel por buscar todas as tasks existentes no db e transformar em uma lista de tasks na tela
  Future<List<Task>> findAll() async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    return toList(result);
  }

  /// responsavel por transformar o Map do db em uma lista de tasks
  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(
        linha[_name],
        linha[_image],
        onDelete: () {},
      );
      tarefas.add(tarefa);
    }
    return tarefas;
  }
}
