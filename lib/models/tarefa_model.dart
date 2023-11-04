import 'package:hive/hive.dart';
part 'tarefa_model.g.dart';

@HiveType(typeId: 0)
//Classe
class Tarefa {
  @HiveField(0)
  String? titulo;

  @HiveField(1)
  String? descricao;

//Construtor
  Tarefa(this.titulo, this.descricao);
}
