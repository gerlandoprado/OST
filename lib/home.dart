import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OST',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Lista de itens do menu
  List<ItemMenu> itensMenu = [
    ItemMenu(
      label: 'Início',
      icon: Icon(Icons.home),
    ),
    ItemMenu(
      label: 'Notificações',
      icon: Icon(Icons.notifications),
    ),
    ItemMenu(
      label: 'Horário das aulas',
      icon: Icon(Icons.schedule),
    ),
    ItemMenu(
      label: 'Calendário escolar',
      icon: Icon(Icons.calendar_today),
    ),
    ItemMenu(
      label: 'Atividades',
      icon: Icon(Icons.assignment),
    ),
    ItemMenu(
      label: 'Provas e trabalhos',
      icon: Icon(Icons.assignment_turned_in),
    ),
    ItemMenu(
      label: 'Notas',
      icon: Icon(Icons.note),
    ),
    ItemMenu(
      label: 'Frequência',
      icon: Icon(Icons.people),
    ),
    ItemMenu(
      label: 'Desempenho',
      icon: Icon(Icons.assessment),
    ),
    ItemMenu(
      label: 'Dificuldades',
      icon: Icon(Icons.help_outline),
    ),
    ItemMenu(
      label: 'Metas',
      icon: Icon(Icons.check),
    ),
    ItemMenu(
      label: 'Fale conosco',
      icon: Icon(Icons.question_mark),
    ),
  ];

  // Controle do estado do menu
  bool menuAberto = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OST'),
        actions: [],
      ),
      body: Container(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: itensMenu.map((item) {
            return TextButton(
              onPressed: () {
                print(item.label);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  item.icon,
                  SizedBox(width: 8),
                  Text(item.label, style: TextStyle(color: Colors.black)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: itensMenu.map((item) {
            return ListTile(
              title: Text(item.label),
              leading: item.icon,
              onTap: () {
                // Fecha o menu
                setState(() {
                  menuAberto = false;
                });

                // Executa a ação do item do menu
                print(item.label);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Classe que representa um item do menu
class ItemMenu {
  // Label do item
  String label;

  // Ícone do item
  Icon icon;

  // Construtor
  ItemMenu({
    required this.label,
    required this.icon,
  });
}
