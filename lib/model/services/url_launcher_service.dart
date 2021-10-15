import 'package:url_launcher/url_launcher.dart';

//launches the passed-in URL on a web browser like Safari or Chrome
  void launchURL(String url) async => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
