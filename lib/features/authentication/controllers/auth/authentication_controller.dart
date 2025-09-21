import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  final GetStorage _storage = GetStorage(); // <-- pas de init ici

  final RxBool _isFirstTime = true.obs;
  final RxBool _isLoggedIn = false.obs;

  bool get isFirstTime => _isFirstTime.value;
  bool get isLoggedIn => _isLoggedIn.value;

  @override
  void onInit() {
    super.onInit();
    _loadInitialState(); // lecture directe (storage déjà prêt)
  }

  void _loadInitialState() {
    _isFirstTime.value = _storage.read('isFirstTime') ?? true;
    _isLoggedIn.value = _storage.read('isLoggedIn') ?? false;
  }

  Future<void> setFirstTimeDone() async {
    _isFirstTime.value = false;
    await _storage.write('isFirstTime', false);
  }

  Future<void> login() async {
    _isLoggedIn.value = true;
    await _storage.write('isLoggedIn', true);
  }

  Future<void> logout() async {
    _isLoggedIn.value = false;
    await _storage.write('isLoggedIn', false);
  }
}
