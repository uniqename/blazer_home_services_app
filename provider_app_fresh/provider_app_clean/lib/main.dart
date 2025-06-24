import 'package:flutter/material.dart';

void main() {
  runApp(HomeLinkGHApp());
}

class HomeLinkGHApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeLinkGH - Complete Platform',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color(0xFF006B3C), // Ghana Green
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeLinkGHRoleSelection(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeLinkGHRoleSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF006B3C), // Ghana Green
              Color(0xFF228B22), // Forest Green
              Color(0xFF32CD32), // Lime Green
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Logo and App Name
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.home_work,
                    size: 60,
                    color: Color(0xFF006B3C),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'HomeLinkGH',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Your Complete Home Services Platform',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                
                // Role Selection Cards
                Expanded(
                  child: Column(
                    children: [
                      _buildRoleCard(
                        context,
                        icon: Icons.person,
                        title: 'Customer',
                        subtitle: 'Book home services',
                        onTap: () => _navigateToCustomerApp(context),
                      ),
                      const SizedBox(height: 20),
                      _buildRoleCard(
                        context,
                        icon: Icons.work,
                        title: 'Service Provider',
                        subtitle: 'Offer your services',
                        onTap: () => _navigateToProviderApp(context),
                      ),
                      const SizedBox(height: 20),
                      _buildRoleCard(
                        context,
                        icon: Icons.admin_panel_settings,
                        title: 'Admin',
                        subtitle: 'Manage platform',
                        onTap: () => _navigateToAdminApp(context),
                      ),
                      const SizedBox(height: 20),
                      _buildRoleCard(
                        context,
                        icon: Icons.flight_land,
                        title: 'Diaspora Mode',
                        subtitle: 'Plan from abroad',
                        onTap: () => _navigateToDiasporaApp(context),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                const Text(
                  'Connecting Ghana, One Home at a Time',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF006B3C).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 32,
                color: Color(0xFF006B3C),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006B3C),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF006B3C),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCustomerApp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerHomeScreen(),
      ),
    );
  }

  void _navigateToProviderApp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProviderDashboardScreen(),
      ),
    );
  }

  void _navigateToAdminApp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminDashboardScreen(),
      ),
    );
  }

  void _navigateToDiasporaApp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiasporaHomeScreen(),
      ),
    );
  }
}

// Simplified screens
class CustomerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Portal'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: Color(0xFF006B3C)),
            SizedBox(height: 20),
            Text(
              'Customer Portal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Book home services easily'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back to Role Selection'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProviderDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Dashboard'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.work, size: 80, color: Color(0xFF006B3C)),
            SizedBox(height: 20),
            Text(
              'Provider Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Manage your services and bookings'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back to Role Selection'),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.admin_panel_settings, size: 80, color: Color(0xFF006B3C)),
            SizedBox(height: 20),
            Text(
              'Admin Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Monitor and manage the platform'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back to Role Selection'),
            ),
          ],
        ),
      ),
    );
  }
}

class DiasporaHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diaspora Mode'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flight_land, size: 80, color: Color(0xFF006B3C)),
            SizedBox(height: 20),
            Text(
              'Akwaba! Welcome Home 🇬🇭',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Plan your trip, we\'ll prep your house'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back to Role Selection'),
            ),
          ],
        ),
      ),
    );
  }
}