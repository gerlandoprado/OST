// menu_drawer.dart
import 'package:flutter/material.dart';
import 'resp-ocorrencia.dart';
import 'resp-notas.dart';
import 'resp-inicio.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

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
                '/Users/gerlandoprado/Documents/Software/OST/imagens/menu.jpg',
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('INICIO'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
              ListTile(
              leading: Icon(Icons.note),
              title: Text('NOTAS'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotasScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_view_day),
              title: Text('FREQUENCIA'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.error),
              title: Text('OCORRENCIA'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OcorrenciaScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('PROFESSORES'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('ATIVIDADES'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('PROVAS'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.sentiment_dissatisfied),
              title: Text('DIFICULDADES'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('CALENDARIOS'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
    );
  }
}