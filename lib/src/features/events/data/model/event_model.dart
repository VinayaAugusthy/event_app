import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? id;
  String? title;
  String? description;
  DateTime? date;
  String? rsvpStatus;
  int? totalRsvpCount;
  EventModel({
    this.id,
    this.title,
    this.description,
    this.date,
    this.rsvpStatus,
    this.totalRsvpCount,
  });
  factory EventModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EventModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: DateTime.parse(data['date']),
      rsvpStatus: data['rsvpStatus'] ?? 'no',
      totalRsvpCount: data['totalRsvpCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date?.toIso8601String(),
      'rsvpStatus': rsvpStatus,
      'totalRsvpCount': totalRsvpCount,
    };
  }
}
