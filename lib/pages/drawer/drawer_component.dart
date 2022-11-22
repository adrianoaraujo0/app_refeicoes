import 'package:app_refeicoes/pages/home_page.dart';
import 'package:app_refeicoes/pages/registration/registration_page.dart';
import 'package:app_refeicoes/pages/registration/registration_repository.dart';
import 'package:flutter/material.dart';

class DrawerComponent extends StatelessWidget {
  DrawerComponent({super.key});

  RegistrationRepository registrationRepository = RegistrationRepository();

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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.fastfood),
                  SizedBox(width: 10),
                  Text("Refeicões" , style: TextStyle(fontSize: 25))
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () {
              registrationRepository.insertMeal();
              // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.add_circle_outline_outlined),
                  SizedBox(width: 10),
                  Text("Cadastre sua receita" , style: TextStyle(fontSize: 25))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}