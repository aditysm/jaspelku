import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/syarat_ketentuan_controller.dart';

class SyaratKetentuanView extends GetView<SyaratKetentuanController> {
  const SyaratKetentuanView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SyaratKetentuanController());
    var tileExpanded =
        List.generate(controller.syaratKetentuanData.length, (_) => false).obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Syarat & Ketentuan Jaspelku'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: controller.syaratKetentuanData.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.syaratKetentuanData.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '\nTerima kasih telah menjadi bagian dari ekosistem Jaspelku. Mari bersama menciptakan lingkungan jasa yang aman, adil, dan saling menguntungkan.',
                  style: TextStyle(fontSize: 15),
                ),
              );
            }

            final section = controller.syaratKetentuanData[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildExpansionTile(
                tileExpanded: tileExpanded,
                index: index,
                title: section['title'],
                children: List<Widget>.from(
                  section['items'].map<Widget>((item) {
                    return _buildListTile(
                      subtitle: item['subtitle'],
                      content: item['content'],
                    );
                  }),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildExpansionTile({
    required int index,
    required String title,
    required List<Widget> children,
    required RxList<bool> tileExpanded,
  }) {
    return GetBuilder<SyaratKetentuanController>(
      builder: (controller) {
        void toggleTile(int index, bool expanded) {
          tileExpanded[index] = expanded;
        }

        return ExpansionTile(
          title: Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          children: children,
          trailing: Icon(
            tileExpanded[index] ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          ),
          onExpansionChanged: (expanded) => toggleTile(index, expanded),
        );
      },
    );
  }

  Widget _buildListTile({required String subtitle, required String content}) {
    return ListTile(
      title: Text(
        subtitle,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text(
        content,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
