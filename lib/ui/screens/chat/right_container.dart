import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/models/chat.dart';
import 'package:flutter/material.dart';

class MessengerTextRight extends StatelessWidget {
  final Chat? message;

  MessengerTextRight({this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 3,
                child: Material(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        Text(message!.message ?? '',
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsetsDirectional.only(start: 60, end: 7, top: 5),
            child: Text(
              message!.formattedTime ?? ' ',
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  fontStyle: FontStyle.normal),
            ),
          ),
        ],
      ),
    );
  }
}

class MessengerTextLeft extends StatelessWidget {
  final Chat? message;

  MessengerTextLeft({this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Flexible(
                flex: 3,
                child: Material(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(message!.message ?? '',
                        style: const TextStyle(color: Colors.black)),
                  ),
                ),
              ),
              Flexible(flex: 1, child: Container()),
            ],
          ),
          Padding(
            padding:
                const EdgeInsetsDirectional.only(end: 60, start: 8, top: 5.0),
            child: Text(
              message!.formattedTime ?? '',
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  fontStyle: FontStyle.normal),
            ),
          ),
        ],
      ),
    );
  }
}
