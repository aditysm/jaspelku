import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/kebijakan_privasi_controller.dart';

class KebijakanPrivasiView extends GetView<KebijakanPrivasiController> {
  const KebijakanPrivasiView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KebijakanPrivasiController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kebijakan Privasi'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children:
                    List.generate(controller.kebijakanData.length, (index) {
                  final item = controller.kebijakanData[index];
                  return ExpansionTile(
                    title: Text(item['judul'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          item['isi'] ?? '',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text("Terakhir diperbarui: Selasa, 06 Mei 2025"),
                    SizedBox(height: 10),
                    Text(
                      "Aplikasi Jaspelku menghargai dan menjaga privasi pengguna. Kebijakan ini menjelaskan bagaimana data pribadi Anda dikumpulkan, digunakan, dan dilindungi selama Anda menggunakan aplikasi kami.",
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
