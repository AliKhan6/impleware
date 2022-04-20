import 'package:calkitna_mobile_app/core/constants/strings.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/ui/pharmacist/home/phar_home_view_model.dart';
import 'package:calkitna_mobile_app/ui/pharmacist/user-details/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../core/models/app_user.dart';
import '../../../core/others/screen_utils.dart';

class PharHomeScreen extends StatefulWidget {
  const PharHomeScreen({Key? key}) : super(key: key);

  @override
  State<PharHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PharHomeScreen>
    with TickerProviderStateMixin {
  final _advancedDrawerController = AdvancedDrawerController();

  AnimationController? animationController;
  bool isDrawerOpened = false;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  toggleAnimation() {
    if (animationController!.isDismissed) {
      isDrawerOpened = true;
      animationController!.forward();
    } else {
      animationController!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PharHomeViewModel(),
      child: Consumer<PharHomeViewModel>(
        builder: (context, model, child) {
          return GestureDetector(
            onTap: () {
              // if (isDrawerOpened) {
              //   toggleAnimation();
              // }
            },
            child: ModalProgressHUD(
              inAsyncCall: model.state == ViewState.busy,
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(children: [
                    SizedBox(height: 70.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              // toggleAnimation();
                              // _advancedDrawerController.showDrawer();
                              // _advancedDrawerController.value =
                              //     AdvancedDrawerValue.visible();
                              // if (_advancedDrawerController.value.visible ==
                              //     false) {
                              //   _advancedDrawerController.showDrawer();
                              //   setState(() {});
                              // }
                            },
                            icon: Image.asset('$staticAsset/drawer.png',
                                height: 25.h, width: 40.w)),
                        IconButton(
                          onPressed: () {
                            model.logout();
                          },
                          icon: const Icon(Icons.logout),
                        )
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Center(
                      child: Text(
                        'Welcome ${model.authService.pharmacist.name}',
                        style: bodyTextStyleRoboto.copyWith(fontSize: 24.sp),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ///
                    /// search field
                    ///
                    searchField(model),
                    SizedBox(height: 30.h),

                    ///
                    /// Users list view
                    ///
                    model.searchedList.isEmpty
                        ? usersList(model.users)
                        : usersList(model.searchedList),
                    SizedBox(height: 30.h)
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  usersList(List<AppUser> users) {
    return Expanded(
        child: ListView.builder(
            itemCount: users.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => UserDetailScreen(users[index]));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 3,
                            spreadRadius: 1),
                      ],
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: users[index].imageUrl == null
                          ? CircleAvatar(
                              backgroundImage:
                                  const AssetImage('$staticAsset/profile.jpg'),
                              radius: 25.r)
                          : CircleAvatar(
                              backgroundImage:
                                  NetworkImage(users[index].imageUrl!),
                              radius: 25.r),
                      title: Text('${users[index].name}',
                          style: subHeadingTextStyleRoboto),
                      subtitle: Text('${users[index].email}',
                          style: bodyTextStyleRoboto),
                    ),
                  ),
                ),
              );
            }));
  }

  searchField(PharHomeViewModel model) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 3,
            spreadRadius: 1),
      ]),
      child: TextFormField(
        onChanged: (value) {
          model.searching(value);
        },
        decoration: InputDecoration(
            suffixIcon: const Icon(Icons.search, size: 20),
            contentPadding: const EdgeInsets.only(left: 5, top: 10),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: bodyTextStyleRoboto.copyWith(fontSize: 15.sp)),
      ),
    );
  }
}
