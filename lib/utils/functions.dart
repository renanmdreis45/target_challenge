import 'package:url_launcher/url_launcher.dart';

launchURL() async {
  final Uri url = Uri.parse('https://www.google.com/');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
