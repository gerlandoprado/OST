import 'package:flutter/material.dart';
import 'package:ost/services/authentication_service.dart';
import 'main.dart';

class UserProfileButton extends StatelessWidget {
  const UserProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationService auth = AuthenticationService();
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    child: const Text('Voltar'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: const Text('Sair dessa sessão'),
                    onPressed: () async {
                      //aqui
                      await auth.userLogout();
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/perfil.png'),
      ),
    );
  }
}
