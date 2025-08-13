import 'package:flutter/material.dart';
import 'package:foreclair/utils/units/size_utils.dart';
import 'package:intl/intl.dart';

import '../../../../../assets/fonts/text_utils.dart';
import '../../../../../utils/text/text_utils.dart';
import '../../../../data/models/meteo/tide/tide_model.dart';
import '../../../components/indicator/maree_indicator.dart';

class LayoutUserView extends StatefulWidget {
  const LayoutUserView({super.key});

  @override
  State<LayoutUserView> createState() => _LayoutUserViewState();
}

class _LayoutUserViewState extends State<LayoutUserView> {
  late final DateTime now;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary.withAlpha(10);
    final tertiaryColor = theme.colorScheme.tertiary.withAlpha(10);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(context.width(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ⬆️ AppBar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tableau de bord", style: label),
                        Text("Poste de la mer", style: bodyLargeBold),
                      ],
                    ),
                    IconButton(icon: const Icon(Icons.graphic_eq_rounded), onPressed: () {}),
                  ],
                ),
                SizedBox(height: context.height(5)),

                /// 📝 Main Courante
                dashboardContainer(
                  context: context,
                  height: context.height(12.5),
                  color: secondaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Main courante", style: bodyMediumBold),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(TextUtils.capitalizeEachWord(DateFormat('d MMMM').format(now)), style: titleLarge),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.height(2)),

                Text("Paramètres et Informations", style: bodySmallBold),
                SizedBox(height: context.height(1)),

                /// Dashboard buttons
                Wrap(
                  spacing: context.width(5),
                  runSpacing: context.height(2),
                  children: [
                    _buildDashboardButton(context, "Effectif", tertiaryColor),
                    _buildDashboardButton(context, "Statistiques", tertiaryColor),
                    _buildDashboardButton(context, "Historique", tertiaryColor),
                    _buildDashboardButton(context, "Configuration", tertiaryColor),
                  ],
                ),

                SizedBox(height: context.height(2)),

                /// ⛅ Meteo
                dashboardContainer(
                  context: context,
                  height: context.height(20),
                  color: theme.colorScheme.primaryContainer.withAlpha(20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Météo", style: bodyMediumBold),
                  ),
                ),
              ],
            ),
          ),

          /// 🌊 Marées
          TideCurve(
            tides: [
              TideModel(time: now.copyWith(hour: 4, minute: 45), coefficient: 95, isHighTide: false),
              TideModel(time: now.copyWith(hour: 10, minute: 5), coefficient: 95, isHighTide: true),
              TideModel(time: now.copyWith(hour: 17, minute: 0), coefficient: 95, isHighTide: false),
              TideModel(time: now.copyWith(hour: 22, minute: 21), coefficient: 95, isHighTide: true),
            ],
            currentTime: now,
            curveColor: theme.colorScheme.outline,
            gradientStartColor: theme.colorScheme.onSurfaceVariant.withAlpha(70),
            gradientEndColor: theme.colorScheme.surface.withAlpha(10),
            height: context.height(25),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardButton(BuildContext context, String label, Color color) {
    return dashboardContainer(
      context: context,
      height: context.height(8),
      width: context.width(42.5),
      color: color,
      child: Center(child: Text(label, style: bodyMediumBold)),
    );
  }
}

Widget dashboardContainer({
  required BuildContext context,
  required Widget child,
  required Color color,
  required double height,
  double width = double.infinity,
}) {
  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [BoxShadow(color: Colors.black.withAlpha(5), blurRadius: 10, offset: const Offset(0, 4))],
      border: Border.all(color: color.withAlpha(50)),
    ),
    child: child,
  );
}
