import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/registration/registration_controller.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({required this.id ,super.key});

  final int id;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  RegistrationController registrationController = RegistrationController();

String? category;

  @override
  void initState() {
    registrationController.initDb();
    registrationController.initMeal(widget.id);
    log("${widget.id}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red),
      body: StreamBuilder<Meal>(
        stream: registrationController.controllerMeal.stream,
        builder: (context, snapshot) {
          if(snapshot.data != null){
            print("id: ${snapshot.data!.id}");
            print("img: ${snapshot.data!.imgUrl}");
            print("name: ${snapshot.data!.name}");
            print("category: ${snapshot.data!.category}");
            print("time: ${snapshot.data!.duration}");
            print("complexity: ${snapshot.data!.complexity}");
            print("cost: ${snapshot.data!.cost}");
            print("isExpandedIngredient: ${snapshot.data!.ingredientIsExpanded}");
            print("isExpandedStep: ${snapshot.data!.stepIsExpanded}");
          return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addImage(meal: snapshot.data!),
                  const SizedBox(height: 10),
                  buildForm(snapshot.data),
                  const SizedBox(height: 40),
                 buildExpansioList("Insira os ingredientes", snapshot.data!, true),
                 buildExpansioList("Insira os passos", snapshot.data!),
                 Container(height: 100),
                ],
              ),
            );
          }
        return Container();
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text("Salvar"),
        onPressed: (){
          registrationController.insertMealDatabase(category: category);
        }
      ),
    );
  }

  Widget addImage({required Meal meal}){
    return InkWell(
      onTap: () {
        registrationController.takePhotoFromGallery(meal);
      },
      child: meal.imgUrl == null 
      ? Container(
        height: 200,
        width: double.infinity,
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add, size: 60),
            Text("Adicione uma imagem", style: TextStyle(fontSize: 27))
          ]
        ),
      )
      : SizedBox(
        height: 300,
        width: double.infinity,
        child: Image.file(File(meal.imgUrl!), fit: BoxFit.cover)
      )
    );
  }

  Widget buildForm(Meal? meal){
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira um valor";
                  }
                },
              controller: registrationController.textControllerNameMeal,
                decoration: const InputDecoration(hintText: "ex: Ovo mexido", labelText: "Nome da receita"),
              ),
            const SizedBox(height: 10),
            buildDropDownButton(
              items: ["Italiano" , "Rápido & Fácil", "Hamburgers", "Alemã", "Leve & Saudável", "Exótica", "Café da Manhã","Asiática","Francesa", "Verão"],
              meal: meal!
            ),
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: registrationController.textControllerTimeMeal,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(labelText: "Tempo", hintText: "ex: 12 min"),
              )
            ),
            buildRadioButton(meal),
          ],
        ),
      ),
    );
  }

  Widget buildRadioButton(Meal meal){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: const Text("Dificuldade", style: TextStyle(fontSize: 22)),
        ),
        Column(
        children: [
          buildRadioListTile("Fácil", meal),
          buildRadioListTile("Médio", meal),
          buildRadioListTile("Difícil", meal),
        ],
      ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0 , 10),
          child: const Text("Custo", style: TextStyle(fontSize: 22)),
        ),

        Column(
          children: [
            buildRadioListTile("Barato", meal, true),
            buildRadioListTile("Razoável", meal, true),
            buildRadioListTile("Caro", meal, true),
          ],
        ),
      ],
    );
  }

  Widget buildRadioListTile(String title, Meal meal, [bool changeToCost = false]){
    return RadioListTile(
      title: Text(title),
      value: title,
      groupValue: changeToCost ? meal.cost : meal.complexity,
      onChanged:  (value){ 
        if(changeToCost){
          registrationController.insertCost(meal, value!);
        }else{
          registrationController.insertComplexity(meal, value!);
        }
      }  
    );
  }

  Widget buildDropDownButton({required List<String> items, required Meal meal}){
    return DropdownButton(
      hint:Text(meal.category == null ? "Categorias" : meal.category!),
      items: items.map((name){return DropdownMenuItem(value: name, child: Text(name));}).toList(),
      onChanged: (newTitle) {
        registrationController.insertCategory(meal, newTitle!);
      }
    );
  }

  Widget buildListView(List<dynamic> list){
    return SizedBox(
      height: 200,
      width: 100,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(list[index].name));
        }, 
      ),
    );
  }

  Widget buildExpansioList(String title, Meal meal, [bool changeToStep = false]){
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        if(changeToStep){
          print(title);
          print(isExpanded);
          registrationController.changeExpansionListIngredient(meal, isExpanded);
        }else{
          registrationController.changeExpansionListStep(meal, isExpanded);
        }
      },
      children: [
        ExpansionPanel(
          isExpanded: changeToStep ? meal.ingredientIsExpanded : meal.stepIsExpanded,
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) {
            return Text(title);
          },
          body: const Text("TESTE")
        )
      ],
    );
  }

  Future<void> buildAlertDialog(BuildContext context , {required String text ,required String hintText,required StreamController<List<dynamic>> controller, required TextEditingController textEditingController, required Function functionUpdateList, required Function insertDatabase}){
    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: (){
                insertDatabase();
                Navigator.pop(context);
              }, child: const Text("Salvar")
            )
          ],
          content: buildListViewAndTextField(
            text: text,
            hintText: hintText,
            controller: controller,
            textController: textEditingController,
            functionUpdateList: functionUpdateList,
          ),
        );
      },
    );
  }

  Widget buildListViewAndTextField({required String text, required String hintText, required Function functionUpdateList, required TextEditingController textController, required StreamController<List<dynamic>> controller}){
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
                  onSubmitted: (_)=> functionUpdateList(),
                ),
              ),
              IconButton(
                onPressed: () => functionUpdateList(),
                icon: const Icon(Icons.add)
              )
            ],
          ),
          buildListView([])
        ],
      ),
    );
  }
}