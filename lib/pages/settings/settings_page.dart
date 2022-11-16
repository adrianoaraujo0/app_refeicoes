import 'package:app_refeicoes/pages/drawer/drawer_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red, title: const Text("Classifique seus alimentos"),),
      drawer: DrawerComponent(),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            buildSwitch("Sem gluten", false, (p0) => null),
            const SizedBox(height: 10),
            buildSwitch("Sem Lactose", false, (p0) => null),
            const SizedBox(height: 10),
            buildSwitch("Vegano", false, (p0) => null),
            const SizedBox(height: 10),
            buildSwitch("Vegetariano", false, (p0) => null),
          ]
        ),
      ),
    );
  }

  Widget buildSwitch(String text, bool value, Function(bool)? onChanged){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: const TextStyle(fontSize: 25),),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch(value: value, onChanged: onChanged,),
          ],
        )
      ],
    );
  }
}