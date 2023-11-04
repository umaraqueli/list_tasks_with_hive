import 'package:banco/models/tarefa_model.dart';
import 'package:banco/repository/tarefa_repository.dart';
import 'package:flutter/material.dart';

class EdicaoDeTarefa extends StatefulWidget {
  final Tarefa tarefa;
  final int index;

  EdicaoDeTarefa({required this.tarefa, required this.index});

  @override
  _EdicaoDeTarefaState createState() => _EdicaoDeTarefaState();
}

class _EdicaoDeTarefaState extends State<EdicaoDeTarefa> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();

  @override
  void initState() {
    tituloController.text = widget.tarefa.titulo!;
    descricaoController.text = widget.tarefa.descricao!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TarefaBox tarefaBox = TarefaBox();

    return Scaffold(
        appBar: AppBar(
          title: Text('Editar Tarefa'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: tituloController,
                decoration: InputDecoration(labelText: 'Título da Tarefa'),
              ),
              TextField(
                controller: descricaoController,
                decoration: InputDecoration(labelText: 'Descrição da Tarefa'),
              ),
              ElevatedButton(
                onPressed: () {
                  final atualizaTarefa = Tarefa(
                    tituloController.text,
                    descricaoController.text,
                  );
                  tarefaBox.editTarefa(widget.index, atualizaTarefa);
                  Navigator.of(context).pop(atualizaTarefa);
                },
                child: Text('Salvar Alterações'),
              ),
            ],
          ),
        ));
  }
}
