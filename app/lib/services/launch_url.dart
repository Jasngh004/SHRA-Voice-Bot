import 'package:url_launcher/url_launcher.dart';


Future<void> launchWebUrl(argurl) async {
  final Uri url = Uri.parse(argurl);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}