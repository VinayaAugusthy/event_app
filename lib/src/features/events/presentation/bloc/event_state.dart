part of 'event_bloc.dart';

abstract class EventState {
  const EventState();
  List<Object> get props => [];
}

final class EventInitial extends EventState {}

class EventLoading extends EventState {
  final bool isLoading;

  EventLoading({required this.isLoading});
}

class EventSuccessState extends EventState {
  final List<EventModel> events;

  EventSuccessState(this.events);
  @override
  List<Object> get props => [events];
}

class EventFailureState extends EventState {
  final String errorMessage;

  const EventFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
