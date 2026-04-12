import 'package:flutter/material.dart';

class CheckFromInternetConnectionScreen extends StatelessWidget {
  const CheckFromInternetConnectionScreen({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .7,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80.0,
              color: Color(0xFFE8B453),
            ),
            SizedBox(height: 20.0),
            Text(
              'AppStrings.noInternetConnection',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE8B453),
              ),
              textAlign: TextAlign.center,
            ),
            // const SizedBox(height: 20.0),
            // DefaultButton(
            //   onPressed: onPressed,
            //   text: "Check again",
            // ),
          ],
        ),
      ),
    );
  }
}
