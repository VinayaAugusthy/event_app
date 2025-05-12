part of 'event_bloc.dart';

@immutable
abstract class EventEvent {
  const EventEvent();
  List<Object> get props => [];
}

class LoadEvents extends EventEvent {}

class UpdateRsvp extends EventEvent {
  final EventModel event;
  final String newStatus;

  const UpdateRsvp(this.event, this.newStatus);
}
