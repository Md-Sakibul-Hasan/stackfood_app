import 'package:get/get.dart';
import 'package:stackfood_app/app/data/models/config_model.dart';
import 'package:stackfood_app/app/data/services/api_service.dart';

class ConfigController extends GetxController {
  final ApiService _apiService = ApiService();

  final Rx<ConfigModel?> config = Rx<ConfigModel?>(null);

  String get businessImageUrl => config.value?.baseUrl ?? '';

  @override
  void onInit() {
    super.onInit();
    fetchConfig();
  }

  Future<void> fetchConfig() async {
    try {
      final result = await _apiService.getConfig();
      if (result != null) {
        config.value = result;
      }
    } catch (e) {
      print('Error in ConfigController: $e');
    }
  }

  @override
  void onClose() {
    _apiService.dispose();
    super.onClose();
  }
}
