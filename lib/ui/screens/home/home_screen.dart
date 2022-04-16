import 'package:calkitna_mobile_app/core/constants/strings.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/image_container.dart';
import 'package:calkitna_mobile_app/ui/screens/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../core/models/home.dart';
import '../../../core/others/screen_utils.dart';
import '../drawer/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) {
          return AdvancedDrawer(
              backdropColor: Colors.white,
              controller: _advancedDrawerController,
              rtlOpening: Get.locale?.languageCode == 'ar',
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 300),
              animateChildDecoration: true,
              disabledGestures: false,
              drawer: const DrawerScreen(),
              child: GestureDetector(
                onTap: () {
                  if (isDrawerOpened) {
                    toggleAnimation();
                  }
                },
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
                                toggleAnimation();
                                _advancedDrawerController.showDrawer();
                                _advancedDrawerController.value =
                                    AdvancedDrawerValue.visible();
                                if (_advancedDrawerController.value.visible ==
                                    false) {
                                  _advancedDrawerController.showDrawer();
                                  setState(() {});
                                }
                              },
                              icon: Image.asset('$staticAsset/drawer.png',
                                  height: 25.h, width: 40.w)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.notifications))
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Center(
                        child: Text(
                          'Welcome ${model.authService.appUser.name}',
                          style: bodyTextStyleRoboto.copyWith(fontSize: 24.sp),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      ///
                      /// search field
                      ///
                      searchField(model),

                      ///
                      /// grid view
                      ///
                      model.searchedList.isEmpty
                          ? gridView(model.homeData)
                          : gridView(model.searchedList),
                      SizedBox(height: 30.h)
                    ]),
                  ),
                ),
              ));
        },
      ),
    );
  }

  gridView(List<HomeData> list) {
    return Expanded(
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4),
              child: GestureDetector(
                onTap: list[index].onTap,
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
                            assetImage: '${list[index].image}',
                            height: 65.h,
                            width: 45.w),
                        SizedBox(height: 8.h),
                        Text(
                          '${list[index].title}',
                          style: bodyTextStyleRoboto,
                        )
                      ]),
                ),
              ),
            );
          }),
    );
  }

  searchField(HomeViewModel model) {
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
