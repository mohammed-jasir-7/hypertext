import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class HyperTextApi {
  static Widget hyperText({required String text,required TextStyle textStyle}) {
    final urlRegExp = RegExp(
        r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?');
    final phoneExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    final email=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    List<String> texts = text.split(' ');
    var result = texts.map((e) {
      if (urlRegExp.hasMatch(e)) {
        return TextSpan(
          style: textStyle,
          text: '$e ',
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrl(Uri.parse(e)),
        );
      } else if (phoneExp.hasMatch(e)) {
        return TextSpan(
          text: '$e ',
          style: const TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrl(Uri.parse('tel:$e')),
        );
      }else if(email.hasMatch(e)){
         return TextSpan(
          text: '$e ',
          style: const TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrl(Uri.parse('mailto:$e')),
        );

      } else {
        return TextSpan(text: '$e ', style: const TextStyle(color: Colors.black));
      }
    }).toList();
    return RichText(text: TextSpan(children: result));
  }

//   helper({VoidCallback? onTap,VoidCallback? longPress}){
// final detector=TapGestureRecognizer();
// detector.onTap=onTap;
// detector.onTapDown=longPress;
//   }
}

