import 'package:flutter/material.dart';

class ListtilesWidget extends StatelessWidget {
  final String title;
  const ListtilesWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, bottom: 5),
      child: Container(
        // height: 40,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(.3)),
        ),
        child: Center(
          child: Row(
            children: [
              SizedBox(width: 10),
              const CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage('assets/img2.jpeg'),
              ),
              SizedBox(width: 15),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
