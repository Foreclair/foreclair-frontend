import 'package:flutter/material.dart';

class LayoutViews extends StatefulWidget {
  const LayoutViews({super.key});

  @override
  State<LayoutViews> createState() => _LayoutViewsState();
}

class _LayoutViewsState extends State<LayoutViews> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
        children: [
          // Fixed AppBar
          _buildAppBar(context, colorScheme),

          // Flexible content area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Main Courante Card
                  _buildMainCouranteCard(),
                  const SizedBox(height: 20),

                  // Grid Cards - takes remaining space
                  Expanded(flex: 2, child: _buildGridCards()),

                  const SizedBox(height: 20),

                  // Weather Card - fixed at bottom
                  _buildWeatherCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
      decoration: BoxDecoration(color: colorScheme.surface),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tableau de Bord',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Station de Seignosse',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            _buildUserAvatar(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFF3535), Color(0xFFF71E1E)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Text(
          'JD',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildMainCouranteCard() {
    return InkWell(
      onTap: () {
        // Add navigation logic here
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFFF6B35), Color(0xFFF7931E)]),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: const Color(0xFFFF6B35).withAlpha(30), offset: const Offset(0, 8), blurRadius: 20)],
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.edit_document, color: Colors.white, size: 24),
                SizedBox(width: 10),
                Text(
                  'Main Courante du jour',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('Ajouter des nouvelles interventions', style: TextStyle(fontSize: 14, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildGridCards() {
    final cards = [
      _CardData(icon: Icons.groups, title: 'Effectif & Planning', subtitle: '8 sauveteurs présents\n2 embarcations prêtes'),
      _CardData(icon: Icons.bar_chart, title: 'Statistiques', subtitle: 'Voir les données du jour'),
      _CardData(icon: Icons.folder, title: 'Historique', subtitle: 'Consulter les mains courantes'),
      _CardData(icon: Icons.settings, title: 'Configuration', subtitle: 'Préférences'),
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1.0,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return _buildCard(icon: card.icon, title: card.title, subtitle: card.subtitle, onTap: () => _handleCardTap(index));
      },
    );
  }

  Widget _buildCard({required IconData icon, required String title, required String subtitle, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE9ECEF)),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(8), offset: const Offset(0, 2), blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B35).withAlpha(20),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFFFF6B35), size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF333333)),
            ),
            const SizedBox(height: 6),
            Flexible(
              child: Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Color(0xFF666666), height: 1.3),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF4A90E2), Color(0xFF357ABD)]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), offset: const Offset(0, 4), blurRadius: 12)],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.sunny,
            color: Colors.white,
            size: 28, // Slightly smaller
          ),
          const SizedBox(height: 8),
          const Text(
            '22°C',
            style: TextStyle(
              fontSize: 28, // Slightly smaller
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const Text(
            'Mer calme • Force 2',
            style: TextStyle(fontSize: 14, color: Colors.white), // Smaller text
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildWeatherDetail('Vent', '15 km/h', Icons.air),
              _buildWeatherDetail('Marée', 'Haute 16h', Icons.water),
              _buildWeatherDetail('Visibilité', '8/10', Icons.visibility),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white)),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ],
    );
  }

  void _handleCardTap(int index) {
    // Handle card taps based on index
    switch (index) {
      case 0:
        // Navigate to Effectif & Planning
        break;
      case 1:
        // Navigate to Statistics
        break;
      case 2:
        // Navigate to History
        break;
      case 3:
        // Navigate to Configuration
        break;
    }
  }
}

class _CardData {
  final IconData icon;
  final String title;
  final String subtitle;

  _CardData({required this.icon, required this.title, required this.subtitle});
}
