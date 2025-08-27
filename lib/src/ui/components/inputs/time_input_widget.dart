import 'package:flutter/material.dart';
import 'package:foreclair/src/data/models/logbook/attribute.dart';

class TimeInputFormField extends FormField<TimeOfDay> {
  TimeInputFormField({
    super.key,
    required Attribute attribute,
    TimeOfDay? initialValue,
    super.validator,
    required FormFieldSetter<TimeOfDay?> super.onSaved,
  }) : super(
         initialValue: initialValue ?? TimeOfDay.now(),
         builder: (FormFieldState<TimeOfDay> state) {
           final context = state.context;
           final value = state.value ?? TimeOfDay.now();

           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Padding(
                 padding: const EdgeInsets.only(bottom: 8),
                 child: Text(
                   attribute.title,
                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                 ),
               ),
               InkWell(
                 onTap: () async {
                   final picked = await showTimePicker(
                     context: context,
                     initialTime: value,
                     initialEntryMode: TimePickerEntryMode.input,
                     builder: (ctx, child) => Theme(
                       data: Theme.of(ctx).copyWith(
                         timePickerTheme: TimePickerThemeData(
                           hourMinuteTextColor: Theme.of(ctx).colorScheme.primary,
                           dialBackgroundColor: Theme.of(ctx).colorScheme.onPrimaryContainer,
                           dayPeriodColor: Theme.of(ctx).colorScheme.primary.withAlpha(100),
                           dialHandColor: Theme.of(ctx).colorScheme.primary,
                           entryModeIconColor: Theme.of(ctx).colorScheme.primary,
                           hourMinuteColor: Theme.of(ctx).colorScheme.onPrimaryContainer,
                         ),
                       ),
                       child: child!,
                     ),
                   );
                   if (picked != null) state.didChange(picked);
                 },
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
                         (state.value ?? value).format(context),
                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                       ),
                       const Icon(Icons.access_time),
                     ],
                   ),
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: const EdgeInsets.only(top: 6),
                   child: Text(state.errorText!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                 ),
             ],
           );
         },
       );
}
