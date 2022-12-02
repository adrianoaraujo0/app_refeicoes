import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/my_meals/my_meal_controller.dart';
import 'package:flutter/material.dart';

class MyMealsPage extends StatefulWidget {

  const MyMealsPage({required this.meal ,super.key});
  final Meal meal;

  @override
  State<MyMealsPage> createState() => _MyMealsPageState();
}

class _MyMealsPageState extends State<MyMealsPage> {
  MyMealsController myMealController = MyMealsController();

  @override
  void initState() {
    myMealController.initMyMealPage(widget.meal);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

  return Scaffold(
      appBar: AppBar( backgroundColor: Colors.red),
      body: StreamBuilder<Meal>(
        stream: myMealController.controllerMyMeal.stream,
        builder: (context, snapshot) {
          if(snapshot.data != null){
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    child: Image.network(snapshot.data!.imgUrl!),
                    /*decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: FileImage(File(widget.meal.imgUrl!)))
                    ),
                  ),*/
                  ),
                  containerDetails(),
                  const SizedBox(height: 30),
                  const Divider(endIndent: 30, indent: 30),
                  SizedBox(
                    height: 25,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "INGREDIENTES",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red
                          )
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.fastfood_rounded),
                      ],
                    ),
                  ),
                  const Divider(endIndent: 30, indent: 30),
                  listViewIngredients(snapshot.data!),
                  const SizedBox(height: 30),
                  const Divider(endIndent: 30, indent: 30),
                  SizedBox(
                    height: 25,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "PASSOS",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red
                          )
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.fastfood_rounded),
                      ],
                    ),
                  ),
                  const Divider(endIndent: 30, indent: 30),
                  listViewSteps(snapshot.data!)
                ]
              ),
            ),
          );
          }
          return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }

   Widget containerDetails(){
    return Container(
      padding: const EdgeInsets.all(10),
      height: 120,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.meal.name!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700, overflow: TextOverflow.fade)
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.access_time_rounded),
              const SizedBox(width: 5),
              Text("${widget.meal.duration}min"),
              const SizedBox(width: 20),

              const Icon(Icons.monetization_on_outlined),
              const SizedBox(width: 5),
              Text("${widget.meal.cost}"),
              const SizedBox(width: 20),
              
              const Icon(Icons.food_bank),
              const SizedBox(width: 5),
              Text("${widget.meal.complexity}"),
            ],
          )
        ],
      ),
    );
  }

  Widget listViewIngredients(Meal meal){
    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.meal.ingredientMeal.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_right_sharp),
              const SizedBox(width: 10),
              Expanded(
                child: Text( 
                  widget.meal.ingredientMeal[index].name!,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300)
                ),
              ),
            ],
          ),
        );  
      },
    );
  }

   Widget listViewSteps(Meal meal){
    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: meal.stepMeal.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
              children: [
                Text("${index + 1}",
                style: const TextStyle(fontSize: 30, color: Colors.grey, fontWeight: FontWeight.w100)),
                const SizedBox(width: 15),
                Expanded(child: Text(widget.meal.stepMeal[index].name!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, overflow: TextOverflow.clip))),
                // if(meal.stepMeal[index]!= null) 
                // IconButton(
                //   icon: Icon(Icons.access_time, size: 40, color: Colors.amber[300]),
                //   onPressed: (){
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => StopwatchPage(seconds: meal!.mealSteps[index]["seconds"])));
                //   }
                // ),
              ]
            ),
        );  
      },
    );
  }
}