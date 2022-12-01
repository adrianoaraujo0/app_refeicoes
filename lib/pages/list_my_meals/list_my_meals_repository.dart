import 'package:app_refeicoes/db/database_provider.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:sqflite/sqflite.dart';

class ListMyMealsRepository{

  late final Database _database;

  Future<void> initDb() async{
    _database = await DBProvider.db.database;
  }

  Future<List<Meal>> findAllListMeals() async {
    List<Map<String, dynamic>> mealMap = await _database.rawQuery("SELECT * FROM meal");
    return Meal.fromMapList(mealMap);
  }

 Future<void> fillDatabase() async{ 
     await _database.rawQuery("INSERT INTO meal(id, name, cost, complexity, category, duration, imgUrl) VALUES(1,'Macaronada', 'Barato', 'Difícil', 'Italiano', 360, 'https://i.ytimg.com/vi/XARKwLO2Zjw/maxresdefault.jpg')");
     
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(1, 1, 'Coloque a cebola no óleo fervendo e, antes de dourá-la, acrescente o alho.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(2, 1, 'Deixe até dourar, apague o fogo e reserve.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(3, 1, 'Coloque os tomates em uma panela com 2 litros de água para ferver.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(4, 1, 'Quando ferver, retire os tomates e deixe-os esfriar.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(5, 1, 'Reponha água, se for preciso, e na mesma panela cozinhe o macarrão (al dente ou bem cozido), com sal a gosto.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(6, 1, 'Escorra o macarrão, mas não lave.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(7, 1, 'É muito importante não lavar a massa, apenas escorra a água do cozimento em um local seco da pia e reserve em um local seco e protegido de vento.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(8, 1, 'Retire a casca e as sementes do tomate cozido, pique-o bem pequeno (ou passe no processador), e junte à cebola e ao alho reservados.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(9, 1, 'Junte também o pimentão, as azeitonas e 1 pitada de açúcar.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(10, 1, 'Leve ao fogo baixo e deixe cozinhar 15 minutos em panela tampada, mexendo de vez em quando.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(11, 1, 'Corrija o sal a seu gosto, lembrando que a massa que não foi lavada já possui sal.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(12, 1, 'Apague o fogo, acrescente 1 xícara de queijo parmesão (espalhando sobre o molho).')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(13, 1, 'Acrescente em seguida o macarrão (ainda quente do cozimento) e o orégano.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(14, 1, 'Misture e sirva em seguida, acompanhado do queijo parmesão restante.')");
          

     await _database.rawQuery("INSERT INTO ingredient(id, mealId, name) VALUES(1, 1, '250 g de macarrão tipo espaguete')");
     await _database.rawQuery("INSERT INTO ingredient(id, mealId, name) VALUES(2, 1, '6 tomates maduros médios sem pele e sem sementes')");
     await _database.rawQuery("INSERT INTO ingredient(id, mealId, name) VALUES(3, 1, '10 dentes de alho bem picados')");
     await _database.rawQuery("INSERT INTO ingredient(id, mealId, name) VALUES(4, 1, '1 cebola média ralada')");
     await _database.rawQuery("INSERT INTO ingredient(id, mealId, name) VALUES(5, 1, '1 xícara de pimentão verde bem picado')");
     await _database.rawQuery("INSERT INTO ingredient(id, mealId, name) VALUES(6, 1, 'Óleo')");
     await _database.rawQuery("INSERT INTO ingredient(id, mealId, name) VALUES(7, 1, '2 colheres de sopa de orégano')");
     await _database.rawQuery("INSERT INTO ingredient(id, mealId, name) VALUES(8, 1, 'Açúcar')");
     await _database.rawQuery("INSERT INTO ingredient(id, mealId, name) VALUES(9, 1, '6 azeitonas verdes (ou de sua preferencia)')");
     await _database.rawQuery("INSERT INTO ingredient(id, mealId, name) VALUES(10, 1, '2 xícaras médias de queijo parmesão ralado (use o ralador)')");



     await _database.rawQuery("INSERT INTO meal(id, name, cost, complexity, category, duration, imgUrl) VALUES(2,'Cafe cremoso', 'Barato', 'Fácil', 'Café da Manhã', 120, 'https://img.itdg.com.br/tdg/images/recipes/000/011/486/140396/140396_original.jpg?mode=crop&width=160&height=220')");
    
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(15, 2, 'Junte todos os ingredientes e bata na batedeira durante 15 minutos até ficar um creme.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(16, 2, 'Guarde no congelador em pote fechado.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(17, 2, 'Este creme é para ser servido do seguinte modo: 1 colher de sobremesa em 1 xícara de café quente (já pronto) ou 2 colheres de sobremesa em 1 xícara de leite fervendo.')");
     await _database.rawQuery("INSERT INTO step(id, mealId, name) VALUES(18, 2, 'Está pronta uma deliciosa bebida cremosa para aquecer as noites frias de inverno.')");
    
     await _database.rawQuery("INSERT INTO ingredient(id, mealId, name) VALUES(11, 2, '50 g de café solúvel')");
     await _database.rawQuery("INSERT INTO ingredient(id, mealId, name) VALUES(12, 2, '2 xícaras de açúcar refinado')");
     await _database.rawQuery("INSERT INTO ingredient(id, mealId, name) VALUES(13, 2, '1 xícara de água')");
    
    
  }



}