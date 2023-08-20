import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ecom_app/core/flavor/flavor.dart';

class EnvReader {
  String getBaseUrl(Flavor flavor) {
    return switch (flavor) {
      Flavor.dev => ".dev.env",
      Flavor.uat => ".uat.env",
      Flavor.qa => ".qa.env",
      Flavor.prod => ".prod.env",
    };
  }

  String? getApiKey() {
    return dotenv.env['API_KEY'];
  }
}