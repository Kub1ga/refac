import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/auth/auth_provider.dart';
import 'package:refac/state/home/article/article_provider.dart';
import 'package:refac/views/component/constant/app_theme.dart';
import 'package:refac/views/component/custom_button.dart';

class AddArticle extends ConsumerWidget {
  const AddArticle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleProv = ref.watch(articleProvider);
    final titleController = articleProv.titleController;
    final contentController = articleProv.contentController;
    final authProv = ref.watch(authProvider);

    Future<void> submitArticle() async {
      await articleProv.uploadArticle(
          titleController.text, contentController.text, articleProv.image);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Article',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 5,
              ),
              SizedBox(height: 10),
              articleProv.image == null
                  ? Text('No image selected.')
                  : Container(
                      height: 200.h,
                      width: 200.w,
                      child: Image.file(File(articleProv.image!.path))),
              articleProv.image == null
                  ? ElevatedButton(
                      onPressed: articleProv.pickImage,
                      child: Text('Pick Image'),
                    )
                  : const SizedBox.shrink(),
              GestureDetector(
                onTap: () async {
                  authProv.loadingState(true);
                  try {
                    await submitArticle();
                    authProv.loadingState(false);
                  } catch (e) {
                    print(e);
                    authProv.loadingState(false);
                  }
                },
                child: customButton(
                    RefacTheme().mainColor,
                    authProv.isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            'Submit',
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                          )),
              )
              // ElevatedButton(
              //   onPressed: submitArticle,
              //   child: Text('Submit'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
