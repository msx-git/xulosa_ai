import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/app.dart';
import 'firebase_options.dart';
import 'logic/blocs/blocs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FilePickerBloc()),
        BlocProvider(create: (context) => PdfToImageBloc()),
        BlocProvider(create: (context) => GenerativeAiBloc()),
      ],
      child: const MyApp(),
    ),
  );
}
