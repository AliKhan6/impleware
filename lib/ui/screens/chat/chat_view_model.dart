import 'package:calkitna_mobile_app/core/models/pharmacist.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../locator.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/models/chat.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/database_service.dart';
import '../../../core/view_models.dart/base_view_model.dart';

class ChatViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final dbService = locator<DatabaseService>();
  late Stream messagesStream;
  Chat msgToBeSent = Chat();
  final controller = TextEditingController();
  List<Chat> messagesList = [];
  List<Chat> reverseMessagesList = [];

  ChatViewModel(String stylistId) {
    getChatMessges(stylistId);
  }

  ///
  /// Get messages from db
  getChatMessges(String stylistId) {
    setState(ViewState.busy);
    messagesStream =
        dbService.getMessagesStream(stylistId, authService.appUser.id!);
    messagesStream.listen((event) {
      print('getMessgesStream');
      print(event.snapshot.value.toString());
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
  sendMessage(Pharmacist stylistUser) async {
    setState(ViewState.busy);
    msgToBeSent.createdAt = DateTime.now().toString();
    msgToBeSent.userId = authService.appUser.id;
    msgToBeSent.message = controller.text;
    msgToBeSent.userName = authService.appUser.name;
    msgToBeSent.pharmacistName = stylistUser.name;
    msgToBeSent.userUrl = authService.appUser.imageUrl;
    msgToBeSent.pharmacistUrl = stylistUser.imageUrl;
    msgToBeSent.message = controller.text;
    msgToBeSent.pharmacistId = stylistUser.id;
    DateTime time = DateFormat('yyyy-mm-dd HH:mm:s')
        .parse(DateTime.now().toString())
        .toLocal();
    if (time != null) {
      msgToBeSent.formattedTime = DateFormat('HH:mm a').format(time);
      print('FormattedTime => ${msgToBeSent.formattedTime}');
    }
    await dbService.sendMessage(msgToBeSent);
    controller.clear();
    msgToBeSent = Chat();
    setState(ViewState.idle);
  }
}
