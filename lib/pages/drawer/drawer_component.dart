import 'package:app_refeicoes/pages/home_page.dart';
import 'package:app_refeicoes/pages/registration/registration_page.dart';
import 'package:app_refeicoes/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150, 
            width: double.infinity,
            color: Colors.red,
          ),
          const SizedBox(height: 20),
          buildInkWell(
            context,
            MaterialPageRoute(builder: (context) =>  const HomePage()),
            Icons.fastfood,
            "Refeicões"
          ),
          const SizedBox(height: 30),
          buildInkWell(
            context,
            MaterialPageRoute(builder: (context) =>  const SettingsPage()),
            Icons.settings,
            "Configuracões"
          ),
          const SizedBox(height: 30),
          buildInkWell(
            context,
            MaterialPageRoute(builder: (context) => const RegistrationPage()),
            Icons.add_circle_outline_outlined,
            "Cadastre sua receita"
          )
        ],
      ),
    );
  }

  Widget buildInkWell(BuildContext context, MaterialPageRoute route , IconData? icon, String text){
    return  InkWell(
      onTap: () => Navigator.push(context, route),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(text , style: const TextStyle(fontSize: 25))
          ],
        ),
      ),
    );
  }
}