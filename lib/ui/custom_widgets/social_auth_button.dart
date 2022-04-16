import 'package:calkitna_mobile_app/core/others/screen_utils.dart';
import 'package:flutter/material.dart';
import 'image_container.dart';

class SocialAuthButton extends StatelessWidget {
  final String? image;
  final onTap;
  const SocialAuthButton({Key? key, this.image, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 47.h,
          child: UnconstrainedBox(
            child: ImageContainer(assetImage: image, height: 39.h, width: 39.w),
          ),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD9D8D7), width: 1.5),
              borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
