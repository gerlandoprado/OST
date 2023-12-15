import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AtribuirResponsaveisScreen extends StatefulWidget {
  const AtribuirResponsaveisScreen({Key? key});

  @override
  _AtribuirResponsaveisScreenState createState() =>
      _AtribuirResponsaveisScreenState();
}

class _AtribuirResponsaveisScreenState
    extends State<AtribuirResponsaveisScreen> {
  // Lista de responsáveis para exibição
  final List<Responsavel> responsaveis = [
    Responsavel(nome: 'Gerlando Lima Prado', cpf: '072.275.789-10'),
    Responsavel(nome: 'Everton de Almeida Veras', cpf: '525.789.115-82'),
  ];

  // Função que simula a atribuição e retorna true ou false
  Future<bool> atribuirResponsavel(String matricula) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atribuir'),
      ),
      body: ListView.builder(
        itemCount: responsaveis.length,
        itemBuilder: (context, index) {
          final responsavel = responsaveis[index];
          final matriculaController =
              TextEditingController();
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    responsavel.nome,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    responsavel.cpf,
                    style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller:
                              matriculaController,
                          decoration: InputDecoration(
                            labelText: 'Insira o número de matrícula do aluno',
                            labelStyle: const TextStyle(color: Colors.black),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          // Chama a função de atribuição e processa o resultado
                          final resultado = await atribuirResponsavel(
                              matriculaController
                                  .text); // Use o valor do TextEditingController separado
                          if (resultado) {
                            // Se a atribuição for bem-sucedida, remove o card
                            setState(() {
                              responsaveis.removeAt(index);

                              if (responsaveis.isEmpty) {
                                // Se não houver mais responsáveis, exibe a mensagem
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    final dialogContext = context;
                                    return AlertDialog(
                                      title: const Text('Aviso'),
                                      content: const Text(
                                          'Não há contas pendentes.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                dialogContext); // Fecha o diálogo
                                            Navigator.pop(
                                                dialogContext); // Volta para a tela anterior
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            });
                          } else {
                            // Se a atribuição falhar, mostra um SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Falha ao atribuir responsável.'),
                              ),
                            );
                          }
                        },
                        child: const Text('Atribuir'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Responsavel {
  String nome;
  String cpf;

  Responsavel({required this.nome, required this.cpf});
}
