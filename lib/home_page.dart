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
  final _controller = TextEditingController();

  void Excluir(int index) {
    setState(() {
      lista.removeAt(index);
    });
  }

  void onChanged(int index) {
    setState(() {
      lista[index][1] = !lista[index][1];
    });
  }

  void CriarTarefa() {
    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 250),
            child: AlertDialog(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: Colors.grey,
              content: SizedBox(
                height: 135,
                child: SingleChildScrollView(
                  child: Column(children: [
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nome da tarefa',
                      ),
                    ),
                  
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
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
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: CriarTarefa,
            backgroundColor: Colors.black,
            child: Icon(
              Icons.add, 
              color: Colors.white
            )
          ),
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
            return criarLinha(Excluir, index, lista[index][0], lista[index][1], () {
              onChanged(index);
            });
          },
        ),
      ),
    );
  }
}

Widget criarLinha(Function excluir, int index, String nome, bool status, VoidCallback onchanged) {
  return Column(children: [
    Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        height: 75,
        width: 500,
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: status,
                onChanged: (value) => onchanged(),
                activeColor: Colors.black,
              ),

              SizedBox(
                width: 340,
                child: SingleChildScrollView(
                  child: Text(
                    nome,
                    style: TextStyle(
                      color: Colors.white,
                      decoration: status ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Visibility(
                  visible: status ? true : false,
                  child: ElevatedButton(
                    onPressed: () => excluir(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
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
      ),
    )
  ]);
}
