import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaspelku/all_material.dart';
import 'package:jaspelku/app/modules/login/views/login_view.dart';

class GeneralController extends GetxController {
  static String shortenWithSeeMore(String text,
      {required int maxLines, required BuildContext context}) {
    final span = TextSpan(
      text: text,
      style: DefaultTextStyle.of(context).style,
    );
    final tp = TextPainter(
      text: span,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);
    if (tp.didExceedMaxLines) {
      return "${text.substring(0, 80)}... Lihat Selengkapnya";
    } else {
      return text;
    }
  }

  Future<dynamic> logout({bool isExpired = false}) async {
    Get.offAll(() => const LoginView());
    AllMaterial.isServant.value = false;
    AllMaterial.box.erase();
    AllMaterial.box.remove("token");
    AllMaterial.box.remove("login");
    AllMaterial.box.remove("udahFcm");
    // try {
    //   final response = await http.post(
    //     Uri.parse(ApiUrl.urlPostLogout),
    //     headers: {
    //       "Content-Type": "application/json",
    //     },
    //   );
    //   print(response.body);
    //   if (response.statusCode == 200) {
    //     Get.reloadAll();
    //     Get.back();

    //     // ALL
    //     Get.offAll(() => const LoginPageView());
    //     AllMaterial.box.erase();
    //     AllMaterial.box.remove("token");
    //     AllMaterial.box.remove("udahFcm");
    //     if (isExpired == true) {
    //       AllMaterial.messageScaffold(
    //         title: "Sesi berakhir, silahkan login kembali",
    //       );
    //     } else {
    //       AllMaterial.messageScaffold(
    //         title: "Logout Berhasil, Sampai Jumpa!",
    //       );
    //     }
    //     update();
    //   } else {
    //     AllMaterial.messageScaffold(
    //       title: "Kesalahan, tidak dapat melakukan aksi sebelumnya!",
    //     );
    //   }
    // } catch (e) {
    //   throw Exception(e.toString());
    // }
  }
}
