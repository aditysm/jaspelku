import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jaspelku/app/utils/all_material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:jaspelku/app/utils/toast_dialog.dart';

class VerifikasiAkunController extends GetxController {
  var missingFields = <String>[].obs;

  var namaUserC = TextEditingController();
  var domisiliC = TextEditingController();
  var pengalamanJabatanC = TextEditingController();
  var pengalamanPerusahaanC = TextEditingController();
  var urlSosmedC = TextEditingController();
  var namaRekeningC = TextEditingController();
  var nomorRekeningC = TextEditingController();
  var sosmedC = TextEditingController();

  var namaUserError = "".obs;
  var domisiliError = "".obs;
  var sosmedError = "".obs;
  var pengalamanJabatanError = "".obs;
  var pengalamanPerusahaanError = "".obs;
  var urlSosmedError = "".obs;
  var namaRekeningError = "".obs;
  var nomorRekeningError = "".obs;

  @override
  void onInit() {
    super.onInit();
    namaUserC.addListener(() {
      if (namaUserC.text.isNotEmpty) {
        namaUserError.value = '';
        missingFields.clear();
      }
    });
    pengalamanJabatanC.addListener(() {
      if (pengalamanJabatanC.text.isNotEmpty) {
        missingFields.clear();
        pengalamanJabatanError.value = '';
      }
    });
    pengalamanPerusahaanC.addListener(() {
      if (pengalamanPerusahaanC.text.isNotEmpty) {
        missingFields.clear();
        pengalamanPerusahaanError.value = '';
      }
    });
    urlSosmedC.addListener(() {
      if (urlSosmedC.text.isNotEmpty) {
        missingFields.clear();
        urlSosmedError.value = '';
      }
    });
    namaRekeningC.addListener(() {
      if (namaRekeningC.text.isNotEmpty) {
        missingFields.clear();
        namaRekeningError.value = '';
      }
    });
    nomorRekeningC.addListener(() {
      if (nomorRekeningC.text.isNotEmpty) {
        missingFields.clear();
        nomorRekeningError.value = '';
      }
    });
    domisiliC.addListener(() {
      if (domisiliC.text.isNotEmpty) {
        missingFields.clear();
        domisiliError.value = '';
      }
    });
    sosmedC.addListener(() {
      if (sosmedC.text.isNotEmpty) {
        missingFields.clear();
        sosmedError.value = '';
      }
    });
  }

  RxString namaUser = "Budi Santoso".obs;
  RxBool akunTerverifikasi = false.obs;

  final RxString sosmed = ''.obs;
  final RxString sosmedUrl = ''.obs;
  void tambahSosialMedia() {
    sosmedError.value = "";

    // Peta sosial media ke domain yang diharapkan
    final Map<String, String> expectedDomains = {
      "Facebook": "facebook.com",
      "Instagram": "instagram.com",
      "Twitter": "twitter.com",
      "LinkedIn": "linkedin.com",
      "TikTok": "tiktok.com",
    };

    final selected = sosmed.value.trim();
    final url = sosmedUrl.value.trim().toLowerCase();

    if (selected.isEmpty) {
      sosmedError.value = "Jenis sosial media wajib dipilih";
    } else if (url.isEmpty) {
      sosmedError.value = "URL sosial media wajib diisi";
    } else if (!url.isURL) {
      sosmedError.value = "URL tidak valid";
    } else if (!url.contains(expectedDomains[selected]!)) {
      sosmedError.value = "URL tidak sesuai dengan sosial media yang dipilih";
    } else {
      sosialMediaList.add({
        "tipe": selected,
        "url": url,
      });

      sosmed.value = "";
      sosmedC.clear();
      sosmedUrl.value = "";
    }

    update();
  }

  final sosialMediaList = <Map<String, String>>[].obs;

  // Foto Selfie
  Rx<File?> fotoSelfieDenganIdentitas = Rx<File?>(null);

