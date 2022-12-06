import 'package:app_refeicoes/pages/list_meal/list_meal_controller.dart';
import 'package:app_refeicoes/pages/meal/meal_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListMealPage extends StatefulWidget {
  const ListMealPage({required this.categoryName ,super.key});

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("meals").where("category", isEqualTo: widget.categoryName).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.data == null){
            return const Center(
              child: CircularProgressIndicator()
            );
          }else if(snapshot.data!.docs.isEmpty){
            return Column(
              children: [
                Image.asset("assets/images/chef2.png"),
                const Text("Não há nenhuma receita nesta categoria", style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
              ],
            );
          }else {
            return Column(
              children: [
                buildListView(snapshot.data!.docs)
              ],
            );
          }
        }
      ),
    );
  }

  Widget buildListView(List<QueryDocumentSnapshot<Map<String, dynamic>>> listMeals){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listMeals.length,
      itemBuilder: (context, index) {
        return buildListTile(listMeals[index], index);
      },
    );
  }

  Widget buildListTile(QueryDocumentSnapshot<Map<String, dynamic>>  meal, int index){
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MealPage(meal: meal.data()))),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            ListTile(
              leading: Text("${index + 1}", style: const TextStyle(fontSize: 20)),
              title: Text(meal["name"]),
              subtitle:  Text(meal["category"]),
              trailing: IconButton(
                icon:  Icon(
                  Icons.favorite, 
                  color: meal["favorite"] ? Colors.red : Colors.grey
                ), 
                onPressed: () => listMealController.changeFavorite(meal.id, meal["favorite"])
              ),
            ),
            Container(
              height: 230,
              width: double.maxFinite,
              child: Image.network(meal["imgUrl"], fit: BoxFit.cover)
            )
          ],
        ),
      ),
    );
  }
}