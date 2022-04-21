import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/custom_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/medical_record/documents/documents_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/others/screen_utils.dart';
import '../../../custom_widgets/custom_text_field.dart';

class DocuemntScreen extends StatelessWidget {
  final AppUser? appUser;
  const DocuemntScreen({Key? key, this.appUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DocumentsViewModel(appUser: appUser),
      child: Consumer<DocumentsViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              body: CustomScreen(
                title: 'Documents & Reports',
                body: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Row(
                                          children: [
                                            Text('${model.images[index].title}',
                                                style:
                                                    subHeadingTextStyleRoboto),
                                            appUser == null
                                                ? Row(
                                                    children: [
                                                      SizedBox(width: 10.w),
                                                      GestureDetector(
                                                        onTap: () {
                                                          model.deleteDocument(
                                                              model.images[
                                                                  index]);
                                                        },
                                                        child: const Icon(
                                                            Icons.delete,
                                                            size: 20,
                                                            color:
                                                                primaryColor),
                                                      )
                                                    ],
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 12.h),
                                      model.images[index].url != null
                                          ? Image.network(
                                              model.images[index].url!,
                                              height: 120.h,
                                              width: 0.35.sw,
                                              fit: BoxFit.cover)
                                          : Container(),
                                    ]),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
              floatingActionButton: appUser != null
                  ? Container()
                  : FloatingActionButton(
                      onPressed: () async {
                        Get.dialog(CustomDialog());
                      },
                      child: Container(
                        child: const Center(
                            child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        )),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: primaryColor),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DocumentsViewModel>(
      builder: (context, model, child) {
        return AlertDialog(
          title: Text('Upload Document', style: headingTextStyleRoboto),
          content: SizedBox(
              height: 0.3.sh,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// email text field
                    Text(
                      'Document title',
                      style: bodyTextStyleRoboto.copyWith(fontSize: 14.sp),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      fillColor: const Color(0xFFEBEBEB),
                      onChange: (value) {
                        model.documents.title = value;
                      },
                      inputType: TextInputType.emailAddress,
                      disableBorder: true,
                    ),
                    SizedBox(height: 25.h),
                    Container(
                      height: 0.15.sh,
                      width: 1.sw,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 3,
                                spreadRadius: 1),
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: model.image != null
                              ? Image.file(
                                  model.image!,
                                  fit: BoxFit.cover,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: const Icon(Icons.upload),
                                        onPressed: () {
                                          model.getImage();
                                        }),
                                    Text('Upload', style: bodyTextStyleRoboto)
                                  ],
                                )),
                    )
                  ])),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor)),
              onPressed: () {
                model.addDocument();
              },
              child: Text(
                'Upload',
                style: bodyTextStyleRoboto,
              ),
            ),
          ],
        );
      },
    );
  }
}
