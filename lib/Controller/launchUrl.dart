import 'package:url_launcher/url_launcher.dart';

class LaunchUrl {
  static Future<void> launchUrl(Uri call) async {
    if (!(await canLaunch(call.toString()))) {
      throw Exception('Could not launch $call');
    } else {
      await launch(call.toString());
    }
  }

}
