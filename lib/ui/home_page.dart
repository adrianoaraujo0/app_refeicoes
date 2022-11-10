import 'package:app_refeicoes/ui/drawer/drawer_component.dart';
import 'package:flutter/material.dart';

import 'categories/categories_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerComponent(),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Categorias"),
        centerTitle: true,
      ),
      body: const CategoriesPage(),
    );
  }
}