import 'package:flutter/material.dart';

class EventForm extends StatefulWidget {
  static final String id = 'EventForm';
  const EventForm({required this.callback});

  final void Function(String title, String content, int duration) callback;

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Form'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter the title',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter the title to continue';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFormField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        hintText: 'Enter the content',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter the content to continue';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFormField(
                      controller: _durationController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Enter the duration',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter the duration to continue';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 30),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              widget.callback(
                                  _titleController.text,
                                  _contentController.text,
                                  int.parse(_durationController.text));
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('NEXT'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
