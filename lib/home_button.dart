import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function() onPressed;

  const HomeButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        width: 120,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
              backgroundColor: const Color(0xff9b1536),
              textStyle: const TextStyle(fontSize: 18)),
          onPressed: onPressed,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(icon, color: Colors.black))),
                Text(text, style: const TextStyle(color: Colors.white))
              ]),
        ));
  }
}
