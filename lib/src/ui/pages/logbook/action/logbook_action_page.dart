import 'package:flutter/material.dart';
import 'package:foreclair/src/data/dao/user_dao.dart';
import 'package:foreclair/src/data/models/logbook/event_type_dto.dart';
import 'package:foreclair/src/data/models/logbook/event_types.dart';
import 'package:foreclair/src/data/services/app/event_type_service.dart';
import 'package:foreclair/src/ui/pages/logbook/action/components/general_logbook_form.dart';
import 'package:foreclair/src/ui/pages/logbook/action/components/logbook_action_choice_card.dart';
import 'package:foreclair/src/ui/pages/logbook/action/components/logbook_action_header.dart';
import 'package:foreclair/utils/logs/logger_utils.dart';
import 'package:step_progress/step_progress.dart';

class LogBookActionPage extends StatefulWidget {
  const LogBookActionPage({super.key});

  @override
  State<LogBookActionPage> createState() => _LogBookActionPageState();
}

class _LogBookActionPageState extends State<LogBookActionPage> {
  final StepProgressController _stepProgressController = StepProgressController(totalSteps: 3);

  bool _visible = false;
  late EventType _currentEvent;
  late EventTypeDto _currentEventDto;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
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
                if (index <= _stepProgressController.currentStep) {
                  setState(() {
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
            ),

            const SizedBox(height: 24),

            if (_stepProgressController.currentStep == 0) ...[
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
                              _stepProgressController.nextStep();
                              _currentEvent = event;
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ] else if (_stepProgressController.currentStep == 1) ...[
              GeneralLogbookForm(
                event: _currentEvent,
                onValidate: (args) {
                  setState(() {
                    _stepProgressController.nextStep();

                    final attributes = <String, String>{};
                    for (var element in _currentEvent.attributes) {
                      final value = args[element.key];
                      final json = element.type.toJson(value);
                      attributes[element.key] = json;
                    }

                    final currentUser = UserDao.instance.currentUser;
                    if(currentUser != null) {
                      _currentEventDto = EventTypeDto(_currentEvent.key, currentUser.station.id, currentUser.id, attributes);
                    }
                  });
                },
              ),
            ] else if (_stepProgressController.currentStep == 2) ...[
              Text('Step 3: Review and submit'),
              ElevatedButton(onPressed: () {
                EventTypeService.instance.sendEventType(_currentEventDto);
              }, child: Text('Submit')),
            ],
          ],
        ),
      ),
    );
  }
}
