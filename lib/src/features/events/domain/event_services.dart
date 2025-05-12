import 'package:cloud_firestore/cloud_firestore.dart';

class EventServices {
  Future<void> addSampleEvents() async {
    final collection = FirebaseFirestore.instance.collection('events');
    final snapshot = await collection.get();

    // If already populated, don't add again
    if (snapshot.docs.isNotEmpty) return;

    final events = [
      {
        "id": "0",
        "title": "Firebase Bootcamp",
        "description": "Bootcamp on different firebase features",
        "date": "2025-05-10T12:00:00Z",
        "rsvpStatus": "",
        "totalRsvpCount": 5,
      },
      {
        "id": "1",

        "title": "Dart Deep Dive",
        "description":
            "A deep dive into Dart from basics to advanced - Talks lead by industrial experts",
        "date": "2025-05-10T14:00:00Z",
        "rsvpStatus": "",
        "totalRsvpCount": 3,
      },
      {
        "id": "2",

        "title": "Flutter",
        "description": "Seminar on flutter and related technologies",
        "date": "2025-05-11T14:00:00Z",
        "rsvpStatus": "",
        "totalRsvpCount": 4,
      },
      {
        "id": "3",

        "title": "Artificial Intelligence",
        "description": "Seminar on Artificial Intelligence and it's scope",
        "date": "2025-05-13T14:00:00Z",
        "rsvpStatus": "",
        "totalRsvpCount": 5,
      },
      {
        "id": "4",
        "title": "Machine Learning",
        "description": "Workshop on Machine Learning",
        "date": "2025-05-14T14:00:00Z",
        "rsvpStatus": "",
        "totalRsvpCount": 6,
      },
      {
        "id": "5",

        "title": "Time Management",
        "description": "Seminar on Importance of Time Management",
        "date": "2025-06-01T14:00:00Z",
        "rsvpStatus": "",
        "totalRsvpCount": 7,
      },
      {
        "id": "6",

        "title": "Flutter - New Trends",
        "description": "Descussion about new trending topics in Flutter",
        "date": "2025-06-15T14:00:00Z",
        "rsvpStatus": "",
        "totalRsvpCount": 3,
      },
      {
        "id": "7",

        "title": "DevOps Workshop",
        "description": "Hands-on workshop on DevOps practices and CI/CD",
        "date": "2025-06-20T10:00:00Z",
        "rsvpStatus": "",
        "totalRsvpCount": 2,
      },
    ];

    for (var event in events) {
      await collection.add(event);
    }
  }
}
