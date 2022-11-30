import 'package:app_refeicoes/data/dummy_data.dart';
import 'package:app_refeicoes/models/category.dart';
import 'package:app_refeicoes/pages/drawer/drawer_component.dart';
import 'package:app_refeicoes/pages/list_meal/list_meal_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerComponent(),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Categorias"),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        child: Column(
      children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              height: 300,
              width: double.infinity,
              child: listViewCategories()
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text("Favorites", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget listViewCategories(){
   return ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        Category category = dummyCategories[index];
        return InkWell(
          child: itemList(category),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ListMealPage(categoryName: category.name))),
        );
      },
    );
  }

  Widget itemList(Category category){
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    height: 300,
    width: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(image: AssetImage(category.image), fit: BoxFit.cover),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 70,
          width: 250,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius:  BorderRadius.vertical(bottom: Radius.circular(20)),
            color: Colors.black38, 
          ),
          child: Text(category.name, style: const TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center),
        ),
      ]
    ),
  );
}


}