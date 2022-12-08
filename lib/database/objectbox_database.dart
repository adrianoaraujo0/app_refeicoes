import 'package:app_refeicoes/database/objectbox.g.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  // The Store of this app.
  static late final Store store;

  static late final Box<Meal>  mealId;
  

  static Future<void> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    store = await openStore(directory: path.join(docsDir.path, "obx-example"));

    mealId = store.box<Meal>();
  }
}