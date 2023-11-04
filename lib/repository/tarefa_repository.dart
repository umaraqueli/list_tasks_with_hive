import 'package:banco/models/tarefa_model.dart';
import 'package:hive/hive.dart';

class TarefaBox {
  String nomeDaBox = 'tarefa';

  //Recebendo uma tarefa por parametro
  addTarefa(Tarefa tarefa) async {
    //Aqui estamos 'pegando' a nossa box
    final box = await Hive.box<Tarefa>(nomeDaBox);
    //Salvando a tarefa que veio por parametro na box
    box.add(tarefa);
  }

  deleteTarefa(int index) async {
    final box = await Hive.box<Tarefa>(nomeDaBox);
    await box.deleteAt(index);
  }

  //retorna uma lista de tarefas
  List<Tarefa> getTarefas() {
    final box = Hive.box<Tarefa>(nomeDaBox);
    //Pega todas as tarefas e insere numa lista
    return box.values.toList();
  }

  editTarefa(int index, Tarefa novaTarefa) async {
    final box = await Hive.box<Tarefa>(nomeDaBox);
    await box.putAt(index, novaTarefa);
  }
}
