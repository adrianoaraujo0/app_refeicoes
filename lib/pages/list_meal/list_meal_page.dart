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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.categoryName), 
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.abc)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: buildPopMenuButton(context),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //   child: PopupMenuButton(
          //     child: const Icon(Icons.filter_alt),
          //     itemBuilder: (context) {
          //       return [
          //         PopupMenuItem(child: Text("Custo")),
          //         PopupMenuItem(child: Text("Tempo")),
          //         PopupMenuItem(child: Text("Dificuldade"))
          //       ];  
          //     },
          //   ),
          // ),
        ],
      ),
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  buildListView(snapshot.data!.docs)
                ] 
              ),
            );
          }
        }
      ),
    );
  }

  Widget buildListView(List<QueryDocumentSnapshot<Map<String, dynamic>>> listMeals){
    return StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>> (
      stream: listMealController.controllerListView.stream,
      builder: (context, snapshot) {
        if(snapshot.data != null){
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return buildListTile(snapshot.data![index], index);
            },
          );
        }
        else{
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listMeals.length,
            itemBuilder: (context, index) {
              return buildListTile(listMeals[index], index);
            },
          );
        }
      }
    );
  }

  Widget buildListTile(QueryDocumentSnapshot<Map<String, dynamic>>  meal, int index){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MealPage(meal: meal))),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                height: 300,
                width: double.maxFinite,
                child: Image.network(meal["imgUrl"], fit: BoxFit.fill)
                ),
                SizedBox(
                  height: 100,
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Flexible(child: Divider(color: Colors.grey, endIndent: 20, indent: 20)), 
                          Text(meal["category"], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100)),
                          const Flexible(child: Divider(color: Colors.grey,  endIndent: 20, indent: 20)), 
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(meal["name"], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPopMenuButton(BuildContext context){
    return PopupMenuButton(
      child: const Icon(Icons.filter_alt),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: const Text("Custo"),
            onTap: () {
              Future(() => showDialog(context: context, builder: (_) => buildPopMenuButtonCheckBox(context, "Custo" ,["Barato", "Razoável", "Caro"])));
            },
          ),
          PopupMenuItem(
            child: const Text("Tempo"),
            onTap: () {
              Future(() => showDialog(context: context, builder: (_) => buildPopMenuButtonCheckBox(context, "Tempo" ,["Rápido", "Razoável", "Demorado"])));
            },
          ),
          PopupMenuItem(
            child: const Text("Dificuldade"),
            onTap: () {
              Future(() => showDialog(context: context, builder: (_) => buildPopMenuButtonCheckBox(context, "Dificuldade" ,["Fácil", "Médio", "Difícil"])));
            },
          )
        ];  
      },
    );
  }

  Widget buildPopMenuButtonCheckBox(BuildContext context, String filter ,List<String> values){
    return AlertDialog(
      title: const Text('Filtrar por: '),
        actions: values.map(
        (name) {
          return StreamBuilder<Map<String, bool>>(
            stream: listMealController.controllerCheckBox.stream,
            initialData: const { "" : false},
            builder: (context, snapshot) {
              return CheckboxListTile(
                title: Text(name),
                value: name == snapshot.data!.keys.first && snapshot.data!.values.first, 
                onChanged: (onchanged){
                  listMealController.controllerCheckBox.sink.add({name : onchanged!});
                }
              );
            }
          );
        }
      ).toList()
    );
  }
}