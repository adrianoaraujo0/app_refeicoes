import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/list_my_meals/list_my_meals_controller.dart';
import 'package:app_refeicoes/pages/my_meal/my_meal_page.dart';
import 'package:flutter/material.dart';

class ListMyMealsPage extends StatefulWidget {
  ListMyMealsPage({super.key});

  @override
  State<ListMyMealsPage> createState() => _ListMyMealsPageState();
}

class _ListMyMealsPageState extends State<ListMyMealsPage> {
  ListMyMealController listMyMealController = ListMyMealController();


  @override
  void initState() {
    listMyMealController.initListMyMealsPage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red, title: const Text("Minhas refeicoes"), centerTitle: true),
      body: StreamBuilder<List<Meal>>(
          stream: listMyMealController.controllerMyListMeals.stream,
          builder: (context, snapshot) {
            if(snapshot.data != null && snapshot.data!.isNotEmpty){
              return Column(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data!.length ,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyMealPage(meal: snapshot.data![index]))),
                        title: Text(snapshot.data![index].name!),
                        subtitle:  Text(snapshot.data![index].category!),
                        leading: Text("${index + 1}", style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
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
}