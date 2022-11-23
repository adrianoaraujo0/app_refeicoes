import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:app_refeicoes/models/form_registration.dart';
import 'package:app_refeicoes/models/ingredient.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/models/step_meal.dart';
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
    registrationController.initFormRegistration(widget.id);
    log("${widget.id}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red),
      body: StreamBuilder<FormRegistration>(
        stream: registrationController.controllerFormRegistration.stream,
        builder: (context, snapshot) {
          print(snapshot.data?.meal?.imgUrl);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addImage(imgUrl: snapshot.data?.meal?.imgUrl),
                const SizedBox(height: 10),
                buildForm(snapshot.data?.meal?.complexity),
                const SizedBox(height: 40),
               buildExpansioList(controller: registrationController.controllereExpasionListIngredients, title: "Insira os ingredientes"),
               buildExpansioList(controller: registrationController.controllereExpasionListSteps, title: "Insira os passos"),
              ],
            ),
          );
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

  Widget addImage({required String? imgUrl}){
    return InkWell(
      onTap: () {
        registrationController.takePhotoFromGallery();
      },
      child: imgUrl == null 
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
        child: Image.file(File(imgUrl), fit: BoxFit.cover)
      )
    );
  }

  Widget buildForm(String? groupValue){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            TextField(
            controller: registrationController.textControllerNameMeal,
              decoration: const InputDecoration(hintText: "ex: Ovo mexido", labelText: "Nome da receita"),
            ),
          const SizedBox(height: 10),
          buildDropDownButton(
            title: "Categorias",
            items: ["Italiano" , "Rápido & Fácil", "Hamburgers", "Alemã", "Leve & Saudável", "Exótica", "Café da Manhã","Asiática","Francesa", "Verão"],
          ),
          SizedBox(
            width: 100,
            child: TextField(
              controller: registrationController.textControllerTimeMeal,
              keyboardType: const TextInputType.numberWithOptions(),
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp ("[,]"))],
              decoration: const InputDecoration(labelText: "Tempo", hintText: "ex: 12 min"),
            )
          ),
          buildRadioButton(groupValue),
        ],
      ),
    );
  }

  Widget buildRadioButton(String? groupValue){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: const Text("Dificuldade", style: TextStyle(fontSize: 22)),
        ),
        Column(
        children: [
          buildRadioListTile("Fácil", groupValue, registrationController.updateRadioComplexity),
          buildRadioListTile("Médio", groupValue, registrationController.updateRadioComplexity),
          buildRadioListTile("Difícil", groupValue, registrationController.updateRadioComplexity),
        ],
      ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0 , 10),
          child: const Text("Custo", style: TextStyle(fontSize: 22)),
        ),

        Column(
          children: [
            buildRadioListTile("Barato", "", registrationController.updateRadioCost),
            buildRadioListTile("Razoável", "", registrationController.updateRadioCost),
            buildRadioListTile("Caro", "", registrationController.updateRadioCost),
          ],
        ),
        
      ],
    );
  }

  Widget buildRadioListTile(String title, String? groupValue, Function updateRadio){
    return RadioListTile(
      title: Text(title),
      value: title,
      groupValue: groupValue,
      onChanged: (value){
        updateRadio(value);
      }
    );
  }

  Widget buildDropDownButton({required String title, required List<String> items}){
    return DropdownButton(
      hint: Text(title),
      items: items.map((name){
        return DropdownMenuItem(
          value: name, 
          child: Text(name),
        );
      }).toList(),
      onChanged: (newTitle) {
        registrationController.category = newTitle!;
        category = newTitle;
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

  Widget buildExpansioList({required StreamController controller, required String title}){
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        controller.sink.add(!isExpanded);
      },
      children: [
        ExpansionPanel(
          isExpanded:false,
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