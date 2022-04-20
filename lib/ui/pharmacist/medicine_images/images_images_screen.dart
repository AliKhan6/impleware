import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_app_bar.dart';
import 'package:calkitna_mobile_app/ui/pharmacist/medicine_images/medicine_images_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class MedicineImagesScreen extends StatelessWidget {
  final AppUser appUser;
  const MedicineImagesScreen(this.appUser, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MedicineImagesViewModel(appUser),
      child: Consumer<MedicineImagesViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    SizedBox(height: 70.h),
                    customAppBar('Medicine Images'),
                    Expanded(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: model.images.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Container(
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
                                      Image.network(
                                          model.images[index].imageUrl!,
                                          height: 120.h,
                                          width: 0.4.sw,
                                          fit: BoxFit.cover),
                                    ]),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
