import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/models/chat.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/database_service.dart';
import '../../../locator.dart';

class PharChatViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final dbService = locator<DatabaseService>();
  late Stream messagesStream;
  Chat msgToBeSent = Chat();
  final controller = TextEditingController();
  List<Chat> messagesList = [];
  List<Chat> reverseMessagesList = [];

  PharChatViewModel(String stylistId) {
    getChatMessges(stylistId);
  }

  ///
  /// Get messages from db
  getChatMessges(String stylistId) {
    setState(ViewState.busy);
    messagesStream =
        dbService.getMessagesStream(authService.pharmacist.id!, stylistId);
    messagesStream.listen((event) {
      debugPrint('getMessgesStream');
      debugPrint(event.snapshot.value.toString());
      Chat message =
          Chat.fromJson(Map<String, dynamic>.from(event.snapshot.value));
      messagesList.add(message);
      reverseMessagesList = messagesList.reversed.toList();
      notifyListeners();
    });

    msgToBeSent = Chat();
    // print('conversationList => ${conversationList.length}');
    setState(ViewState.idle);
  }

  ///
  /// Send message to db
  sendMessage(AppUser stylistUser) async {
    setState(ViewState.busy);
    msgToBeSent.createdAt = DateTime.now().toString();
    msgToBeSent.userId = stylistUser.id;
    msgToBeSent.isPharmacist = true;
    msgToBeSent.isUser = false;
    msgToBeSent.userName = stylistUser.name;
    msgToBeSent.pharmacistName = authService.pharmacist.name;
    msgToBeSent.userUrl = stylistUser.imageUrl;
    msgToBeSent.pharmacistUrl = authService.pharmacist.imageUrl;
    msgToBeSent.message = controller.text;
    msgToBeSent.pharmacistId = authService.pharmacist.id;
    DateTime time = DateFormat('yyyy-mm-dd HH:mm:s')
        .parse(DateTime.now().toString())
        .toLocal();
    msgToBeSent.formattedTime = DateFormat('HH:mm a').format(time);
    debugPrint('FormattedTime => ${msgToBeSent.formattedTime}');
    await dbService.sendMessage(msgToBeSent);
    controller.clear();
    msgToBeSent = Chat();
    setState(ViewState.idle);
  }
}
