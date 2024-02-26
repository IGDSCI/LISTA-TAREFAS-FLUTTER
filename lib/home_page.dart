// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';

class HomePageStl extends StatelessWidget {
  const HomePageStl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageStf(),
    );
  }
}

class HomePageStf extends StatefulWidget {
  const HomePageStf({Key? key}) : super(key: key);

  @override
  State<HomePageStf> createState() => _HomePageStfState();
}

class _HomePageStfState extends State<HomePageStf> {
  List lista = [];

  void Excluir(int index) {
    setState(() {
      lista.removeAt(index);
    });
  }

  final _controller = TextEditingController();

  void CriarTarefa() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          content: SizedBox(
            height: 120,
            child: Column(children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nome da tarefa',
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    lista.add([_controller.text, false]);
                    _controller.clear();
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'Criar tarefa',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ]),
          ),
        );
      },
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: CriarTarefa),
        backgroundColor: const Color.fromARGB(255, 75, 74, 74),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'Lista de tarefas',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, index) {
            return criarLinha(Excluir, index,lista[index][0], lista[index][1], () {
              onChanged(index);
            });
          },
        ),
      ),
    );
  }

  void onChanged(int index) {
    setState(() {
      lista[index][1] = !lista[index][1];
    });
  }
}





Widget criarLinha(Function excluir, int index, String nome, bool status, VoidCallback onchanged) {
  return Column(children: [
    Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        height: 75,
        width: 400,
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey,
        ),
        child: Row(
          children: [
            Checkbox(
              value: status,
              onChanged: (value) => onchanged(),
              activeColor: Colors.black,
            ),
            Text(
              nome,
              style: TextStyle(
                color: Colors.white,
                decoration: status ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
            Expanded( 
              child: SizedBox(),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                visible: status ? true : false,
                child: ElevatedButton(
                  onPressed: () => excluir(index), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: status ? Colors.red : Colors.red,
                    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'Excluir',
                    style: TextStyle(color: Colors.white),
                    ),
                ),
              ),
            )
          ],
        ),
      ),
    )
  ]);
}



