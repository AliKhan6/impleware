import 'package:calkitna_mobile_app/core/constants/strings.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/ui/screens/drawer/drawer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DrawerViewModel(),
      child: Consumer<DrawerViewModel>(builder: (context, model, child) {
        return Drawer(
          backgroundColor: Colors.white,
          elevation: 0.0,
          child: Column(
            children: [
              SizedBox(height: 90.h),
              model.authService.appUser.imageUrl == null
                  ? CircleAvatar(
                      backgroundImage:
                          const AssetImage('$staticAsset/profile.jpg'),
                      radius: 45.r)
                  : CircleAvatar(
                      backgroundImage:
                          NetworkImage(model.authService.appUser.imageUrl!),
                      radius: 45.r),
              SizedBox(height: 10.h),
              Text(
                '${model.authService.appUser.name}',
                style: subHeadingTextStyleRoboto.copyWith(fontSize: 20.sp),
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        // Get.off(() => const HomeScreen());
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.home),
                          SizedBox(width: 10.w),
                          Text(
                            'Home',
                            style: bodyTextStyleRoboto,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    const Divider(),

                    ///
                    /// notificaiton
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(Icons.notifications),
                          SizedBox(width: 10.w),
                          Text(
                            'Notifications',
                            style: bodyTextStyleRoboto,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    const Divider(),

                    ///
                    /// notificaiton
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          SizedBox(width: 10.w),
                          Text(
                            'Profile',
                            style: bodyTextStyleRoboto,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    const Divider(),

                    ///
                    /// notificaiton
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(Icons.logout),
                          SizedBox(width: 10.w),
                          Text(
                            'Logout',
                            style: bodyTextStyleRoboto,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    const Divider(),

                    ///
                    /// notificaiton
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(Icons.settings),
                          SizedBox(width: 10.w),
                          Text(
                            'Settings',
                            style: bodyTextStyleRoboto,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    const Divider()
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
