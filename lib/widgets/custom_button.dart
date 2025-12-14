import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text, this.onTap});
  final String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),

        width: double.infinity,
        height: 60,
        child: Center(child: Text(text, style: TextStyle(fontSize: 18))),
      ),
    );

    // return SizedBox(
    //   width: double.infinity,
    //   height: 60,
    //   child: ElevatedButton(
    //     onPressed: () {},
    //     // style: ElevatedButton.styleFrom(),
    //     child: Text(text, style: TextStyle(fontSize: 18)),
    //   ),
    // );
  }
}
