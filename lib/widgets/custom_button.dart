import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 1.5,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF0C54BE),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(14.0), // Set the border radius to 20
          ),
        ),
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
/*
SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.5,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            14.0), // Set the border radius to 20
                      ),
                    ),
                    child: Text(
                      text
                    ),
                  ),
                ),*/
