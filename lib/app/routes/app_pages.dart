import 'package:get/get.dart';

import '../modules/chat_room/bindings/chat_room_binding.dart';
import '../modules/chat_room/views/chat_room_view.dart';
import '../modules/edit_profil/bindings/edit_profil_binding.dart';
import '../modules/edit_profil/views/edit_profil_view.dart';
import '../modules/event_promo/bindings/event_promo_binding.dart';
import '../modules/event_promo/views/event_promo_view.dart';
import '../modules/histori_pesanan/bindings/histori_pesanan_binding.dart';
import '../modules/histori_pesanan/views/histori_pesanan_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kebijakan_privasi/bindings/kebijakan_privasi_binding.dart';
import '../modules/kebijakan_privasi/views/kebijakan_privasi_view.dart';
import '../modules/layanan/bindings/layanan_binding.dart';
import '../modules/layanan/views/layanan_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main_page/bindings/main_page_binding.dart';
import '../modules/main_page/views/main_page_view.dart';
import '../modules/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/notifikasi/views/notifikasi_view.dart';
import '../modules/pencarian/bindings/pencarian_binding.dart';
import '../modules/pencarian/views/pencarian_view.dart';
import '../modules/pengaturan/bindings/pengaturan_binding.dart';
import '../modules/pengaturan/views/pengaturan_view.dart';
import '../modules/pengaturan_pembayaran/bindings/pengaturan_pembayaran_binding.dart';
import '../modules/pengaturan_pembayaran/views/pengaturan_pembayaran_view.dart';
import '../modules/pengenalan/bindings/pengenalan_binding.dart';
import '../modules/pengenalan/views/pengenalan_view.dart';
import '../modules/pesan/bindings/pesan_binding.dart';
import '../modules/pesan/views/pesan_view.dart';
import '../modules/postingan_baru/bindings/postingan_baru_binding.dart';
import '../modules/postingan_baru/views/postingan_baru_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/register_role/bindings/register_role_binding.dart';
import '../modules/register_role/views/register_role_view.dart';
import '../modules/syarat_ketentuan/bindings/syarat_ketentuan_binding.dart';
import '../modules/syarat_ketentuan/views/syarat_ketentuan_view.dart';
import '../modules/tentang_aplikasi/bindings/tentang_aplikasi_binding.dart';
import '../modules/tentang_aplikasi/views/tentang_aplikasi_view.dart';
import '../modules/verifikasi_akun/bindings/verifikasi_akun_binding.dart';
import '../modules/verifikasi_akun/views/verifikasi_akun_view.dart';
import '../modules/verifikasi_pengguna/bindings/verifikasi_pengguna_binding.dart';
import '../modules/verifikasi_pengguna/views/verifikasi_pengguna_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_ROLE,
      page: () => const RegisterRoleView(),
      binding: RegisterRoleBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_PAGE,
      page: () => const MainPageView(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: _Paths.LAYANAN,
      page: () => const LayananView(),
      binding: LayananBinding(),
    ),
    GetPage(
      name: _Paths.POSTINGAN_BARU,
      page: () => const PostinganBaruView(),
      binding: PostinganBaruBinding(),
    ),
    GetPage(
      name: _Paths.PESAN,
      page: () => const PesanView(),
      binding: PesanBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => const ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN,
      page: () => PengaturanView(),
      binding: PengaturanBinding(),
    ),
    GetPage(
      name: _Paths.PENCARIAN,
      page: () => PencarianView(),
      binding: PencarianBinding(),
    ),
    GetPage(
      name: _Paths.HISTORI_PESANAN,
      page: () => const HistoriPesananView(),
      binding: HistoriPesananBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_ROOM,
      page: () => const ChatRoomView(),
      binding: ChatRoomBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFIL,
      page: () => const EditProfilView(),
      binding: EditProfilBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () => const NotifikasiView(),
      binding: NotifikasiBinding(),
    ),
    GetPage(
      name: _Paths.PENGENALAN,
      page: () => const PengenalanView(),
      binding: PengenalanBinding(),
    ),
    GetPage(
      name: _Paths.SYARAT_KETENTUAN,
      page: () => const SyaratKetentuanView(),
      binding: SyaratKetentuanBinding(),
    ),
    GetPage(
      name: _Paths.KEBIJAKAN_PRIVASI,
      page: () => const KebijakanPrivasiView(),
      binding: KebijakanPrivasiBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN_PEMBAYARAN,
      page: () => const PengaturanPembayaranView(),
      binding: PengaturanPembayaranBinding(),
    ),
    GetPage(
      name: _Paths.TENTANG_APLIKASI,
      page: () => const TentangAplikasiView(),
      binding: TentangAplikasiBinding(),
    ),
    GetPage(
      name: _Paths.EVENT_PROMO,
      page: () => const EventPromoView(),
      binding: EventPromoBinding(),
    ),
    GetPage(
      name: _Paths.VERIFIKASI_PENGGUNA,
      page: () => const VerifikasiPenggunaView(),
      binding: VerifikasiPenggunaBinding(),
    ),
    GetPage(
      name: _Paths.VERIFIKASI_AKUN,
      page: () => const VerifikasiAkunView(),
      binding: VerifikasiAkunBinding(),
    ),
  ];
}
