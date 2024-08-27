import 'package:flutter/cupertino.dart';
import 'package:flutter_test_project/models/order_model.dart';

import 'package:flutter_test_project/pages/auth_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OrderModel.newOrder()),
      ],
      child: CupertinoApp(
        title: 'Namer App',
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
      ),
    );
  }
}
