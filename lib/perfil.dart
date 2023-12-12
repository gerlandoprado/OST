// user_profile_button.dart
import 'package:flutter/material.dart';

class UserProfileButton extends StatelessWidget {
  const UserProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {
                      // Implement logout functionality
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: const CircleAvatar(
        // Replace with your image
        backgroundImage: NetworkImage('https://via.placeholder.com/100'),
      ),
    );
  }
}


