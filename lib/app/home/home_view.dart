import 'package:event_app/app/home/event_form.dart';
import 'package:event_app/app/models/Event.dart';
import 'package:event_app/services/firebase_auth_service.dart';
import 'package:event_app/services/firestore_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<FirestoreDatabase>(
      create: (_) => FirestoreDatabase(uid: context.read<User?>()!.uid),
      builder: (_, child) {
        // final database = context
        //     .select((FirestoreDatabase firestoreDatabase) => firestoreDatabase);
        return Scaffold(
          appBar: AppBar(
            title: Text('Events'),
            actions: [
              ElevatedButton.icon(
                onPressed: () {
                  ///logout
                  context.read<FirebaseAuthService>().signOut();
                },
                icon: Icon(Icons.logout),
                label: Text('logout'),
              ),
            ],
          ),
          body: EventView(),
        );
      },
    );
  }
}

class EventView extends StatelessWidget {
  const EventView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final database = context
        .select((FirestoreDatabase firestoreDatabase) => firestoreDatabase);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Event Page',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          StreamBuilder<List<Event>>(
            stream: database.eventsStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                final data = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(data[index].title),
                        subtitle: Text(data[index].content),
                        trailing: Text('${data[index].duration} h'),
                      );
                    },
                  ),
                );
              }
            },
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              // addEvent(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return EventForm(callback: (title, content, duration) {
                    final event = Event(
                        id: documentIdFromCurrentDate(),
                        title: title,
                        content: content,
                        duration: duration);
                    print(database.setEvent(event));
                    // fake@fake.com
                  });
                }),
              );
            },
            child: Text('add event'),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
