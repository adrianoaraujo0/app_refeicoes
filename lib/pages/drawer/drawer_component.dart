import 'dart:developer';

import 'package:app_refeicoes/pages/home_page.dart';
import 'package:app_refeicoes/pages/list_my_meals/list_my_meals_page.dart';
import 'package:app_refeicoes/pages/registration/registration_controller.dart';
import 'package:flutter/material.dart';

import '../registration/registration_page.dart';

class DrawerComponent extends StatefulWidget {
  DrawerComponent({super.key});

  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  
  RegistrationController registrationController = RegistrationController();

  @override
  void initState() {
    super.initState();
  }

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
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  const HomePage())),
            child: buildContainer(Icons.fastfood, "Refeicoes")
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage())
              );
            },
            child: buildContainer(Icons.add_circle_outline_outlined, "Cadastre sua receita")
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  ListMyMealsPage())),
            child: buildContainer(Icons.create, "Minhas refeicoes")
          )
        ],
      ),
    );
  }

  Widget buildContainer(IconData icon, String name){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Icon(icon),
          const SizedBox(width: 10),
          Text( name , style: const TextStyle(fontSize: 25))
        ],
      ),
    );
  }
}