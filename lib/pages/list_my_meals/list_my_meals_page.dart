import 'package:app_refeicoes/models/checkbox_controller.dart';
import 'package:app_refeicoes/models/icon_button_controller.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/list_my_meals/list_my_meals_controller.dart';
import 'package:app_refeicoes/pages/my_meals/my_meal_page.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ListMyMealsPage extends StatefulWidget {
  const ListMyMealsPage({super.key});

  @override
  State<ListMyMealsPage> createState() => _ListMyMealsPageState();
}

class _ListMyMealsPageState extends State<ListMyMealsPage> {
  ListMyMealController listMyMealController = ListMyMealController();


  @override
  void initState() {
    listMyMealController.updateListMyMealsPage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Minhas refeicoes"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              listMyMealController.controllerCheckbox.sink.add([]);
              listMyMealController.controllerIconButton.sink.add(IconButtonController());
              showDialog(context: context, builder: (context) => buildDialog());
          }, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: StreamBuilder<List<Meal>>(
          stream: listMyMealController.controllerMyListMeals.stream,
          builder: (context, snapshot) {
            if(snapshot.data != null && snapshot.data!.isNotEmpty){
              return Column(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyMealsPage(id: snapshot.data![index].id!))),
                        title: Text(snapshot.data![index].name!),
                        subtitle:  Text(snapshot.data![index].complexity!),
                        leading: Text("${index + 1}", style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => listMyMealController.deleteMeal(context ,snapshot.data![index])
                        ),
                      );  
                    },
                  )
                ],
              );
            }else{
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/chef.png", height: 350),
                    const Text("Nenhuma receita cadastrada", style: TextStyle(fontSize: 40), textAlign: TextAlign.center,)
                  ],
                )
              );
            }
          }
        ) 
    );
  }

  Widget buildDialog(){
    return AlertDialog(
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Ordenacao/Filtro", style: TextStyle(fontSize: 25,  fontWeight: FontWeight.w400)),
                const Divider(),
                const Text("Ordenar por:", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                const SizedBox(height: 15),
                buildOrders("Alfabeto"),
                const SizedBox(height: 15),
                const Text("Filtrar por:", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                const SizedBox(height: 15),
                buildFilters("Custo", [ "Barato", "Razoável", "Caro"]),
                const SizedBox(height: 15),
                buildFilters("Dificuldade", ["Fácil", "Médio", "Difícil"]),
                const SizedBox(height: 40),
                const Divider(),
                buildBottomAlertDialog()
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildOrders(String name){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$name:", style: const TextStyle(fontSize: 19)),
        const SizedBox(width: 70),
        StreamBuilder<IconButtonController>(
          stream: listMyMealController.controllerIconButton.stream,
          builder: (context, snapshot) {
            return Row(
              children: [
                buildIconButton(name, snapshot.data?.name, false, snapshot.data?.isAsc),
                buildIconButton(name, snapshot.data?.name, true, snapshot.data?.isAsc)
              ]
            );
          }
        ),
      ],
    );
  }

  Widget buildFilters(String category, List<String> values){
    return StreamBuilder<List<CheckboxController>>(
      stream: listMyMealController.controllerCheckbox.stream,
      initialData: const [],
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$category:", style: const TextStyle(fontSize: 19)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: values.map((name) {
                return buildCheckBox(name, category, snapshot.data!);
              }).toList()
              // children: values.map((name) {
              //   return buildCheckBox(name, category, snapshot.data!);
              // }).toList()
            ),
          ],
        );
      }
    );
  }

  Widget buildCheckBox(String name, String category , List<CheckboxController> listCheckboxController){
    return Row(
      children: [
        Checkbox(
          value: listCheckboxController.where((element) => element.name == name && element.category == category).isNotEmpty,
          onChanged: (value) {
            if(value == true){
              listCheckboxController.add(CheckboxController(name: name, category: category));
              listMyMealController.controllerCheckbox.sink.add(listCheckboxController);
            }else{
              listCheckboxController.removeWhere((element) => element.name == name && element.category == category);
              listMyMealController.controllerCheckbox.sink.add(listCheckboxController);
            }
          },
          shape: const CircleBorder()
        ),
        Text(name)
      ],
    );
  }

  Widget buildBottomAlertDialog(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Voltar", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400))),
        TextButton(
          onPressed: () {
            listMyMealController.orderCrescentDescending(listMyMealController.controllerIconButton.valueOrNull?.isAsc, listMyMealController.controllerCheckbox.valueOrNull!.toList());
            // listMyMealController.orderList(listMyMealController.controllerCheckbox.valueOrNull!.toList());
            Navigator.pop(context);
          },
            child: const Text("Aplicar", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)
          )
        )
      ],
    );
  }

  Widget buildIconButton(String nameButton, String? name, bool valueButton, bool? isAsc){
    return IconButton(
      onPressed: () {
        if(valueButton == isAsc && nameButton == name){
          listMyMealController.controllerIconButton.sink.add(IconButtonController(name: nameButton, isAsc: null));
        }else{
          listMyMealController.controllerIconButton.sink.add(IconButtonController(name: nameButton, isAsc: valueButton));
        }
      }, 
      icon: Icon(
        valueButton 
        ? LineAwesomeIcons.sort_alphabetical_down
        : LineAwesomeIcons.sort_alphabetical_up
      ),  
        color: valueButton == isAsc && nameButton == name
        ? Colors.black
        : Colors.grey
    );
  }

}