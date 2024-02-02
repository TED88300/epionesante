
import 'package:url_launcher/url_launcher.dart';

Future launchURL(String url) async {
  Uri uri = Uri.parse(url);
  print('zzz $url') ;
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

Future launchTel(String uri) async {
   await launchURL(uri);

}


Future<void> launchPhoneDialer(String contactNumber) async {
  final Uri _phoneUri = Uri(
      scheme: "tel",
      path: contactNumber
  );
  try {
    if (await canLaunch(_phoneUri.toString()))
      await launch(_phoneUri.toString());
  } catch (error) {
    throw("Cannot dial");
  }
}