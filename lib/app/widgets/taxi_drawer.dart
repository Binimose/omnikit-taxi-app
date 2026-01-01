import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/taxi_theme.dart';
import '../core/models/user_model.dart';

/// Premium animated side-menu drawer for the Taxi App.
/// Adapts content based on the user role (Rider vs Driver).
class TaxiDrawer extends StatefulWidget {
  final String role; // 'rider' or 'driver'

  const TaxiDrawer({super.key, required this.role});

  @override
  State<TaxiDrawer> createState() => _TaxiDrawerState();
}

class _TaxiDrawerState extends State<TaxiDrawer> with TickerProviderStateMixin {
  late final AnimationController _bgController;
  late final AnimationController _itemsController;
  late final Animation<double> _headerFade;

  // Menu item definitions based on role
  List<_DrawerMenuItem> get _menuItems {
    if (widget.role == 'driver') {
      return const [
        _DrawerMenuItem(
          Icons.dashboard_outlined,
          'Dashboard',
          '/home',
        ), // Refreshes home
        _DrawerMenuItem(Icons.attach_money, 'Earnings', '/driver/earnings'),
        _DrawerMenuItem(Icons.history, 'Trip History', '/driver/history'),
        _DrawerMenuItem(Icons.star_outline, 'Reviews', '/driver/reviews'),
        _DrawerMenuItem(Icons.person_outline, 'Profile', '/driver/profile'),
        _DrawerMenuItem(Icons.settings_outlined, 'Settings', '/settings'),
      ];
    } else {
      // Rider
      return const [
        _DrawerMenuItem(Icons.home_outlined, 'Home', '/home'), // Refreshes home
        _DrawerMenuItem(Icons.history, 'My Rides', '/rider/history'),
        _DrawerMenuItem(Icons.payment, 'Payments', '/rider/wallet'),
        _DrawerMenuItem(Icons.card_giftcard, 'Promotions', '/rider/promotions'),
        _DrawerMenuItem(Icons.person_outline, 'Profile', '/rider/profile'),
        _DrawerMenuItem(Icons.support_agent, 'Support', '/rider/support'),
        _DrawerMenuItem(Icons.settings_outlined, 'Settings', '/settings'),
      ];
    }
  }

  @override
  void initState() {
    super.initState();

    // Background decorative animation
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Staggered items entrance
    _itemsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _headerFade = CurvedAnimation(parent: _bgController, curve: Curves.easeOut);

    _bgController.forward();
    _itemsController.forward();
  }

  @override
  void dispose() {
    _bgController.dispose();
    _itemsController.dispose();
    super.dispose();
  }

  // Build a staggered slide+fade animation for each menu item
  Animation<double> _itemAnimation(int index) {
    final start = (index * 0.08).clamp(0.0, 0.6);
    final end = (start + 0.4).clamp(0.0, 1.0);
    return CurvedAnimation(
      parent: _itemsController,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine gradient based on role
    final gradientColors = _getRoleGradient();

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Decorative glassmorphism circles
            ..._buildDecorativeCircles(),

            // Main content
            SafeArea(
              child: Column(
                children: [
                  // Profile header
                  FadeTransition(
                    opacity: _headerFade,
                    child: _buildProfileHeader(),
                  ),

                  const SizedBox(height: 8),

                  // Divider
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Divider(
                      color: Colors.black.withOpacity(0.1),
                      thickness: 1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Menu items
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: _menuItems.length,
                      itemBuilder: (context, index) {
                        final item = _menuItems[index];
                        final anim = _itemAnimation(index);
                        return AnimatedBuilder(
                          animation: anim,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(-40 * (1 - anim.value), 0),
                              child: Opacity(opacity: anim.value, child: child),
                            );
                          },
                          child: _buildMenuItem(item, index),
                        );
                      },
                    ),
                  ),

                  // Logout & footer
                  FadeTransition(opacity: _headerFade, child: _buildFooter()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getRoleGradient() {
    if (widget.role == 'driver') {
      return [
        const Color(0xFFE65100), // Dark Orange/Red for Driver distinction
        const Color(0xFFFFCC00), // Taxi Yellow
        const Color(0xFFFFD740),
      ];
    } else {
      // Rider - Classic Taxi Yellow
      return [
        const Color(0xFFFFD600),
        const Color(0xFFFFCC00),
        const Color(0xFFFFCA28),
      ];
    }
  }

  // ───── Profile Header ─────
  Widget _buildProfileHeader() {
    String name;
    String subtitle;
    IconData icon;

    if (widget.role == 'driver') {
      name = 'Alex Driver';
      subtitle = '4.9 ★ • Elite Driver';
      icon = Icons.local_taxi;
    } else {
      name = 'John Rider';
      subtitle = 'Gold Member';
      icon = Icons.person;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
      child: Row(
        children: [
          // Animated avatar ring
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: Icon(icon, size: 34, color: Colors.black),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───── Menu Item Tile ─────
  Widget _buildMenuItem(_DrawerMenuItem item, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context); // close drawer
            if (item.route != null) {
              Navigator.pushNamed(context, item.route!);
            }
          },
          borderRadius: BorderRadius.circular(14),
          splashColor: Colors.black.withOpacity(0.05),
          highlightColor: Colors.black.withOpacity(0.03),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(item.icon, color: Colors.black87, size: 22),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  item.label,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                Icon(Icons.chevron_right, color: Colors.black54, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ───── Footer ─────
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        children: [
          Divider(color: Colors.black.withOpacity(0.1), thickness: 1),
          const SizedBox(height: 8),
          // Log Out
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                // In demo, switch role logic might be here or just logout
                if (TaxiUserParams.currentRole == 'rider') {
                  TaxiUserParams.currentRole = 'driver';
                } else {
                  TaxiUserParams.currentRole = 'rider';
                }
                Navigator.pushReplacementNamed(
                  context,
                  '/home',
                ); // Reload gateway
              },
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.swap_horiz,
                          color: Colors.redAccent,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Switch Role (Demo)',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'City Taxi v1.5',
            style: GoogleFonts.poppins(fontSize: 11, color: Colors.black45),
          ),
        ],
      ),
    );
  }

  // ───── Decorative glassmorphism circles ─────
  List<Widget> _buildDecorativeCircles() {
    return [
      Positioned(
        top: -40,
        right: -30,
        child: FadeTransition(
          opacity: _headerFade,
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
        ),
      ),
      Positioned(
        top: 200,
        left: -50,
        child: FadeTransition(
          opacity: _headerFade,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.15),
            ),
          ),
        ),
      ),
    ];
  }
}

// ───── Helper model ─────
class _DrawerMenuItem {
  final IconData icon;
  final String label;
  final String? route;

  const _DrawerMenuItem(this.icon, this.label, this.route);
}

/// Convenience wrapper around [AnimatedBuilder]
class AnimatedBuilder extends StatelessWidget {
  final Animation<double> animation;
  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  const AnimatedBuilder({
    super.key,
    required this.animation,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: animation,
      builder: (context, _) => builder(context, child),
    );
  }
}
