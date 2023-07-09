import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Loader extends StatelessWidget {
 const Loader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   
      return Center(
          child: CupertinoAlertDialog(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.hourglass_top_rounded,
            ),
            Text(
              'Loading...',
              style: GoogleFonts.quicksand(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ));
  }
}
