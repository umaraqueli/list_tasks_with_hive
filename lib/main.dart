import 'package:banco/models/tarefa_model.dart';
import 'package:banco/pages/editar_tarefa.dart';
import 'package:banco/repository/tarefa_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  //AQUI ESTAMOS CHAMADO O ARQUIVO CRIADO AUTOMATICAMENTE PELO HIVE
  Hive.registerAdapter(TarefaAdapter());
  //AQUI ESTAMOS ABRINDO A BOX DE TAREFA PARA PODEMOS GRAVAR/EDITAR
  await Hive.openBox<Tarefa>('tarefa');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      home: const MinhasTarefas(),
    );
  }
}

class MinhasTarefas extends StatefulWidget {
  const MinhasTarefas({super.key});

  @override
  State<MinhasTarefas> createState() => _MinhasTarefasState();
}

class _MinhasTarefasState extends State<MinhasTarefas> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  final TarefaBox tarefaBox = TarefaBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: tituloController,
              decoration: InputDecoration(
                labelText: 'Título da Tarefa',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição da Tarefa',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final novaTarefa =
                  Tarefa(tituloController.text, descricaoController.text);
              tarefaBox.addTarefa(novaTarefa);
              setState(() {
                tituloController.clear();
                descricaoController.clear();
              });
            },
            child: Text('Adicionar Tarefa'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tarefaBox.getTarefas().length,
              itemBuilder: (context, index) {
                final tarefa = tarefaBox.getTarefas()[index];
                return ListTile(
                    title: Text(tarefa.titulo ?? ''),
                    subtitle: Text(tarefa.descricao ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            tarefaBox.deleteTarefa(index);
                            setState(() {});
                          },
                        ),
                        IconButton(
                            onPressed: () async {
                              final result = await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) => EdicaoDeTarefa(
                                  tarefa: tarefa,
                                  index: index,
                                ),
                              ));

                              if (result != null) {
                                // Verifica se a tarefa foi atualizada
                                tarefaBox.editTarefa(index, result);
                                setState(() {});
                              }
                            },
                            icon: Icon(Icons.edit_outlined))
                      ],
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
