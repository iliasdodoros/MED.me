// import 'package:flutter/material.dart';

class Event {
  final String title;
  Event({required this.title});

  @override
  String toString() => title;

  static Event fromJson(Map<String, dynamic> json) {
    return Event(title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title};
  }
}
