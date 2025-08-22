import 'package:flutter/material.dart';
import 'package:foreclair/src/data/models/logbook/event_types.dart';
import 'package:foreclair/src/ui/components/buttons/primary_action_button_widget.dart';

class ScheduleForm extends StatefulWidget {
  final EventType event;
  final Function(String) onValidate;

  const ScheduleForm({super.key, required this.onValidate, required this.event});

  @override
  State<ScheduleForm> createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              hourMinuteTextColor: Theme.of(context).colorScheme.primary,
              dialBackgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              dayPeriodColor: Theme.of(context).colorScheme.primary.withAlpha(100),
              dialHandColor: Theme.of(context).colorScheme.primary,
              entryModeIconColor: Theme.of(context).colorScheme.primary,
              hourMinuteColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                widget.event == EventType.ouverture ? "Ouverture du poste" : "Fermeture du poste",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              if (widget.event == EventType.ouverture) ...[
                InkWell(
                  onTap: _pickTime,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade100,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedTime.format(context),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.access_time),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 24),

          PrimaryActionButtonWidget(
            text: "Suivant",
            onPressed: () {
              print("Selected time: ${_selectedTime.format(context)}");
              widget.onValidate(_selectedTime.toString());
            },
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
