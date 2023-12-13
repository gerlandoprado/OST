// menu_drawer.dart
import 'package:flutter/material.dart';
import 'resp-ocorrencia.dart';
import 'resp-notas.dart';
import 'resp-inicio.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Image.asset(
              'assets/menu.jpg',
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('INICIO'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.note),
            title: const Text('NOTAS'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotasScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_view_day),
            title: const Text('FREQUENCIA'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.error),
            title: const Text('OCORRENCIA'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OcorrenciaScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('PROFESSORES'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('ATIVIDADES'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('PROVAS'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.sentiment_dissatisfied),
            title: const Text('DIFICULDADES'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('CALENDARIOS'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
