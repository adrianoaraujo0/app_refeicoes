import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:app_refeicoes/models/ingredient_meal.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/registration/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            // print("id: ${snapshot.data!.id}");
            // print("img: ${snapshot.data!.imgUrl}");
            // print("name: ${snapshot.data!.name}");
            // print("category: ${snapshot.data!.category}");
            // print("time: ${snapshot.data!.duration}");
            // print("complexity: ${snapshot.data!.complexity}");
            // print("cost: ${snapshot.data!.cost}");
            // print("isExpandedIngredient: ${snapshot.data!.ingredientIsExpanded}");
            // print("isExpandedStep: ${snapshot.data!.stepIsExpanded}");
          return SingleChildScrollView(
              child: Form(
                key: registrationController.formKey,
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
              ),
            );
          }
        return Container();
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text("Salvar"),
        onPressed: (){

          registrationController.formVerification();
          // registrationController.insertMealDatabase(category: category);
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            TextFormField(
              validator: (value) {
                if(value!.isEmpty){
                  return "Insira um valor";
                }
                return null;
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
              validator: (value) {
               if(value!.isEmpty){
                return "Insira o tempo.";
               }
               else{
                try{   
                  int x = int.parse(value);
                }catch(e){
                  return "tempo inválido";
                }
               }
              },
              inputFormatters: [FilteringTextInputFormatter.deny (RegExp ("[0-9] +"))],
              controller: registrationController.textControllerTimeMeal,
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(labelText: "Tempo", hintText: "ex: 12 min"),
            )
          ),
          buildRadioButton(meal),
        ],
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


  Widget buildExpansioList(String title, Meal meal, [bool changeToStep = false]){
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        if(changeToStep){
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
            return Padding(
              padding: const EdgeInsets.fromLTRB( 10, 0 , 0 , 0),
              child: Text(title, style: const TextStyle(fontSize: 20),),
            );
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                     Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Insira um valor";
                          }
                            return null;
                        },
                        controller: changeToStep ? registrationController.textControllerNameIngredient : registrationController.textControllerNameStep,
                        decoration: const InputDecoration(
                          border :OutlineInputBorder()
                          )
                        )
                      ),
                    IconButton(
                      onPressed: (){
                        registrationController.formVerification();
                        if(changeToStep){
                          if(registrationController.textControllerNameIngredient.text.isNotEmpty){
                            registrationController.insertListIngredients(meal);
                          }
                        }else{
                          if(registrationController.textControllerNameStep.text.isNotEmpty){
                            registrationController.insertListStep(meal);
                          }
                        }
                      }, 
                      icon: const Icon(Icons.add)
                    )
                  ],
                ),
                buildListView(meal, changeToStep)
              ],
            ),
          )
        )
      ],
    );
  }

  Widget buildListView(Meal meal, [bool changeToStep = false]){
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: changeToStep ? meal.ingredientMeal.length : meal.stepMeal.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text(
                  changeToStep 
                  ? "${meal.ingredientMeal[index].name}"
                  : "${meal.stepMeal[index].name}"
                ),
              ),
            )
          ],
        );
      }
    );
  }
}