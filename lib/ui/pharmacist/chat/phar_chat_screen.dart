import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_app_bar.dart';
import 'package:calkitna_mobile_app/ui/pharmacist/chat/phar_chat_view_model.dart';
import 'package:calkitna_mobile_app/ui/screens/chat/right_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PharChatScreen extends StatefulWidget {
  final AppUser? stylistUser;
  const PharChatScreen({this.stylistUser});

  @override
  _CustomerConversationScreenState createState() =>
      _CustomerConversationScreenState();
}

class _CustomerConversationScreenState extends State<PharChatScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PharChatViewModel(widget.stylistUser!.id!),
      child: Consumer<PharChatViewModel>(builder: (context, model, child) {
        return Scaffold(
            body: Column(
          children: <Widget>[
            SizedBox(height: 70.h),
            customAppBar(widget.stylistUser!.name ?? ''),
            chatMessages(model),
            sendMessageContainer(model), // The input widget
          ],
        ));
      }),
    );
  }

  sendMessageContainer(PharChatViewModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: <Widget>[
          // Text input
          Flexible(
            child: TextFormField(
              style: const TextStyle(color: Colors.black, fontSize: 15.0),
              controller: model.controller,
              decoration: const InputDecoration.collapsed(
                hintText: 'Type a message',
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Send Message Button
          Material(
            color: Colors.grey.withOpacity(0.2),
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                if (model.controller.text.isNotEmpty) {
                  model.sendMessage(widget.stylistUser!);
                }
              },
            ),
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        border: const Border(top: BorderSide(color: Colors.grey)),
        color: Colors.grey.withOpacity(0.2),
      ),
    );
  }

  chatMessages(PharChatViewModel model) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 66.0, bottom: 16.0),
        reverse: true,
        itemCount: model.reverseMessagesList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          bool isMe = 
              model.reverseMessagesList[index].isPharmacist == true;
          debugPrint('isMe: $isMe');
          return isMe
              ? MessengerTextRight(message: model.reverseMessagesList[index])
              : MessengerTextLeft(message: model.reverseMessagesList[index]);
        },
      ),
    );
  }
}
