import 'dart:async';
import 'dart:developer';

import 'package:app_refeicoes/pages/registration/registration_controller.dart';
import 'package:flutter/material.dart';

import 'registration_repository.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  RegistrationController registrationController = RegistrationController();

  @override
  void initState() {
    registrationController.initMealPage();
    super.initState();
  }


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
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () => buildAlertDialog(
                      context, 
                      "Insira os ingredientes", 
                      "Ex: 4 Tomates", 
                      registrationController.controllerListIngredients,
                      registrationController.textControllerIngredients,
                      registrationController.updateListIngredients
                    ), 
                    child: const Text("ingredientes")
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => buildAlertDialog(
                      context, 
                      "Insira os passos", 
                      "Ex: Ferver água", 
                      registrationController.controllerListSteps,
                      registrationController.textControllerSteps,
                      registrationController.updateListSteps
                    ), 
                    child: const Text("Passos")
                  ),
                ),
              ],
            ),
          ],
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
            const SizedBox(width: 5),
            buildDropDownButton("Dificuldade",["Fácil","Médio","Difícil"]),
            const SizedBox(width: 5),
            buildDropDownButton("Categorias",["Italiano" , "Médio" , "Rápido & Fácil", "Hamburgers", "Alemã", "Leve & Saudável", "Exótica", "Café da Manhã","Asiática","Francesa", "Verão"]),
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
    return SizedBox(
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

  Future<void> buildAlertDialog(BuildContext context, String text, String hintText, StreamController<List<String>> controller, TextEditingController textEditingController, Function function){
    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(onPressed: (){}, child: const Text("Salvar"))
          ],
          content: buildListViewAndTextField(
            text: text,
            hintText: hintText,
            controller: controller,
            textController: textEditingController,
            function: function,
          ),
        );
      },
    );
  }
}