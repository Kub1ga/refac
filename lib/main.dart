import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/auth/auth_provider.dart';
import 'package:refac/views/auth/login_page.dart';
import 'package:refac/views/home/navbar_home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthProvider authProv = AuthProvider();
  bool? loginStatus = await authProv.autoLogin();
  print(loginStatus);

  runApp(ProviderScope(
      child: MyApp(
    shoudlLogin: loginStatus,
  )));
}

class MyApp extends StatelessWidget {
  bool shoudlLogin;
  MyApp({super.key, required this.shoudlLogin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: shoudlLogin ? NavbarHome() : RefacApp());
  }
}

class RefacApp extends ConsumerStatefulWidget {
  const RefacApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RefacAppState();
}

class _RefacAppState extends ConsumerState<RefacApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return Consumer(
          builder: (context, ref, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Refac!',
              initialRoute: '/login_page',
              routes: {'/login_page': (context) => const LoginPage()},
            );
          },
        );
      },
    );
  }
}
