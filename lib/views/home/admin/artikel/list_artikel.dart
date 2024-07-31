import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/home/article/article_provider.dart';
import 'package:refac/views/component/constant/app_theme.dart';
import 'package:refac/views/component/custom_button.dart';

class ListArtikelPage extends ConsumerWidget {
  const ListArtikelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleProvAsync = ref.watch(getAllArticle);
    final articleProv = ref.watch(articleProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'List Article',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: articleProvAsync.when(
            data: (data) {
              return ListView.builder(
                itemCount: data.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: RefacTheme().mainColor, width: 3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                data.data[index].title!,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(
                                              'Yakin ingin menghapus Article?'),
                                          actions: [
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    width: 80.w,
                                                    child: customButton(
                                                        RefacTheme().mainColor,
                                                        Text(
                                                          'Tidak',
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  ),
                                                  Container(
                                                    width: 80.w,
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        try {
                                                          articleProv
                                                              .deleteArticle(
                                                                  data
                                                                      .data[
                                                                          index]
                                                                      .id!);
                                                          ref.refresh(
                                                              getAllArticle
                                                                  .future);
                                                          Navigator.pop(
                                                              context);
                                                        } catch (e) {
                                                          print('Error : $e');
                                                        }
                                                      },
                                                      child: customButton(
                                                          Colors.redAccent,
                                                          Text(
                                                            'Yakin',
                                                            style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(Icons.delete_forever))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            error: (error, stackTrace) {
              return Center(
                child: Text('Error : $error'),
              );
            },
            loading: () {
              return Center(child: const CircularProgressIndicator());
            },
          ),
        ));
  }
}
