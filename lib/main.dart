import 'package:event_app/firebase_options.dart';
import 'package:event_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:event_app/src/features/auth/presentation/views/base_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthBloc())],
      child: MaterialApp(
        title: 'Event App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
              padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
            ),
          ),
        ),
        home: BaseView(),
      ),
    );
  }
}
