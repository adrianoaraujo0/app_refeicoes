import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/list_meal/list_meal_controller.dart';
import 'package:flutter/material.dart';

class ListMealPage extends StatefulWidget {
  ListMealPage({required this.categoryName ,super.key});

  final String categoryName;

  @override
  State<ListMealPage> createState() => _ListMealPageState();
}

class _ListMealPageState extends State<ListMealPage> {
  ListMealController listMealController = ListMealController();

  @override
  void initState() {
    listMealController.initPage(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName), centerTitle: true, backgroundColor: Colors.red),
      body: StreamBuilder<List<Meal>>(
        stream: listMealController.controllerListMeal.stream,
        builder: (context, snapshot) {
          if(snapshot.data != null && snapshot.data!.isNotEmpty){
            return Center(
              child: Column(
                children: [
                  buildListView(snapshot.data!)
                ],
              ),
            );
          }
          return const Text("Não há nenhuma receita nesta categoria", style: TextStyle(fontSize: 30), textAlign: TextAlign.center);
        }
      ),
    );
  }

  Widget buildListView(List<Meal> listMeals){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listMeals.length,
      itemBuilder: (context, index) {
        return buildListTile(listMeals, index);
      },
    );
  }

  Widget buildListTile(List<Meal> listMeals, int index){
    return ListTile(
        title: Text(listMeals[index].name!),
    );
  }
}