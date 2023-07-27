import 'package:flutter/material.dart';
import 'package:whatsapp/core/constants.dart';

class WebSearchBar extends StatelessWidget {
  const WebSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.25,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: dividerColor),
      )),
      child: TextField(
        decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: searchBarColor,
            prefixIcon: const Icon(Icons.search),
            hintStyle: const TextStyle(fontSize: 14),
            hintText: "Search or start new chat",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            contentPadding: const EdgeInsets.all(10)),
      ),
    );
  }
}
