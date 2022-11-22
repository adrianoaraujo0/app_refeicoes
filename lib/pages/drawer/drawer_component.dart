import 'package:app_refeicoes/pages/home_page.dart';
import 'package:app_refeicoes/pages/registration/registration_controller.dart';
import 'package:flutter/material.dart';

class DrawerComponent extends StatefulWidget {
  DrawerComponent({super.key});

  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  
  RegistrationController registrationController = RegistrationController();

  @override
  void initState() {
    registrationController.initBd();
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
              registrationController.insertMealDatabase();
              // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage(id: 1,)));
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