import 'package:flutter/material.dart';
import 'package:foreclair/src/data/models/logbook/event_types.dart';

class GeneralLogbookForm extends StatefulWidget {
  final EventType event;
  final ValueChanged<Map<String, dynamic>> onValidate;

  const GeneralLogbookForm({super.key, required this.event, required this.onValidate});

  @override
  State<GeneralLogbookForm> createState() => _GeneralLogbookFormState();
}

class _GeneralLogbookFormState extends State<GeneralLogbookForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _data = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.event.title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
            ),
            const SizedBox(height: 16),

            ...widget.event.attributes.map(
              (attr) => Padding(padding: const EdgeInsets.only(bottom: 16), child: attr.type.buildField(attr, _data)),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? true) {
                  _formKey.currentState?.save();
                  widget.onValidate(_data);
                }
              },
              child: const Text("Suivant"),
            ),
          ],
        ),
      ),
    );
  }
}
