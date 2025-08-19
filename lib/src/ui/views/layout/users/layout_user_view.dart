import 'package:flutter/material.dart';
import 'package:foreclair/src/ui/pages/logbook/main/logbook_page.dart';
import 'package:foreclair/src/ui/views/authentication/login_view.dart';
import 'package:foreclair/utils/units/size_utils.dart';
import 'package:intl/intl.dart';

import '../../../../../assets/fonts/text_utils.dart';
import '../../../../../utils/logs/logger_utils.dart';
import '../../../../../utils/text/text_utils.dart';
import '../../../../data/models/meteo/tide/tide_model.dart';
import '../../../../data/services/routes/route_service.dart';
import '../../../components/cards/dashboard_card.dart';
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.height(5), horizontal: context.width(5)),
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
                    IconButton(
                      icon: const Icon(Icons.graphic_eq_rounded),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginView()));
                      },
                    ),
                  ],
                ),
                SizedBox(height: context.height(5)),

                /// 📝 Main Courante
                DashboardCard(
                  context: context,
                  color: secondaryColor,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LogBookPage()));
                  },
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
                    DashboardCard(
                      context: context,
                      width: context.width(42.5),
                      color: tertiaryColor,
                      onTap: () async {
                        final RouteService routeService = RouteService();
                        final response = await routeService.request(method: 'GET', path: '/hello');
                        logger.d(response.data);
                      },
                      child: Text("Effectif", style: bodyMediumBold),
                    ),
                    DashboardCard(
                      context: context,
                      width: context.width(42.5),
                      color: tertiaryColor,
                      onTap: () {},
                      child: Text("Statistiques", style: bodyMediumBold),
                    ),
                    DashboardCard(
                      context: context,
                      width: context.width(42.5),
                      color: tertiaryColor,
                      onTap: () {},
                      child: Text("Historique", style: bodyMediumBold),
                    ),
                    DashboardCard(
                      context: context,
                      width: context.width(42.5),
                      color: tertiaryColor,
                      onTap: () {},
                      child: Text("Configuration", style: bodyMediumBold),
                    ),
                  ],
                ),

                SizedBox(height: context.height(2)),

                /// ⛅ Meteo
                DashboardCard(
                  context: context,
                  color: theme.colorScheme.primaryContainer.withAlpha(20),
                  onTap: () {
                    // Navigate to Meteo page
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Météo", style: bodyMediumBold),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildMeteoItem(Icons.thermostat, "26°C", "Air", context),
                          _buildMeteoItem(Icons.water_drop, "22°C", "Eau", context),
                          _buildMeteoItem(Icons.air, "15 km/h", "NE", context),
                          _buildMeteoItem(Icons.wb_sunny, "7", "UV", context),
                        ],
                      ),
                    ],
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
            gradientStartColor: theme.colorScheme.onSurfaceVariant.withAlpha(30),
            gradientEndColor: theme.colorScheme.surface.withAlpha(10),
            height: context.height(25),
          ),
        ],
      ),
    );
  }

  Widget _buildMeteoItem(IconData icon, String value, String label, BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(value, style: bodyMediumBold),
        Text(label, style: bodySmall),
      ],
    );
  }
}
