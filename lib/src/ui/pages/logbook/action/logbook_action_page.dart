import 'package:flutter/material.dart';
import 'package:foreclair/src/data/models/logbook/event_types.dart';
import 'package:foreclair/src/ui/pages/logbook/action/components/logbook_action_choice_card.dart';
import 'package:foreclair/src/ui/pages/logbook/action/components/logbook_action_header.dart';
import 'package:step_progress/step_progress.dart';

import 'components/forms/heal_form.dart';
import 'components/forms/intervention_form.dart';
import 'components/forms/prevention_form.dart';
import 'components/forms/rotation_form.dart';
import 'components/forms/schedule_form.dart';
import 'components/forms/supervision_form.dart';

class LogBookActionPage extends StatefulWidget {
  const LogBookActionPage({super.key});

  @override
  State<LogBookActionPage> createState() => _LogBookActionPageState();
}

class _LogBookActionPageState extends State<LogBookActionPage> {
  final StepProgressController _stepProgressController = StepProgressController(totalSteps: 3);

  bool _visible = false;
  int _currentStep = 0;
  EventType _currentEvent = EventType.intervention;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  Widget buildLogBookRoute(EventType event) {
    switch (event) {
      case EventType.ouverture || EventType.fermeture:
        return ScheduleForm(
          onValidate: (time) {
            setState(() {
              _currentStep++;
              _stepProgressController.nextStep();
            });
          },
          event: event,
        );
      case EventType.dsurveillance || EventType.fsurveillance:
        return SupervisionForm();
      case EventType.intervention:
        return InterventionForm();
      case EventType.heal:
        return HealForm();
      case EventType.prevention:
        return PreventionForm();
      case EventType.rotation:
        return RotationForm();
      default:
        return ScheduleForm(
          onValidate: (time) {
            setState(() {
              _currentStep++;
              _stepProgressController.nextStep();
            });
          },
          event: event,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        opacity: _visible ? 1.0 : 0.0,
        child: Column(
          children: [
            LogbookActionHeader(),

            const SizedBox(height: 12),

            StepProgress(
              onStepNodeTapped: (index) {
                if (index <= _currentStep) {
                  setState(() {
                    _currentStep = index;
                    _stepProgressController.setCurrentStep(index);
                  });
                }
              },
              theme: StepProgressThemeData(
                activeForegroundColor: Theme.of(context).colorScheme.secondary,
                defaultForegroundColor: Colors.grey.shade300,
              ),
              totalSteps: 3,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              controller: _stepProgressController,
              onStepChanged: (currentIndex) {
                setState(() {
                  _currentStep = currentIndex;
                });
              },
            ),

            const SizedBox(height: 24),

            if (_currentStep == 0) ...[
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  crossAxisCount: 2,
                  mainAxisSpacing: 28,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.3,
                  children: EventType.values
                      .map(
                        (event) => LogbookActionChoiceCard(
                          event: event,
                          callback: () {
                            setState(() {
                              _currentStep++;
                              _stepProgressController.nextStep();
                              _currentEvent = event;
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ] else if (_currentStep == 1) ...[
              buildLogBookRoute(_currentEvent),
            ] else if (_currentStep == 2) ...[
              Text('Step 3: Review and submit'),
              ElevatedButton(onPressed: () {}, child: Text('Submit')),
            ],
          ],
        ),
      ),
    );
  }
}
