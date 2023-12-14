import 'package:flutter/material.dart';
import 'dart:math';
import 'menu.dart';
import 'perfil.dart';

class NotasScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  NotasScreen({super.key});

  // Função para gerar uma nota aleatória e retornar um widget DataCell
  DataCell generateNota() {
    final random = Random();
    final nota = random.nextDouble() * (10 - 5) + 4;
    return DataCell(
      Text(
        nota.toStringAsFixed(1),
        style: TextStyle(color: nota < 6 ? Colors.red : Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Notas'),
        actions: const <Widget>[
          UserProfileButton(),
          SizedBox(width: 10),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: const MenuDrawer(),

      //Corpo da tela
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
          dataRowColor: MaterialStateProperty.all(Colors.white),
          border: TableBorder.all(color: Colors.grey),
          columns: const <DataColumn>[
            DataColumn(label: Text('Matéria')),
            DataColumn(label: Text('Parcial 1')),
            DataColumn(label: Text('Bimestral 1')),
            DataColumn(label: Text('Parcial 2')),
            DataColumn(label: Text('Bimestral 2')),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                const DataCell(Text('Matemática')),
                generateNota(),
                generateNota(),
                generateNota(),
                generateNota(),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                const DataCell(Text('Português')),
                generateNota(),
                generateNota(),
                generateNota(),
                generateNota(),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                const DataCell(Text('Geografia')),
                generateNota(),
                generateNota(),
                generateNota(),
                generateNota(),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                const DataCell(Text('História')),
                generateNota(),
                generateNota(),
                generateNota(),
                generateNota(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
