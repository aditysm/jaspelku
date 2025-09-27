import 'package:get/get.dart';

class SyaratKetentuanController extends GetxController {
  final List<Map<String, dynamic>> syaratKetentuanData = [
    {
      'title': '1. Definisi Umum',
      'items': [
        {
          'subtitle': 'Jaspelku',
          'content':
              'Merupakan platform ekosistem digital yang menghubungkan antara penyedia jasa (Servant) dan pengguna jasa (Vendee) dalam satu lingkungan layanan yang cepat, aman, dan terpercaya.',
        },
        {
          'subtitle': 'Servant',
          'content':
              'Individu atau entitas yang menawarkan jasa melalui platform Jaspelku.',
        },
        {
          'subtitle': 'Vendee',
          'content':
              'Individu atau entitas yang menggunakan jasa dari Servant dalam platform Jaspelku.',
        },
      ],
    },
    {
      'title': '2. Pembayaran & Transaksi',
      'items': [
        {
          'subtitle': 'Metode Pembayaran',
          'content':
              'Pembayaran dilakukan melalui metode yang tersedia dalam aplikasi seperti e-wallet, transfer bank, atau metode lain yang disediakan oleh Jaspelku.',
        },
        {
          'subtitle': 'Keamanan Transaksi',
          'content':
              'Semua transaksi dienkripsi dan diproses melalui sistem yang aman untuk menjaga privasi dan keamanan pengguna.',
        },
        {
          'subtitle': 'Kebijakan Pengembalian Dana',
          'content':
              'Pengajuan pengembalian dana dapat dilakukan sesuai dengan syarat dan prosedur yang berlaku di dalam aplikasi.',
        },
      ],
    },
    {
      'title': '3. Penggunaan Lokasi (GPS)',
      'items': [
        {
          'subtitle': 'Akses Lokasi',
          'content':
              'Aplikasi dapat meminta akses lokasi pengguna untuk menyediakan layanan berbasis lokasi, seperti pencarian Servant terdekat.',
        },
        {
          'subtitle': 'Kerahasiaan Lokasi',
          'content':
              'Data lokasi hanya digunakan untuk keperluan operasional layanan dan tidak dibagikan ke pihak ketiga tanpa izin pengguna.',
        },
      ],
    },
    {
      'title': '4. Pengumpulan dan Penggunaan Data',
      'items': [
        {
          'subtitle': 'Jenis Data yang Dikumpulkan',
          'content':
              'Data seperti nama, nomor telepon, alamat, lokasi, dan preferensi layanan digunakan untuk meningkatkan pengalaman pengguna.',
        },
        {
          'subtitle': 'Tujuan Penggunaan',
          'content':
              'Data hanya digunakan untuk keperluan internal dan pelayanan, serta tidak dibagikan ke pihak ketiga tanpa persetujuan pengguna.',
        },
      ],
    },
    {
      'title': '5. Hak dan Kewajiban Pengguna',
      'items': [
        {
          'subtitle': 'Kewajiban Servant',
          'content':
              'Servant wajib memberikan informasi layanan yang jelas, jujur, dan melayani sesuai standar yang ditentukan.',
        },
        {
          'subtitle': 'Kewajiban Vendee',
          'content':
              'Vendee wajib menghargai waktu, ketentuan, dan hasil kerja Servant serta tidak melakukan penipuan atau manipulasi.',
        },
      ],
    },
    {
      'title': '6. Media dan Konten Pengguna',
      'items': [
        {
          'subtitle': 'Unggahan Media',
          'content':
              'Pengguna dapat mengunggah gambar atau file sesuai kebutuhan layanan, dengan syarat tidak melanggar hukum atau norma yang berlaku.',
        },
        {
          'subtitle': 'Pemeliharaan Media',
          'content':
              'Jaspelku tidak bertanggung jawab atas kerusakan atau kehilangan media yang diunggah dan berhak menghapus konten yang melanggar ketentuan.',
        },
      ],
    },
    {
      'title': '7. Inklusifitas dan Aksesibilitas',
      'items': [
        {
          'subtitle': 'Tanpa Diskriminasi',
          'content':
              'Semua pengguna memiliki hak yang sama dalam mengakses dan menggunakan layanan tanpa diskriminasi gender, usia, atau latar belakang.',
        },
        {
          'subtitle': 'Kemudahan Akses',
          'content':
              'Jaspelku dirancang agar mudah diakses oleh semua kalangan termasuk pengguna difabel.',
        },
      ],
    },
    {
      'title': '8. Keamanan dan Kerahasiaan',
      'items': [
        {
          'subtitle': 'Perlindungan Data',
          'content':
              'Kami menggunakan standar keamanan tinggi untuk melindungi data pribadi pengguna dari penyalahgunaan.',
        },
        {
          'subtitle': 'Tanggung Jawab Pengguna',
          'content':
              'Pengguna bertanggung jawab menjaga kerahasiaan informasi login dan perangkat pribadi mereka.',
        },
      ],
    },
    {
      'title': '9. Event, Promo & Komunikasi',
      'items': [
        {
          'subtitle': 'Penawaran Khusus',
          'content':
              'Jaspelku dapat memberikan promo, diskon, atau event khusus yang berlaku dalam jangka waktu tertentu.',
        },
        {
          'subtitle': 'Informasi Komunikasi',
          'content':
              'Informasi tentang promo dan event akan dikirimkan melalui notifikasi dalam aplikasi atau email.',
        },
      ],
    },
    {
      'title': '10. Perubahan, Update & Pemeliharaan Sistem',
      'items': [
        {
          'subtitle': 'Pengembangan Platform',
          'content':
              'Kami dapat mengubah fitur, konten, dan struktur layanan untuk meningkatkan kualitas platform.',
        },
        {
          'subtitle': 'Pemeliharaan Sistem',
          'content':
              'Aplikasi dapat mengalami downtime selama proses pemeliharaan sistem, dan pengguna akan diberi pemberitahuan sebelumnya jika memungkinkan.',
        },
        {
          'subtitle': 'Pemberitahuan Update',
          'content':
              'Perubahan signifikan akan diinformasikan melalui aplikasi atau email pengguna.',
        },
      ],
    },
    {
      'title': '11. Pengalaman Pengguna',
      'items': [
        {
          'subtitle': 'Umpan Balik',
          'content':
              'Kami terbuka terhadap saran dan masukan pengguna untuk terus meningkatkan kualitas layanan.',
        },
        {
          'subtitle': 'Peningkatan Berkelanjutan',
          'content':
              'Pengalaman pengguna akan terus ditingkatkan berdasarkan analisa interaksi dan kebutuhan lapangan.',
        },
      ],
    },
    {
      'title': '12. Akses Akun & Kepemilikan',
      'items': [
        {
          'subtitle': 'Pembuatan Akun',
          'content':
              'Pengguna wajib membuat akun dengan data yang benar dan dapat dipertanggungjawabkan.',
        },
        {
          'subtitle': 'Kepemilikan',
          'content':
              'Setiap akun bersifat pribadi. Pengguna bertanggung jawab penuh terhadap semua aktivitas yang dilakukan melalui akun tersebut.',
        },
      ],
    },
    {
      'title': '13. Penangguhan dan Penghentian Akun',
      'items': [
        {
          'subtitle': 'Pelanggaran Ketentuan',
          'content':
              'Akun dapat ditangguhkan atau dihentikan jika melanggar kebijakan, merugikan pengguna lain, atau melakukan aktivitas ilegal.',
        },
        {
          'subtitle': 'Hak Peninjauan Kembali',
          'content':
              'Pengguna berhak mengajukan banding atau klarifikasi atas penonaktifan akun.',
        },
      ],
    },
    {
      'title': '14. Persetujuan',
      'items': [
        {
          'subtitle': 'Penerimaan Ketentuan',
          'content':
              'Dengan mendaftar atau menggunakan Jaspelku, pengguna menyatakan setuju dan tunduk pada seluruh syarat dan ketentuan ini.',
        },
      ],
    },
  ];
}
