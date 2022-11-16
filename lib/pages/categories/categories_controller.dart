import 'package:app_refeicoes/pages/registration/registration_repository.dart';

class CategoriesController{

  RegistrationRepository registrationRepository = RegistrationRepository();

  void initCategoriesPage(){
    registrationRepository.initDb();
  }


}