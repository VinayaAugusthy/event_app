// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/src/features/events/data/model/event_model.dart';
import 'package:event_app/src/features/events/domain/event_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final CollectionReference eventsRef = FirebaseFirestore.instance.collection(
    'events',
  );

  EventBloc() : super(EventInitial()) {
    on<LoadEvents>(_onLoadEvents);
    on<UpdateRsvp>(_onUpdateRsvp);
  }
  Future<void> _onLoadEvents(event, emit) async {
    emit(EventLoading(isLoading: true));

    try {
      final collection = FirebaseFirestore.instance.collection('events');
      final snapshot = await collection.get();

      // If empty, add sample events
      if (snapshot.docs.isEmpty) {
        await EventServices().addSampleEvents();

        // Wait for Firestore to settle
        await Future.delayed(Duration(milliseconds: 500));
      }

      final refreshedSnapshot = await collection.get();
      final events =
          refreshedSnapshot.docs
              .map((doc) => EventModel.fromDocument(doc))
              .toList();

      emit(EventSuccessState(events));
    } catch (e) {
      emit(EventFailureState('Failed to load events'));
    }
  }

  Future<void> _onUpdateRsvp(event, emit) async {
    final updatedEvent = event.event;
    final newStatus = event.newStatus;

    try {
      int updatedCount = updatedEvent.totalRsvpCount ?? 0;

      if (updatedEvent.rsvpStatus != newStatus) {
        if (newStatus == 'Yes') {
          updatedCount += 1;
        } else if (updatedEvent.rsvpStatus == 'Yes') {
          updatedCount -= 1;
        }

        await eventsRef.doc(updatedEvent.id).update({
          'rsvpStatus': newStatus,
          'totalRsvpCount': updatedCount,
        });

        add(LoadEvents());
      }
    } catch (e) {
      emit(EventFailureState('Failed to update RSVP'));
    }
  }
}
