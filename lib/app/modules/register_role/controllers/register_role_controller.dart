import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';

class RegisterRoleController extends GetxController {
  void daftar(String role){
    AllMaterial.box.write("role", role);
  }
}
