import 'dart:async';
import 'dart:io';
import 'package:app_refeicoes/models/form_registration.dart';
import 'package:app_refeicoes/pages/registration/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


class RegistrationPage extends StatefulWidget {
  RegistrationPage({required this.id ,super.key});

  final int id;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  RegistrationController registrationController = RegistrationController();

  String? complexity;

  String? cost;

  String? category;

  @override
  void initState() {
    registrationController.initBd();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red),
      body: StreamBuilder<FormRegistration>(
        stream: registrationController.controllerForm.stream,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addImage(),
                const SizedBox(height: 10),
                buildForm(),
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
          // registrationController.insertMealDatabase(category!);
        }
      ),
    );
  }

  Widget addImage(){
    return InkWell(
      onTap: () {
        registrationController.takePhotoFromGallery();
      },
      child: StreamBuilder<String>(
        stream: registrationController.controllerImage.stream,
        builder: (context, snapshot) {
          if(snapshot.data == null){
            return Container(
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
            );
          }
          return SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.file(File(snapshot.data!), fit: BoxFit.cover)
          );
        }
      ),
    );
  }

  Widget buildForm(){
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
          buildRadioButton(),
        ],
      ),
    );
  }

  Widget buildRadioButton(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: const Text("Dificuldade", style: TextStyle(fontSize: 22)),
        ),
        StreamBuilder<String>(
          stream: registrationController.controllerRadioComplexity.stream,
          builder: (context, snapshot) {
            return StreamBuilder<String>(
              stream: registrationController.controllerRadioComplexity.stream,
              builder: (context, snapshot){
                return Column(
                  children: [
                    buildRadioListTile("Fácil", snapshot.data, registrationController.updateRadioComplexity),
                    buildRadioListTile("Médio", snapshot.data, registrationController.updateRadioComplexity),
                    buildRadioListTile("Difícil", snapshot.data, registrationController.updateRadioComplexity),
                  ],
                );
              }
            );
          }
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0 , 10),
          child: const Text("Custo", style: TextStyle(fontSize: 22)),
        ),
        StreamBuilder<String>(
          stream: registrationController.controllerRadioCost.stream,
          builder: (context, snapshot) {
            return Column(
              children: [
                buildRadioListTile("Barato", snapshot.data, registrationController.updateRadioCost),
                buildRadioListTile("Razoável", snapshot.data, registrationController.updateRadioCost),
                buildRadioListTile("Caro", snapshot.data, registrationController.updateRadioCost),
              ],
            );
          }
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
    return StreamBuilder<String>(
      stream: registrationController.controllerDropdownButton.stream,
      builder: (context, snapshot) {
        return DropdownButton(
          hint: Text(title),
          items: items.map((name){
            return DropdownMenuItem(
              value: name, 
              child: Text(name),
            );
          }).toList(),
          onChanged: (newTitle) {
            title = newTitle!;
            category = newTitle;
            registrationController.controllerDropdownButton.sink.add(newTitle);
          }
        );
      }
    );
  }

  Widget buildStreamBuilder({required StreamController<List<dynamic>> controller}){
    return StreamBuilder<List<dynamic>>(
      stream: controller.stream,
      builder: (context, snapshot) {
        if(snapshot.data != null && snapshot.data!.isNotEmpty){
            return buildListView(snapshot.data!);
        }
        return Container();
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
    return StreamBuilder(
      stream: controller.stream,
      initialData: false,
      builder: (context, snapshot) {
        return ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            controller.sink.add(!isExpanded);
          },
          children: [
            ExpansionPanel(
              isExpanded: snapshot.data,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return Text(title);
              },
              body: const Text("TESTE")
            )
          ],
        );
      }
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
          buildStreamBuilder(controller: controller)
        ],
      ),
    );
  }
}