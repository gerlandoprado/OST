import 'package:flutter/material.dart';
import 'dart:math';

class TelaFrequencia extends StatelessWidget {
  const TelaFrequencia({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de exemplo de registros de frequência
    final List<Frequencia> registros = [
      Frequencia(data: '14/12/2023', status: 'Presente'),
      Frequencia(data: '13/12/2023', status: 'Ausente'),
      Frequencia(data: '12/12/2023', status: 'Presente'),
      Frequencia(data: '11/12/2023', status: 'Presente'),
      Frequencia(data: '10/12/2023', status: 'Ausente'),
      Frequencia(data: '09/12/2023', status: 'Presente'),
      Frequencia(data: '08/12/2023', status: 'Presente'),
      Frequencia(data: '07/12/2023', status: 'Presente'),
      Frequencia(data: '06/12/2023', status: 'Presente'),
      // Adicione mais registros conforme necessário
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequência'),
      ),
      body: ListView.builder(
        itemCount: registros.length,
        itemBuilder: (context, index) {
          final registro = registros[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(registro.data),
              subtitle: Text(registro.status),
              trailing: registro.status == 'Presente'
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.remove_circle, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}

class Frequencia {
  String data;
  String status;

  Frequencia({required this.data, required this.status});
}
