import 'dart:async';
import 'dart:developer';

import 'package:app_refeicoes/ui/registration/registration_controller.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  RegistrationController registrationController = RegistrationController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addImage(),
            const SizedBox(height: 10),
            buildForm(),
            const SizedBox(height: 40),
            ElevatedButton(onPressed: () => buildAlertDialog(context) , child: Text("APERTAR")),
           
            buildListViewAndTextField(
              text: "Insira o próximo passo",
              hintText: "Ex: Mexa 2 ovos",
              controller: registrationController.controllerListSteps,
              textController: registrationController.textControllerSteps,
              function: registrationController.updateListSteps
            )
          ]
        ),
      ),
    );
  }

  Widget addImage(){
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.add, size: 60),
          Text("Adicione uma imagem", style: TextStyle(fontSize: 27),)
        ]
      ),
    );
  }

  Widget buildForm(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const TextField(
              decoration: InputDecoration(hintText: "Nome da receita"),
            ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            buildDropDownButton("Custo",["Barato","Razoável","Caro"]),
            const SizedBox(width: 20),
            buildDropDownButton("Dificuldade",["Fácil","Médio","Difícil"]),
            ],
          ),
          const SizedBox(
            width: 60,
            child: TextField(
              decoration: InputDecoration(hintText: "Tempo"),
            )
          ),
        ],
      ),
    );
  }

  Widget buildDropDownButton( String title, List<String> values){
    return DropdownButton(
      hint: Text(title),
      items: values.map((e){
        return DropdownMenuItem(
          value: e, 
          child: Text(e),
        );
      }).toList(),
      onChanged: ((value) {
        print(value);
      })
    );
  }

  Widget buildListViewAndTextField({
    required String text,
    required String hintText,
    required Function function,
    required TextEditingController textController,
    required StreamController<List<String>> controller
  }){
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: const OutlineInputBorder()
                  ),
                  onSubmitted: (_)=> function(),
                ),
              ),
              IconButton(
                onPressed: () => function(),
                icon: const Icon(Icons.add))
            ],
          ),
          buildStreamBuilder(controller: controller)
        ],
      ),
    );
  }

  Widget buildStreamBuilder({required StreamController<List<String>> controller}){
    return StreamBuilder<List<String>>(
      stream: controller.stream,
      builder: (context, snapshot) {
        if(snapshot.data != null && snapshot.data!.isNotEmpty){
            return buildListView(snapshot.data!);
        }
        return Container();
      }
    );
  }

  Widget buildListView(List<String> list){
    return Container(
      height: 50,
      width: 100,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(list[index]));
        }, 
      ),
    );
  }

  Future<void> buildAlertDialog(BuildContext context){
    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: buildListViewAndTextField(
            text: "Insira os ingredientes",
            hintText: "Ex: 4 Tomates",
            controller: registrationController.controllerListIngredients,
            textController: registrationController.textControllerIngredients,
            function: registrationController.updateListIngredients,
          ),
        );
      },
    );

  }
}