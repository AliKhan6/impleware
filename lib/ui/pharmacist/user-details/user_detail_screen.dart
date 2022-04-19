import 'package:calkitna_mobile_app/ui/custom_widgets/custom_screen.dart';
import 'package:calkitna_mobile_app/ui/pharmacist/user-details/user_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/others/screen_utils.dart';
import '../../custom_widgets/image_container.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  get bodyTextStyleRoboto => null;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserDetailViewModel(),
      child: Consumer<UserDetailViewModel>(
        builder: (context, model, child) {
          return CustomScreen(
            body: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: model.homeData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4),
                          child: GestureDetector(
                            onTap: model.homeData[index].onTap,
                            child: Container(
                              height: 120.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 3,
                                        spreadRadius: 1),
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ImageContainer(
                                        assetImage:
                                            '${model.homeData[index].image}',
                                        height: 65.h,
                                        width: 45.w),
                                    SizedBox(height: 8.h),
                                    Text(
                                      '${model.homeData[index].title}',
                                      style: bodyTextStyleRoboto,
                                    )
                                  ]),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
