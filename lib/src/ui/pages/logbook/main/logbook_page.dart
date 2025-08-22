import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foreclair/assets/fonts/text_utils.dart';
import 'package:foreclair/src/ui/components/layouts/topography_background.dart';
import 'package:foreclair/src/ui/pages/logbook/main/components/logbook_timeline.dart';
import 'package:foreclair/utils/units/size_utils.dart';
import 'package:intl/intl.dart';

import '../../../components/animations/route/wave_page_route.dart';
import '../action/logbook_action_page.dart';

class LogBookPage extends StatefulWidget {
  const LogBookPage({super.key});

  @override
  State<LogBookPage> createState() => _LogBookPageState();
}

class _LogBookPageState extends State<LogBookPage> {
  late final String formattedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    formattedDate = DateFormat("dd/MM/yyyy").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: TopographyBackground(
              lineColorFilter: const ColorFilter.mode(Color(0x52A1A1A1), BlendMode.srcIn),
              backgroundColors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withAlpha(230)],
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(CupertinoIcons.back, color: Theme.of(context).colorScheme.onPrimaryContainer),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              CupertinoIcons.ellipsis_vertical,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.height(2)),
                    Text(
                      "Main courante du $formattedDate",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),

              Expanded(child: LogbookTimeline()),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(WavePageRoute(page: const LogBookActionPage()));
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(CupertinoIcons.add, color: Theme.of(context).colorScheme.onSecondary),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsetsGeometry.directional(top: context.height(2)),
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.height(1), horizontal: context.width(2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFooterButton("Action 1"),
              _buildFooterButton("Action 2"),
              _buildFooterButton("Action 3"),
              _buildFooterButton("Action 4"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterButton(String label) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(horizontal: context.width(3), vertical: context.height(1)),
      ),
      onPressed: () {},
      child: Text(label, style: bodySmallBold),
    );
  }
}
