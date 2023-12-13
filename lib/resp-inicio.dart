import 'package:flutter/material.dart';
import 'resp-ocorrencia.dart';
import 'resp-notas.dart';
import 'menu.dart';
import 'perfil.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('OST → Inicio'),
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
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _buildGridButton(
            icon: Icons.note,
            label: 'NOTAS',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotasScreen()),
              );
            },
          ),
          _buildGridButton(
            icon: Icons.calendar_view_day,
            label: 'FREQUÊNCIA',
            onTap: () {
              // Implement navigation or functionality for FREQUÊNCIA
            },
          ),
          _buildGridButton(
            icon: Icons.error,
            label: 'OCORRÊNCIAS',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OcorrenciaScreen()),
              );
            },
          ),
          _buildGridButton(
            icon: Icons.people,
            label: 'PROFESSORES',
            onTap: () {
              // Implement navigation or functionality for PROFESSORES
            },
          ),
          // ... (add more buttons as needed)
        ],
      ),
    );
  }

  Widget _buildGridButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.green),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
