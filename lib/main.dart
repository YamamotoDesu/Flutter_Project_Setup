import 'dart:async';
import 'package:ecom_app/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecom_app/core/env/env_reader.dart';
import 'package:ecom_app/core/flavor/flavor.dart';

FutureOr<void> mainApp(Flavor flavor) async {
  // An object that stores the state of the providers and allows overriding the behavior of a specific provider.
  final container = ProviderContainer();

  final envReader = container.read(envReaderProvider);
  final envFile = envReader.getEnvFileName(flavor);
  await dotenv.load(fileName: envFile);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MainWidget(),
    ),
  );
}