  Future<void> pilihFotoSelfieDenganIdentitas() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      fotoSelfieDenganIdentitas.value = File(pickedFile.path);
    } else {
      ToastService.show("Tidak ada gambar yang dipilih");
    }
  }

  // --- Isian Data
  RxString namaLengkap = ''.obs;

  // Waktu Pengalaman
  // Pengalaman - List form input pengalaman
  RxList<Map<String, dynamic>> pengalamanList =
      RxList<Map<String, dynamic>>([]);

  // Data Pengalaman - Untuk form input
  RxString pengalamanText = ''.obs;
  RxString instansiText = ''.obs;
  void hitungDurasiPengalaman() {
    final now = DateTime.now();
    final dari = pengalamanDari.value;

    int tahunSelisih = now.year - dari.year;
    int bulanSelisih = now.month - dari.month;

    int totalBulan = tahunSelisih * 12 + bulanSelisih;
    if (now.day < dari.day) {
      totalBulan -= 1;
    }

    pengalamanPeriode.value = totalBulan;
  }

  Rx<DateTime> pengalamanDari = Rx<DateTime>(DateTime.now());
  Future<void> pilihTanggalPengalamanDari(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: pengalamanDari.value,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != pengalamanDari.value) {
      pengalamanDari.value = pickedDate;
    }
  }

  RxString pengalamanJabatan = ''.obs;
  RxString pengalamanPerusahaan = ''.obs;
  RxInt pengalamanPeriode = 0.obs;
  void hapusPengalaman(int index) {
    pengalamanList.removeAt(index);
    update();
  }

  void tambahInputPengalaman() {
    if (pengalamanJabatan.value != "" && pengalamanPerusahaan.value != "") {
      pengalamanList.add({
        "jabatan": pengalamanJabatan.value,
        "instansi": pengalamanPerusahaan.value,
        "mulai_kerja": pengalamanDari.value,
        "durasi_bulan": pengalamanPeriode.value,
      });

      // Reset hanya field input
      pengalamanJabatan.value = "";
      pengalamanPerusahaan.value = "";
      pengalamanJabatanC.clear();
      pengalamanPerusahaanC.clear();
      pengalamanDari.value = DateTime.now();
      pengalamanPeriode.value = 0;
    } else {
      if (pengalamanJabatan.value.isEmpty) {
        pengalamanJabatanError.value = "Posisi/Jabatan wajib diisi";
      }
      if (pengalamanPerusahaan.value.isEmpty) {
        pengalamanPerusahaanError.value = "Perusahaan/Organisasi wajib diisi";
      }
    }

    update();
  }

  // Alamat
  RxString provinsi = ''.obs;
  RxString kabupaten = ''.obs;
  RxString kecamatan = ''.obs;
  RxString kelurahan = ''.obs;
  RxString domisili = ''.obs;

  // Sosial Media
  RxList<Map<String, String>> akunSosialMedia = <Map<String, String>>[].obs;
  RxString sosialMediaInstagram = ''.obs;
  RxString sosialMediaLinkedin = ''.obs;
  RxString sosialMediaTwitter = ''.obs;
  RxString rekeningNomor = ''.obs;

  // Portofolio - Pengalaman
  RxList<Map<String, dynamic>> pengalaman = <Map<String, dynamic>>[].obs;

  // Rekening Bank
  // RxList<Map<String, String>> rekeningBank = <Map<String, String>>[].obs;
  RxString rekeningNama = ''.obs;
  RxString rekeningBank = ''.obs;

  final List<String> daftarMediaSosial = [
    "Facebook",
    "Instagram",
    "Twitter",
    "LinkedIn",
    "TikTok"
  ];

  final List<String> daftarBankMidtrans = [
    "BCA",
    "BNI",
    "BRI",
    "MANDIRI",
    "PERMATA",
    "CIMB NIAGA",
    "DANAMON",
    "MAYBANK"
  ];

  // Dummy wilayah (harusnya dari API)
  final List<String> daftarProvinsi = ["DKI Jakarta", "Jawa Barat"];
  final List<String> daftarKabupaten = ["Kota Jakarta Selatan", "Kab. Bandung"];
  final List<String> daftarKecamatan = ["Setiabudi", "Cibiru"];
  final List<String> daftarKelurahan = ["Kuningan Timur", "Cibiru Wetan"];

  void mulaiVerifikasiModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 1,
          builder: (_, controllerScroll) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AllMaterial.isDarkMode.isFalse
                    ? Colors.white
                    : Theme.of(context).cardColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag Handle
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Verifikasi Data',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controllerScroll,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Nama Lengkap"),
                          const SizedBox(height: 12),

                          AllMaterial.textField(
                            hintText: "Masukkan Nama Lengkap Anda...",
                            onChanged: (p0) => namaLengkap.value = p0,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Foto Selfie dengan Identitas",
                            style: TextStyle(
                              fontWeight: AllMaterial.fontMedium,
                            ),
                          ),

                          Text(
                            "- Wajah terlihat jelas\n- Identitas sejajar dengan wajah\n- Tidak blur & terang",
                            style: TextStyle(),
                          ),
                          const SizedBox(height: 12),
                          Obx(
                            () {
                              return fotoSelfieDenganIdentitas.value == null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                            "Belum ada foto yang dipilih."),
                                        const SizedBox(height: 8),
                                        AllMaterial.cusButton(
                                          addIcon: true,
                                          icon: Icon(Icons.camera_alt,
                                              color: AllMaterial.colorWhite),
                                          label:
                                              "Ambil Foto Selfie dengan Identitas",
                                          onTap: () =>
                                              pilihFotoSelfieDenganIdentitas(),
                                        ),
                                      ],
                                    )
                                  : LayoutBuilder(
                                      builder: (context, constraints) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.file(
                                                fotoSelfieDenganIdentitas
                                                    .value!,
                                                fit: BoxFit.contain,
                                                width: constraints.maxWidth,
                                              ),
                                            ),
                                            TextButton.icon(
                                              icon: Icon(
                                                Icons.delete_outline,
                                              ),
                                              onPressed: () {
                                                AllMaterial.cusDialogValidasi(
                                                  title: "Hapus Gambar",
                                                  subtitle:
                                                      "Yakin ingin menghapus gambar ini?",
                                                  onConfirm: () {
                                                    Get.back();
                                                    fotoSelfieDenganIdentitas
                                                        .value = null;
                                                  },
                                                  onCancel: () => Get.back(),
                                                );
                                              },
                                              label:
                                                  Text("Hapus Gambar Terpilih"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                            },
                          ),
                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 12),
                          const Text("Alamat Lengkap"),
                          const SizedBox(height: 12),

                          Obx(() {
                            return AllMaterial.buildDropdown(
                              items: daftarProvinsi,
                              selectedValue: provinsi.value,
                              onChanged: (val) => provinsi.value = val ?? '',
                              isDarkMode: AllMaterial.isDarkMode.value,
                              hintText: "Provinsi",
                            );
                          }),
                          const SizedBox(height: 12),
                          Obx(() {
                            return AllMaterial.buildDropdown(
                              items: daftarKabupaten,
                              selectedValue: kabupaten.value,
                              onChanged: (val) => kabupaten.value = val ?? '',
                              isDarkMode: AllMaterial.isDarkMode.value,
                              hintText: "Kabupaten/Kota",
                            );
                          }),
                          const SizedBox(height: 12),
                          Obx(() {
                            return AllMaterial.buildDropdown(
                              items: daftarKecamatan,
                              selectedValue: kecamatan.value,
                              onChanged: (val) => kecamatan.value = val ?? '',
                              isDarkMode: AllMaterial.isDarkMode.value,
                              hintText: "Kecamatan",
                            );
                          }),

                          const SizedBox(height: 12),
                          Obx(() {
                            return AllMaterial.buildDropdown(
                              items: daftarKelurahan,
                              selectedValue: kelurahan.value,
                              onChanged: (val) => kelurahan.value = val ?? '',
                              isDarkMode: AllMaterial.isDarkMode.value,
                              hintText: "Kelurahan",
                            );
                          }),
                          const SizedBox(height: 12),
                          AllMaterial.textField(
                            controller: domisiliC,
                            isVerif: true,
                            labelText: "Domisili (Nama Jalan/Patokan)",
                            onChanged: (val) => domisili.value = val,
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(height: 12),
                          const Divider(),

                          const SizedBox(height: 24),
                          // Pengalaman Section
                          const Text("Pengalaman Kerja"),
                          const SizedBox(height: 12),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // FORM INPUT
                              Obx(() => AllMaterial.textField(
                                    controller: pengalamanJabatanC,
                                    errorText: pengalamanJabatanError.isEmpty
                                        ? null
                                        : pengalamanJabatanError.value,
                                    isVerif: true,
                                    labelText: "Posisi/Jabatan",
                                    onChanged: (val) =>
                                        pengalamanJabatan.value = val,
                                  )),
                              SizedBox(height: 16),
                              Obx(() => AllMaterial.textField(
                                    controller: pengalamanPerusahaanC,
                                    errorText: pengalamanPerusahaanError.isEmpty
                                        ? null
                                        : pengalamanPerusahaanError.value,
                                    isVerif: true,
                                    textInputAction: TextInputAction.done,
                                    labelText: "Perusahaan/Organisasi",
                                    onChanged: (val) =>
                                        pengalamanPerusahaan.value = val,
                                  )),
                              SizedBox(height: 16),
                              Obx(() => AllMaterial.textField(
                                    isVerif: true,
                                    enabled: false,
                                    controller: TextEditingController(
                                      text: DateFormat("MMMM yyyy", "id_ID")
                                          .format(pengalamanDari.value),
                                    ),
                                    onTap: () async {
                                      await pilihTanggalPengalamanDari(context);
                                      hitungDurasiPengalaman();
                                    },
                                    labelText: "Mulai Kerja (Tanggal Awal)",
                                  )),
                              const SizedBox(height: 16),

                              Obx(() => Text(
                                    "Durasi kerja: ${pengalamanPeriode.value} bulan",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                  )),
                              const SizedBox(height: 16),
                              TextButton.icon(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  tambahInputPengalaman();
                                },
                                label: Text("Tambah Pengalaman Baru"),
                              ),
                              const SizedBox(height: 16),
                              Obx(
                                () => Column(
                                  children: List.generate(pengalamanList.length,
                                      (index) {
                                    final pengalaman = pengalamanList[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(),
                                        const SizedBox(height: 16),
                                        Text(
                                          "${pengalaman["jabatan"]} di ${pengalaman["instansi"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Mulai : ${DateFormat("MMMM yyyy", "id_ID").format(pengalaman["mulai_kerja"])}",
                                        ),
                                        Text(
                                            "Durasi : ${pengalaman["durasi_bulan"]} bulan"),
                                        TextButton.icon(
                                          icon: Icon(Icons.delete_outline),
                                          onPressed: () =>
                                              hapusPengalaman(index),
                                          label: Text("Hapus Pengalaman"),
                                        ),
                                        Divider(),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                          Obx(() => pengalamanList.length == 0
                              ? Divider()
                              : SizedBox.shrink()),

                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Sosial Media"),
                              const SizedBox(height: 12),
                              Obx(() => AllMaterial.buildDropdown(
                                    items: daftarMediaSosial,
                                    selectedValue: sosmed.value,
                                    onChanged: (p0) {
                                      sosmed.value = p0 ?? "";
                                    },
                                    isDarkMode: AllMaterial.isDarkMode.value,
                                    hintText: "Akun Sosial Media",
                                  )),
                              const SizedBox(height: 16),
                              Obx(
                                () => AllMaterial.textField(
                                  controller: sosmedC,
                                  errorText: sosmedError.isEmpty
                                      ? null
                                      : sosmedError.value,
                                  isVerif: true,
                                  labelText: "URL Sosial Media",
                                  onChanged: (val) => sosmedUrl.value = val,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextButton.icon(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  tambahSosialMedia();
                                },
                                label: Text("Tambah Sosial Media"),
                              ),
                              const SizedBox(height: 24),
                              Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: sosialMediaList.map((item) {
                                    final index = sosialMediaList.indexOf(item);
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${item['tipe']}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${item['url'] ?? '-'}",
                                        ),
                                        TextButton.icon(
                                          icon: Icon(Icons.delete_outline),
                                          onPressed: () =>
                                              sosialMediaList.removeAt(index),
                                          label: Text("Hapus"),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => sosialMediaList.length == 0
                                ? Divider()
                                : SizedBox.shrink(),
                          ),
                          const SizedBox(height: 12),
                          // Rekening Section
                          const Text("Informasi Rekening"),
                          const SizedBox(height: 8),
                          AllMaterial.textField(
                            isVerif: true,
                            controller: namaRekeningC,
                            errorText: namaRekeningError.isEmpty
                                ? null
                                : namaRekeningError.value,
                            labelText: "Nama Pemilik Rekening",
                            onChanged: (val) => rekeningNama.value = val,
                          ),
                          const SizedBox(height: 12),
                          AllMaterial.textField(
                            controller: nomorRekeningC,
                            errorText: nomorRekeningError.isEmpty
                                ? null
                                : nomorRekeningError.value,
                            isVerif: true,
                            labelText: "Nomor Rekening",
                            onChanged: (val) => rekeningNomor.value = val,
                          ),
                          const SizedBox(height: 12),
                          Obx(
                            () => AllMaterial.buildDropdown(
                              items: daftarBankMidtrans,
                              selectedValue: rekeningBank.value.isNotEmpty
                                  ? rekeningBank.value
                                  : null,
                              onChanged: (val) {
                                if (val != null) rekeningBank.value = val;
                              },
                              isDarkMode: AllMaterial.isDarkMode.value,
                              hintText: "Nama Bank",
                            ),
                          ),

                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => missingFields.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Lengkapi data berikut:\n${missingFields.join(', ')}",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),

                  AllMaterial.cusButton(
                    label: "Ajukan Verifikasi",
                    addIcon: true,
                    icon: Icon(Icons.check, color: AllMaterial.colorWhite),
                    onTap: missingFields.isNotEmpty
                        ? null
                        : () {
                            missingFields.clear();
                            if (namaLengkap.value.isEmpty) {
                              missingFields.add("Nama Lengkap");
                              namaUserError.value = "Nama Lengkap wajib diisi";
                            }
                            if (provinsi.value.isEmpty)
                              missingFields.add("Provinsi");
                            if (kabupaten.value.isEmpty)
                              missingFields.add("Kabupaten");
                            if (kecamatan.value.isEmpty)
                              missingFields.add("Kecamatan");
                            if (kelurahan.value.isEmpty)
                              missingFields.add("Kelurahan");
                            if (domisili.value.isEmpty)
                              missingFields.add("Domisili");
                            if (fotoSelfieDenganIdentitas.value == null)
                              missingFields.add("Foto Selfie dengan Identitas");
                            if (rekeningNama.value.isEmpty) {
                              missingFields.add("Nama di Rekening");
                              namaRekeningError.value =
                                  "Nama Rekening wajib diisi";
                            }
                            if (rekeningNomor.value.isEmpty) {
                              nomorRekeningError.value =
                                  "Nomor Rekening wajib diisi";
                              missingFields.add("Nomor Rekening");
                            }

                            if (missingFields.isNotEmpty) return;
                            update();

                            AllMaterial.showLoadingDialog();

                            Future.delayed(const Duration(seconds: 2), () {
                              Get.back();
                              Get.back();
                              ToastService.show(
                                "Data berhasil dikirim, tunggu verifikasi dari Admin",
                              );
                            });
                          },
                  ),
                  // SizedBox(height: 16),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 8.0),
                  //   child: Text(
                  //     "*Admin akan meninjau data Anda. Setelah verifikasi selesai, Anda bisa langsung menikmati semua fitur.",
                  //     style: TextStyle(
                  //       color: Theme.of(context).hintColor,
                  //     ),
                  //   ),
                  // ),

                  SizedBox(height: context.mediaQueryPadding.bottom / 2),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
