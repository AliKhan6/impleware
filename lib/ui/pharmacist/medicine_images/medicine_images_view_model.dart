import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/models/medicine_images.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';

class MedicineImagesViewModel extends BaseViewModel {
  final _dbService = DatabaseService();
  List<MedicineImages> images = [];
  AppUser appUser = AppUser();

  MedicineImagesViewModel(this.appUser) {
    getImages();
  }

  getImages() async {
    setState(ViewState.busy);
    images = await _dbService.getMedicineImages(appUser.id!);
    setState(ViewState.idle);
  }
}
