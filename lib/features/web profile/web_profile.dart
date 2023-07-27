import 'package:flutter/material.dart';
import 'package:whatsapp/core/constants.dart';

class WebProfileBar extends StatelessWidget {
  const WebProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.087,
      width: MediaQuery.of(context).size.width * 0.25,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(color: dividerColor),
          ),
          color: webAppBarColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            child: const CircleAvatar(
              backgroundImage: AssetImage(
                "images/profile.jpg",
              ),
              radius: 20,
            ),
          ),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.message_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
            ],
          )
        ],
      ),
    );
  }
}
