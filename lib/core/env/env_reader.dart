import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../flavor/flavor.dart';

final envReaderProvider = Provider<EnvReader>((ref) {
  return EnvReader();
});

class EnvReader {
  String getEnvFileName(Flavor flavor) {
    return ".${flavor.name}.env";
  }
}