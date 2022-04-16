import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_button.dart';
import 'package:calkitna_mobile_app/ui/screens/auth_screens/signup/signup_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/onboarding/onboarding_view_model.dart';
import 'package:calkitna_mobile_app/ui/screens/starting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingViewModel(),
      child: Consumer<OnboardingViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: SizedBox(
              height: 1.sh,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: model.onboardController,
                    itemCount: model.onboardings.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ///
                          /// Top images
                          ///
                          SizedBox(
                            height: 0.5.sh,
                            child: Center(
                                child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        '${model.onboardings[index].image}'),
                                    radius: 100)

                                // ImageContainer(
                                //   assetImage: '${model.onboardings[index].image}',
                                //   height: index == 0
                                //       ? 394.h
                                //       : index == 1
                                //           ? 268.h
                                //           : 290.h,
                                //   fit: index == 2 ? BoxFit.contain : BoxFit.cover,
                                // ),
                                ),
                          ),

                          ///
                          /// Onboarding details and next previous buttons
                          ///
                          onboardingDetailsAndButtons(model, index),
                        ],
                      );
                    },
                    onPageChanged: (int index) {
                      debugPrint(index.toString());
                      model.setCurrentPageIndex(index);
                    },
                  ),

                  ///
                  /// Dots indicators
                  ///
                  Positioned(
                    top: 1.sh - 270.h,
                    left: 0.42.sw,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 15.h,
                            width: 1.sw,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: model.onboardings.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 7.0),
                                    child: Container(
                                      width: 15.w,
                                      height: 15.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: index == model.currentIndexPage
                                              ? model
                                                  .onboardings[
                                                      model.currentIndexPage!]
                                                  .buttonColor
                                              : model
                                                  .onboardings[
                                                      model.currentIndexPage!]
                                                  .buttonColor!
                                                  .withOpacity(0.3)),
                                    ),
                                  );
                                })),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  onboardingDetailsAndButtons(OnboardingViewModel model, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          Text('${model.onboardings[index].title}',
              style: subHeadingTextStyleRoboto.copyWith(
                  color: model.onboardings[index].buttonColor, fontSize: 24.sp),
              textAlign: TextAlign.center),
          SizedBox(height: 23.h),
          Text('Its easy and simple',
              style: bodyTextStyleAssistant.copyWith(
                  color: model.onboardings[index].buttonColor, fontSize: 18.sp),
              textAlign: TextAlign.center),
          SizedBox(height: 150.h),
          CustomButton(
            width: index == 2 ? 100.w : 70.w,
            onTap: () {
              index == 2
                  ? Get.offAll(() => const StartingScreen())
                  : model.animateToPage(model.currentIndexPage! + 1);
            },
            buttonColor: model.onboardings[index].buttonColor,
            textColor: Colors.white,
            text: index == 2 ? 'Get Started' : 'NEXT',
          ),
          SizedBox(height: 15.h),
          index == 2
              ? Container()
              : TextButton(
                  onPressed: () {
                    Get.offAll(() => const StartingScreen());
                  },
                  child: Text('SKIP',
                      style: bodyTextStyleRoboto.copyWith(color: blackColor)))
        ],
      ),
    );
  }
}
