import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/medicine.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/services/notification_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/locator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class MedicationViewModel extends BaseViewModel {
  final _dbService = DatabaseService();
  final _authService = locator<AuthService>();
  List<Medicine> medicines = [];
  final NotificationsService _notificationsService = NotificationsService();

  MedicationViewModel() {
    getAllMedicines();
  }

  getAllMedicines() async {
    setState(ViewState.busy);
    medicines = [];
    medicines = await _dbService.getAllMedicines(_authService.appUser.id!);
    setState(ViewState.idle);
  }

  setReminder(int index) async {
    setState(ViewState.busy);
    medicines[index].isReminderOpen = !medicines[index].isReminderOpen!;
    await _dbService.updateMedicine(_authService.appUser.id!, medicines[index]);

    if (medicines[index].isReminderOpen == true) {
      if (medicines[index].time1 != null) {
        _notificationsService.schedule(
            index,
            'Pill Reminder',
            'Please take ${medicines[index].pill1} doses of ${medicines[index].name}',
            Time(int.parse(medicines[index].time1!.split(':')[0]),
                int.parse(medicines[index].time1!.split(':')[1])));
      }
      if (medicines[index].time2 != null) {
        _notificationsService.schedule(
            index,
            'Pill Reminder',
            'Please take ${medicines[index].pill2} doses of ${medicines[index].name}',
            Time(int.parse(medicines[index].time2!.split(':')[0]),
                int.parse(medicines[index].time2!.split(':')[1])));
      }
      if (medicines[index].time3 != null) {
        _notificationsService.schedule(
            index,
            'Pill Reminder',
            'Please take ${medicines[index].pill3} doses of ${medicines[index].name}',
            Time(int.parse(medicines[index].time3!.split(':')[0]),
                int.parse(medicines[index].time3!.split(':')[1])));
      }
      Get.snackbar('Start Success', 'Notificatoins successfully started',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      _notificationsService.stopNotificaiton(index);
    }
    setState(ViewState.idle);
  }
}
