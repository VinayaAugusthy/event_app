import 'package:event_app/src/core/constants/colors.dart';
import 'package:event_app/src/core/extensions/date_time_extension.dart';
import 'package:event_app/src/features/events/presentation/bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventView extends StatefulWidget {
  const EventView({super.key});

  @override
  State<EventView> createState() => _HomeViewState();
}

class _HomeViewState extends State<EventView> {
  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(LoadEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Events')),
      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is EventFailureState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          if (state is EventSuccessState) {
            var events = state.events;
            return ListView.separated(
              padding: EdgeInsets.all(8),
              itemCount: events.length,
              itemBuilder: (context, index) {
                var event = events[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      event.title ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.calendar_month_outlined, size: 20),
                            SizedBox(width: 5),
                            Text(
                              (event.date!).formatDate(),
                              style: TextStyle(color: AppColors.textBlack),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        Text(
                          event.description ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(color: AppColors.grey),
                        ),
                        SizedBox(height: 10),

                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<EventBloc>(
                                  context,
                                ).add(UpdateRsvp(event, 'Yes'));
                              },
                              style: ButtonStyle(
                                side: WidgetStatePropertyAll(
                                  BorderSide(color: AppColors.red),
                                ),
                                backgroundColor: WidgetStatePropertyAll(
                                  event.rsvpStatus == 'Yes'
                                      ? AppColors.red
                                      : Colors.transparent,
                                ),
                              ),
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  color:
                                      event.rsvpStatus == 'Yes'
                                          ? AppColors.white
                                          : AppColors.black,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<EventBloc>(
                                  context,
                                ).add(UpdateRsvp(event, 'No'));
                              },
                              style: ButtonStyle(
                                side: WidgetStatePropertyAll(
                                  BorderSide(color: AppColors.red),
                                ),
                                backgroundColor: WidgetStatePropertyAll(
                                  event.rsvpStatus == 'No'
                                      ? AppColors.red
                                      : Colors.transparent,
                                ),
                              ),
                              child: Text(
                                'No',
                                style: TextStyle(
                                  color:
                                      event.rsvpStatus == 'No'
                                          ? AppColors.white
                                          : AppColors.black,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              event.totalRsvpCount.toString(),
                              style: TextStyle(
                                color: AppColors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(' attending'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              separatorBuilder:
                  (BuildContext context, int index) =>
                      Divider(height: 0, thickness: 1),
            );
          }
          return Center(child: Text('No Events Found')); //fallback
        },
      ),
    );
  }
}
