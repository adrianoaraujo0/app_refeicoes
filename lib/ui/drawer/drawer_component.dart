import 'package:app_refeicoes/ui/categories/categories_page.dart';
import 'package:app_refeicoes/ui/home_page.dart';
import 'package:app_refeicoes/ui/settings/settings_page.dart';
import 'package:flutter/material.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150, 
              width: double.infinity,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  const HomePage())),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.fastfood, size: 30),
                    SizedBox(width: 10),
                    Text("Refeicões", style: TextStyle(fontSize: 30),)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  const SettingsPage())),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.settings, size: 30),
                    SizedBox(width: 10),
                    Text("Configuracões", style: TextStyle(fontSize: 30),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}