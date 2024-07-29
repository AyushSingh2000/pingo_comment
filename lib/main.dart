import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:pingo_comment/services/remote_config_service.dart';
import 'package:pingo_comment/view/auth/login_screen.dart';
import 'package:pingo_comment/view_model/auth_viewmodel.dart';
import 'package:pingo_comment/view_model/comment_viewmodel.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await RemoteConfigService().initialize();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthViewModel()),
//         ChangeNotifierProvider(create: (_) => CommentViewModel()),
//       ],
//       child: MaterialApp(
//         home: LoginPage(),
//       ),
//     );
//   }
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Initialize Remote Config
  final remoteConfigService =
      RemoteConfigService(FirebaseRemoteConfig.instance);
  await remoteConfigService.setupRemoteConfig();

  runApp(MyApp(remoteConfigService: remoteConfigService));
}

class MyApp extends StatelessWidget {
  final RemoteConfigService remoteConfigService;

  MyApp({required this.remoteConfigService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CommentViewModel()),
        Provider<RemoteConfigService>.value(value: remoteConfigService),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        home: LoginPage(),
      ),
    );
  }
}
