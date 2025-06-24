import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(HomeLinkGHApp());
}

class HomeLinkGHApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeLinkGH - Ghana Home Services & Food Delivery',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color(0xFF006B3C), // Ghana Green
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF006B3C),
          secondary: Color(0xFFFCD116), // Ghana Gold
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash': (context) => SplashScreen(),
        '/auth': (context) => AuthScreen(),
        '/home': (context) => HomeScreen(),
        '/customer': (context) => CustomerApp(),
        '/provider': (context) => ProviderApp(),
        '/admin': (context) => AdminApp(),
        '/diaspora': (context) => DiasporaApp(),
        '/jobs': (context) => JobsBoard(),
      },
    );
  }
}

// Data Management Classes
class UserManager {
  static List<Map<String, dynamic>> users = [];
  static Map<String, dynamic>? currentUser;
  
  static bool registerUser(Map<String, dynamic> userData) {
    // Check if user already exists
    bool userExists = users.any((user) => user['email'] == userData['email']);
    if (userExists) return false;
    
    userData['id'] = DateTime.now().millisecondsSinceEpoch.toString();
    userData['createdAt'] = DateTime.now().toIso8601String();
    users.add(userData);
    return true;
  }
  
  static bool loginUser(String email, String password) {
    try {
      var user = users.firstWhere((user) => 
        user['email'] == email && user['password'] == password);
      currentUser = user;
      return true;
    } catch (e) {
      return false;
    }
  }
  
  static void logout() {
    currentUser = null;
  }
}

class ServiceManager {
  static List<Map<String, dynamic>> services = [
    {
      'id': '1',
      'name': 'House Cleaning',
      'description': 'Professional home cleaning services',
      'price': 'GHS 50-200',
      'category': 'Home Services',
      'providers': 23,
      'rating': 4.8,
      'bookings': 156,
      'available': true,
    },
    {
      'id': '2', 
      'name': 'Food Delivery',
      'description': 'Fresh meals from top Ghana restaurants',
      'price': 'GHS 15-80',
      'category': 'Food & Delivery',
      'providers': 45,
      'rating': 4.7,
      'bookings': 342,
      'available': true,
    },
    {
      'id': '3',
      'name': 'Plumbing Services',
      'description': 'Expert plumbing repairs and installations',
      'price': 'GHS 80-300',
      'category': 'Home Services',
      'providers': 18,
      'rating': 4.9,
      'bookings': 89,
      'available': true,
    },
    {
      'id': '4',
      'name': 'Beauty & Salon',
      'description': 'Professional beauty and grooming services',
      'price': 'GHS 30-150',
      'category': 'Personal Care',
      'providers': 34,
      'rating': 4.6,
      'bookings': 127,
      'available': true,
    },
  ];
  
  static List<Map<String, dynamic>> getServicesByCategory(String category) {
    return services.where((service) => service['category'] == category).toList();
  }
}

class BookingManager {
  static List<Map<String, dynamic>> bookings = [];
  
  static String createBooking(Map<String, dynamic> bookingData) {
    String bookingId = DateTime.now().millisecondsSinceEpoch.toString();
    bookingData['id'] = bookingId;
    bookingData['userId'] = UserManager.currentUser?['id'];
    bookingData['status'] = 'pending';
    bookingData['createdAt'] = DateTime.now().toIso8601String();
    bookings.add(bookingData);
    return bookingId;
  }
  
  static List<Map<String, dynamic>> getUserBookings() {
    if (UserManager.currentUser == null) return [];
    return bookings.where((booking) => 
      booking['userId'] == UserManager.currentUser!['id']).toList();
  }
}

class JobManager {
  static List<Map<String, dynamic>> jobs = [
    {
      'id': '1',
      'title': 'Delivery Driver - Motorcycle',
      'company': 'HomeLinkGH',
      'location': 'East Legon, Accra',
      'salary': 'GHS 800-1200/month',
      'type': 'Full-time',
      'category': 'Delivery',
      'description': 'Join our delivery team! Provide fast, reliable delivery services across Accra. Must have motorcycle and valid license.',
      'requirements': ['Valid motorcycle license', 'Own motorcycle', 'Good knowledge of Accra roads', 'Customer service skills'],
      'posted': '2024-06-20',
      'applications': 23,
    },
    {
      'id': '2',
      'title': 'House Cleaner',
      'company': 'HomeLinkGH',
      'location': 'Various locations in Accra',
      'salary': 'GHS 600-900/month',
      'type': 'Part-time',
      'category': 'Home Services',
      'description': 'Professional cleaning position. Flexible hours, work with families across Accra providing top-quality cleaning services.',
      'requirements': ['Experience in house cleaning', 'Reliable and trustworthy', 'Good communication skills', 'Available weekdays'],
      'posted': '2024-06-19',
      'applications': 45,
    },
    {
      'id': '3',
      'title': 'Customer Support Agent',
      'company': 'HomeLinkGH',
      'location': 'Accra Office',
      'salary': 'GHS 1000-1500/month',
      'type': 'Full-time',
      'category': 'Customer Service',
      'description': 'Help customers with booking inquiries, resolve issues, and ensure excellent service experience.',
      'requirements': ['Excellent English communication', 'Computer literacy', 'Problem-solving skills', 'Team player'],
      'posted': '2024-06-18',
      'applications': 67,
    },
    {
      'id': '4',
      'title': 'Restaurant Partner',
      'company': 'HomeLinkGH',
      'location': 'Accra, Kumasi, Tema',
      'salary': 'Commission-based',
      'type': 'Partnership',
      'category': 'Food & Restaurant',
      'description': 'Partner with us to expand your restaurant\'s reach. Increase sales through our food delivery platform.',
      'requirements': ['Valid restaurant license', 'Food safety certification', 'Reliable kitchen operation', 'Quality standards commitment'],
      'posted': '2024-06-17',
      'applications': 12,
    },
  ];
  
  static List<Map<String, dynamic>> applications = [];
  
  static bool applyForJob(String jobId, Map<String, dynamic> applicationData) {
    applicationData['id'] = DateTime.now().millisecondsSinceEpoch.toString();
    applicationData['jobId'] = jobId;
    applicationData['userId'] = UserManager.currentUser?['id'];
    applicationData['status'] = 'submitted';
    applicationData['appliedAt'] = DateTime.now().toIso8601String();
    applications.add(applicationData);
    
    // Update job application count
    var job = jobs.firstWhere((job) => job['id'] == jobId);
    job['applications'] = (job['applications'] as int) + 1;
    
    return true;
  }
}

class RestaurantManager {
  static List<Map<String, dynamic>> restaurants = [
    {
      'id': '1',
      'name': 'KFC East Legon',
      'cuisine': 'Fast Food',
      'rating': 4.5,
      'deliveryTime': '25-35 min',
      'deliveryFee': 'GHS 8',
      'location': 'East Legon, Accra',
      'image': 'kfc_logo.png',
      'popular': true,
      'menu': [
        {'name': 'Zinger Burger', 'price': 25, 'description': 'Spicy chicken burger'},
        {'name': 'Family Feast', 'price': 65, 'description': '8-piece chicken with sides'},
        {'name': 'Krushems', 'price': 12, 'description': 'Thick milkshake'},
      ]
    },
    {
      'id': '2',
      'name': 'Papaye Restaurant',
      'cuisine': 'Ghanaian',
      'rating': 4.7,
      'deliveryTime': '30-45 min',
      'deliveryFee': 'GHS 10',
      'location': 'Osu, Accra',
      'image': 'papaye_logo.png',
      'popular': true,
      'menu': [
        {'name': 'Jollof Rice & Chicken', 'price': 35, 'description': 'Traditional Ghanaian jollof with grilled chicken'},
        {'name': 'Banku & Tilapia', 'price': 40, 'description': 'Fresh tilapia with banku and pepper'},
        {'name': 'Fufu & Goat Soup', 'price': 45, 'description': 'Authentic Ghanaian dish'},
      ]
    },
    {
      'id': '3',
      'name': 'Dynasty Chinese Restaurant',
      'cuisine': 'Chinese',
      'rating': 4.4,
      'deliveryTime': '35-50 min',
      'deliveryFee': 'GHS 12',
      'location': 'Tema, Greater Accra',
      'image': 'dynasty_logo.png',
      'popular': false,
      'menu': [
        {'name': 'Sweet & Sour Chicken', 'price': 42, 'description': 'Crispy chicken in sweet sauce'},
        {'name': 'Beef Fried Rice', 'price': 38, 'description': 'Wok-fried rice with beef'},
        {'name': 'Spring Rolls', 'price': 18, 'description': 'Crispy vegetable spring rolls'},
      ]
    },
  ];
  
  static List<Map<String, dynamic>> orders = [];
  
  static String placeOrder(String restaurantId, List<Map<String, dynamic>> items, Map<String, dynamic> deliveryInfo) {
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();
    
    var restaurant = restaurants.firstWhere((r) => r['id'] == restaurantId);
    double total = items.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
    
    Map<String, dynamic> order = {
      'id': orderId,
      'userId': UserManager.currentUser?['id'],
      'restaurantId': restaurantId,
      'restaurantName': restaurant['name'],
      'items': items,
      'total': total,
      'deliveryFee': double.parse(restaurant['deliveryFee'].toString().replaceAll('GHS ', '')),
      'status': 'placed',
      'deliveryInfo': deliveryInfo,
      'estimatedTime': restaurant['deliveryTime'],
      'placedAt': DateTime.now().toIso8601String(),
    };
    
    orders.add(order);
    return orderId;
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToAuth();
  }

  _navigateToAuth() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFCE1126), // Ghana Red
              Color(0xFFFCD116), // Ghana Gold
              Color(0xFF006B3C), // Ghana Green
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.home_work,
                  size: 80,
                  color: Color(0xFF006B3C),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'HomeLinkGH',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 3),
                      blurRadius: 6,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              Text(
                'Connecting Ghana, One Home at a Time',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Authentication Screen
class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String userType = 'customer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF006B3C),
              Color(0xFF228B22),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 40),
                Icon(
                  Icons.home_work,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  'HomeLinkGH',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  isLogin ? 'Welcome Back!' : 'Create Account',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 40),
                
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (!isLogin) ...[
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (!isLogin && (value == null || value.isEmpty)) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          
                          TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (!isLogin && (value == null || value.isEmpty)) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          
                          Text('Account Type:', style: TextStyle(fontWeight: FontWeight.w600)),
                          SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: userType,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: [
                              DropdownMenuItem(value: 'customer', child: Text('Customer')),
                              DropdownMenuItem(value: 'provider', child: Text('Service Provider')),
                              DropdownMenuItem(value: 'job_seeker', child: Text('Job Seeker')),
                              DropdownMenuItem(value: 'diaspora', child: Text('Diaspora Member')),
                            ],
                            onChanged: (value) => setState(() => userType = value!),
                          ),
                          SizedBox(height: 16),
                        ],
                        
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (!isLogin && value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        
                        ElevatedButton(
                          onPressed: _handleAuth,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF006B3C),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            isLogin ? 'Sign In' : 'Create Account',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 16),
                        
                        TextButton(
                          onPressed: () => setState(() => isLogin = !isLogin),
                          child: Text(
                            isLogin 
                              ? 'Don\'t have an account? Sign Up'
                              : 'Already have an account? Sign In',
                            style: TextStyle(color: Color(0xFF006B3C)),
                          ),
                        ),
                        
                        if (isLogin) ...[
                          SizedBox(height: 16),
                          Text(
                            'Demo Accounts (for testing):',
                            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[600]),
                          ),
                          SizedBox(height: 8),
                          Text('Customer: customer@test.com / password', style: TextStyle(fontSize: 12)),
                          Text('Provider: provider@test.com / password', style: TextStyle(fontSize: 12)),
                          Text('Admin: admin@test.com / password', style: TextStyle(fontSize: 12)),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleAuth() {
    if (_formKey.currentState!.validate()) {
      if (isLogin) {
        // Try login
        bool success = UserManager.loginUser(_emailController.text, _passwordController.text);
        if (success) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid email or password')),
          );
        }
      } else {
        // Try registration
        Map<String, dynamic> userData = {
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'phone': _phoneController.text,
          'userType': userType,
        };
        
        bool success = UserManager.registerUser(userData);
        if (success) {
          UserManager.loginUser(_emailController.text, _passwordController.text);
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email already exists')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}

// Home Screen - Role Selection
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userType = UserManager.currentUser?['userType'] ?? 'customer';
    String userName = UserManager.currentUser?['name'] ?? 'User';
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFCE1126), // Ghana Red
              Color(0xFFFCD116), // Ghana Gold
              Color(0xFF006B3C), // Ghana Green
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Akwaaba, $userName! 🇬🇭',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Welcome to HomeLinkGH',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        UserManager.logout();
                        Navigator.pushReplacementNamed(context, '/auth');
                      },
                      icon: Icon(Icons.logout, color: Colors.white),
                    ),
                  ],
                ),
                
                SizedBox(height: 40),
                
                // App Logo
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
                SizedBox(height: 30),
                
                Text(
                  'Choose Your Experience',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                
                // Role Selection Cards
                Expanded(
                  child: Column(
                    children: [
                      _buildRoleCard(
                        context,
                        icon: Icons.restaurant_menu,
                        title: 'Food Delivery',
                        subtitle: 'Order from top Ghana restaurants',
                        route: '/customer',
                        page: 'food',
                      ),
                      SizedBox(height: 16),
                      _buildRoleCard(
                        context,
                        icon: Icons.home_repair_service,
                        title: 'Home Services',
                        subtitle: 'Book trusted home services',
                        route: '/customer',
                        page: 'services',
                      ),
                      SizedBox(height: 16),
                      _buildRoleCard(
                        context,
                        icon: Icons.work,
                        title: 'Find Jobs',
                        subtitle: 'Browse career opportunities',
                        route: '/jobs',
                        page: 'jobs',
                      ),
                      if (userType == 'provider') ...[
                        SizedBox(height: 16),
                        _buildRoleCard(
                          context,
                          icon: Icons.dashboard,
                          title: 'Provider Dashboard',
                          subtitle: 'Manage your services',
                          route: '/provider',
                          page: 'provider',
                        ),
                      ],
                      if (userType == 'diaspora') ...[
                        SizedBox(height: 16),
                        _buildRoleCard(
                          context,
                          icon: Icons.flight,
                          title: 'Diaspora Services',
                          subtitle: 'Plan your Ghana homecoming',
                          route: '/diaspora',
                          page: 'diaspora',
                        ),
                      ],
                    ],
                  ),
                ),
                
                SizedBox(height: 20),
                Text(
                  'Proudly Ghanaian 🇬🇭',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String route,
    required String page,
  }) {
    return GestureDetector(
      onTap: () {
        if (route == '/customer') {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CustomerApp(initialPage: page)));
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
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
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006B3C),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF006B3C),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// Customer App with Food Delivery
class CustomerApp extends StatefulWidget {
  final String initialPage;
  
  CustomerApp({this.initialPage = 'home'});
  
  @override
  _CustomerAppState createState() => _CustomerAppState();
}

class _CustomerAppState extends State<CustomerApp> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    
    _pages = [
      CustomerHomeScreen(),
      FoodDeliveryScreen(),
      ServicesScreen(),
      BookingsScreen(),
      CustomerProfileScreen(),
    ];
    
    // Set initial page based on parameter
    if (widget.initialPage == 'food') {
      _selectedIndex = 1;
    } else if (widget.initialPage == 'services') {
      _selectedIndex = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Color(0xFF006B3C),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Food'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class CustomerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userName = UserManager.currentUser?['name'] ?? 'User';
    
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeLinkGH'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF006B3C), Color(0xFF228B22)],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Akwaaba, $userName! 🇬🇭',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'What can we help you with today?',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // Quick Actions
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006B3C),
              ),
            ),
            SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    context,
                    'Order Food',
                    Icons.restaurant_menu,
                    Colors.orange,
                    () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CustomerApp(initialPage: 'food'))),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildQuickAction(
                    context,
                    'Book Service',
                    Icons.home_repair_service,
                    Colors.blue,
                    () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CustomerApp(initialPage: 'services'))),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 30),
            
            // Popular Services
            Text(
              'Popular Services',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006B3C),
              ),
            ),
            SizedBox(height: 16),
            
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildServiceCard('Food Delivery', Icons.restaurant, Colors.orange),
                _buildServiceCard('Cleaning', Icons.cleaning_services, Colors.blue),
                _buildServiceCard('Plumbing', Icons.plumbing, Colors.red),
                _buildServiceCard('Beauty', Icons.face, Colors.purple),
              ],
            ),
            
            SizedBox(height: 30),
            
            // Recent Activity
            Text(
              'Recent Bookings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006B3C),
              ),
            ),
            SizedBox(height: 16),
            
            ...BookingManager.getUserBookings().take(3).map((booking) => 
              _buildBookingCard(booking['serviceName'] ?? 'Service', 
                booking['status'] ?? 'pending', 
                booking['providerName'] ?? 'Provider', 
                _getStatusColor(booking['status']))).toList(),
            
            if (BookingManager.getUserBookings().isEmpty)
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'No bookings yet. Start by ordering food or booking a service!',
                    style: TextStyle(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF006B3C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(String service, String status, String provider, Color statusColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Provider: $provider',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'in_progress':
        return Colors.orange;
      case 'pending':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

// Food Delivery Screen
class FoodDeliveryScreen extends StatefulWidget {
  @override
  _FoodDeliveryScreenState createState() => _FoodDeliveryScreenState();
}

class _FoodDeliveryScreenState extends State<FoodDeliveryScreen> {
  String selectedCuisine = 'All';
  List<String> cuisines = ['All', 'Ghanaian', 'Fast Food', 'Chinese', 'Pizza'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Delivery'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Cuisine Filter
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: cuisines.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cuisines[index]),
                    selected: selectedCuisine == cuisines[index],
                    onSelected: (selected) {
                      setState(() => selectedCuisine = cuisines[index]);
                    },
                    selectedColor: Color(0xFF006B3C).withOpacity(0.2),
                    checkmarkColor: Color(0xFF006B3C),
                  ),
                );
              },
            ),
          ),
          
          // Restaurant List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: RestaurantManager.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = RestaurantManager.restaurants[index];
                
                // Filter by cuisine
                if (selectedCuisine != 'All' && restaurant['cuisine'] != selectedCuisine) {
                  return SizedBox.shrink();
                }
                
                return _buildRestaurantCard(context, restaurant);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(BuildContext context, Map<String, dynamic> restaurant) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant Header
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFF006B3C).withOpacity(0.1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Center(
              child: Icon(
                Icons.restaurant,
                size: 50,
                color: Color(0xFF006B3C),
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        restaurant['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF006B3C),
                        ),
                      ),
                    ),
                    if (restaurant['popular'])
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Popular',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  '${restaurant['cuisine']} • ${restaurant['location']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    Text(' ${restaurant['rating']}'),
                    SizedBox(width: 16),
                    Icon(Icons.access_time, size: 16, color: Colors.grey),
                    Text(' ${restaurant['deliveryTime']}'),
                    SizedBox(width: 16),
                    Icon(Icons.delivery_dining, size: 16, color: Colors.grey),
                    Text(' ${restaurant['deliveryFee']}'),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantMenuScreen(restaurant: restaurant),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF006B3C),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('View Menu'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Restaurant Menu Screen
class RestaurantMenuScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  
  RestaurantMenuScreen({required this.restaurant});

  @override
  _RestaurantMenuScreenState createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  List<Map<String, dynamic>> cartItems = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant['name']),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              if (cartItems.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(
                      restaurant: widget.restaurant,
                      cartItems: cartItems,
                    ),
                  ),
                );
              }
            },
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '${cartItems.fold(0, (sum, item) => sum + item['quantity'] as int)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Restaurant Info
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurant['name'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006B3C),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    Text(' ${widget.restaurant['rating']}'),
                    SizedBox(width: 16),
                    Icon(Icons.access_time, size: 16, color: Colors.grey),
                    Text(' ${widget.restaurant['deliveryTime']}'),
                    SizedBox(width: 16),
                    Icon(Icons.delivery_dining, size: 16, color: Colors.grey),
                    Text(' ${widget.restaurant['deliveryFee']}'),
                  ],
                ),
              ],
            ),
          ),
          
          // Menu Items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: widget.restaurant['menu'].length,
              itemBuilder: (context, index) {
                var menuItem = widget.restaurant['menu'][index];
                return _buildMenuItem(menuItem);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> menuItem) {
    int quantity = cartItems.where((item) => item['name'] == menuItem['name']).fold(0, (sum, item) => sum + item['quantity'] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menuItem['name'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006B3C),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  menuItem['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'GHS ${menuItem['price']}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFCD116),
                  ),
                ),
              ],
            ),
          ),
          
          // Add/Remove buttons
          if (quantity == 0)
            ElevatedButton(
              onPressed: () => _addToCart(menuItem),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF006B3C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Add'),
            )
          else
            Row(
              children: [
                IconButton(
                  onPressed: () => _removeFromCart(menuItem),
                  icon: Icon(Icons.remove_circle, color: Colors.red),
                ),
                Text(
                  '$quantity',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => _addToCart(menuItem),
                  icon: Icon(Icons.add_circle, color: Color(0xFF006B3C)),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _addToCart(Map<String, dynamic> menuItem) {
    setState(() {
      var existingItem = cartItems.where((item) => item['name'] == menuItem['name']).firstOrNull;
      if (existingItem != null) {
        existingItem['quantity']++;
      } else {
        cartItems.add({
          'name': menuItem['name'],
          'price': menuItem['price'],
          'quantity': 1,
        });
      }
    });
  }

  void _removeFromCart(Map<String, dynamic> menuItem) {
    setState(() {
      var existingItem = cartItems.where((item) => item['name'] == menuItem['name']).firstOrNull;
      if (existingItem != null) {
        existingItem['quantity']--;
        if (existingItem['quantity'] == 0) {
          cartItems.remove(existingItem);
        }
      }
    });
  }
}

// Cart Screen
class CartScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  final List<Map<String, dynamic>> cartItems;
  
  CartScreen({required this.restaurant, required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    double subtotal = widget.cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
    double deliveryFee = double.parse(widget.restaurant['deliveryFee'].toString().replaceAll('GHS ', ''));
    double total = subtotal + deliveryFee;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant Info
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.restaurant, color: Color(0xFF006B3C)),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.restaurant['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.restaurant['location'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Order Items
                  Text(
                    'Order Items',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006B3C),
                    ),
                  ),
                  SizedBox(height: 12),
                  
                  ...widget.cartItems.map((item) => Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${item['quantity']}x ${item['name']}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Text(
                          'GHS ${(item['price'] * item['quantity']).toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                  
                  SizedBox(height: 20),
                  
                  // Delivery Address
                  Text(
                    'Delivery Address',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006B3C),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      hintText: 'Enter your delivery address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    maxLines: 2,
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Special Instructions
                  Text(
                    'Special Instructions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006B3C),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      hintText: 'Any special requests...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(Icons.note),
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          
          // Order Summary
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal:', style: TextStyle(fontSize: 16)),
                    Text('GHS ${subtotal.toStringAsFixed(0)}', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Fee:', style: TextStyle(fontSize: 16)),
                    Text('GHS ${deliveryFee.toStringAsFixed(0)}', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'GHS ${total.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006B3C),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _placeOrder(total),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF006B3C),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Place Order - GHS ${total.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _placeOrder(double total) {
    if (_addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter delivery address')),
      );
      return;
    }

    String orderId = RestaurantManager.placeOrder(
      widget.restaurant['id'],
      widget.cartItems,
      {
        'address': _addressController.text,
        'notes': _notesController.text,
      },
    );

    // Create booking record
    BookingManager.createBooking({
      'serviceName': 'Food Delivery - ${widget.restaurant['name']}',
      'providerName': widget.restaurant['name'],
      'total': total,
      'type': 'food_delivery',
      'orderId': orderId,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order placed successfully! Order ID: $orderId'),
        backgroundColor: Color(0xFF006B3C),
      ),
    );

    Navigator.popUntil(context, ModalRoute.withName('/home'));
  }
}

// Services Screen (existing implementation)
class ServicesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> services = ServiceManager.services
    .where((service) => service['category'] == 'Home Services')
    .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Services'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return _buildServiceCard(context, service);
        },
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, Map<String, dynamic> service) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF006B3C).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.home_repair_service,
                size: 32,
                color: Color(0xFF006B3C),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service['name'] as String,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006B3C),
                    ),
                  ),
                  Text(
                    service['description'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        service['price'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFCD116),
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      Text(
                        ' ${service['rating']}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String bookingId = BookingManager.createBooking({
                  'serviceName': service['name'],
                  'providerName': 'Available Provider',
                  'serviceId': service['id'],
                });
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Service booked! Booking ID: $bookingId'),
                    backgroundColor: Color(0xFF006B3C),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF006B3C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Book'),
            ),
          ],
        ),
      ),
    );
  }
}

// Bookings Screen
class BookingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> userBookings = BookingManager.getUserBookings();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
      ),
      body: userBookings.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 80,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16),
                Text(
                  'No bookings yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Book a service or order food to see your bookings here',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: userBookings.length,
            itemBuilder: (context, index) {
              final booking = userBookings[index];
              return _buildBookingCard(booking);
            },
          ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    Color statusColor = _getStatusColor(booking['status']);
    
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  booking['serviceName'] ?? 'Service',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006B3C),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  booking['status'] ?? 'pending',
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          if (booking['providerName'] != null) ...[
            Row(
              children: [
                Icon(Icons.person, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text('Provider: ${booking['providerName']}'),
              ],
            ),
            SizedBox(height: 4),
          ],
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text('Booked: ${_formatDate(booking['createdAt'])}'),
            ],
          ),
          if (booking['total'] != null) ...[
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.monetization_on, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text('Total: GHS ${booking['total'].toStringAsFixed(0)}'),
              ],
            ),
          ],
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Color(0xFF006B3C),
                    side: BorderSide(color: Color(0xFF006B3C)),
                  ),
                  child: Text('View Details'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF006B3C),
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Contact Support'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'in_progress':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Unknown';
    try {
      DateTime date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'Unknown';
    }
  }
}

// Customer Profile Screen
class CustomerProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userName = UserManager.currentUser?['name'] ?? 'User';
    String userEmail = UserManager.currentUser?['email'] ?? 'user@example.com';
    String userPhone = UserManager.currentUser?['phone'] ?? 'N/A';
    String userType = UserManager.currentUser?['userType'] ?? 'customer';
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF006B3C),
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006B3C),
                    ),
                  ),
                  Text(
                    userEmail,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFF006B3C).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      userType.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF006B3C),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Bookings',
                    '${BookingManager.getUserBookings().length}',
                    Icons.calendar_today,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Total Spent',
                    'GHS ${BookingManager.getUserBookings().fold(0.0, (sum, booking) => sum + (booking['total'] ?? 0)).toStringAsFixed(0)}',
                    Icons.monetization_on,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 20),
            
            // Profile Options
            _buildProfileOption(Icons.edit, 'Edit Profile', () {}),
            _buildProfileOption(Icons.location_on, 'Manage Addresses', () {}),
            _buildProfileOption(Icons.payment, 'Payment Methods', () {}),
            _buildProfileOption(Icons.notifications, 'Notifications', () {}),
            _buildProfileOption(Icons.help, 'Help & Support', () {}),
            _buildProfileOption(Icons.info, 'About HomeLinkGH', () {}),
            _buildProfileOption(Icons.logout, 'Logout', () {
              UserManager.logout();
              Navigator.pushReplacementNamed(context, '/auth');
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: Color(0xFF006B3C)),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF006B3C),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF006B3C)),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

// Jobs Board
class JobsBoard extends StatefulWidget {
  @override
  _JobsBoardState createState() => _JobsBoardState();
}

class _JobsBoardState extends State<JobsBoard> {
  String selectedCategory = 'All';
  List<String> categories = ['All', 'Delivery', 'Home Services', 'Customer Service', 'Food & Restaurant'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Opportunities'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(categories[index]),
                    selected: selectedCategory == categories[index],
                    onSelected: (selected) {
                      setState(() => selectedCategory = categories[index]);
                    },
                    selectedColor: Color(0xFF006B3C).withOpacity(0.2),
                    checkmarkColor: Color(0xFF006B3C),
                  ),
                );
              },
            ),
          ),
          
          // Job Listings
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: JobManager.jobs.length,
              itemBuilder: (context, index) {
                var job = JobManager.jobs[index];
                
                // Filter by category
                if (selectedCategory != 'All' && job['category'] != selectedCategory) {
                  return SizedBox.shrink();
                }
                
                return _buildJobCard(context, job);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(BuildContext context, Map<String, dynamic> job) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    job['title'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006B3C),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFFCD116).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    job['type'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF006B3C),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              job['company'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(job['location'], style: TextStyle(color: Colors.grey[600])),
                SizedBox(width: 16),
                Icon(Icons.monetization_on, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(job['salary'], style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            SizedBox(height: 12),
            Text(
              job['description'],
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${job['applications']} applications',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetailsScreen(job: job),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF006B3C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Job Details Screen
class JobDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> job;
  
  JobDetailsScreen({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF006B3C).withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job['title'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006B3C),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    job['company'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 18, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(job['location']),
                      SizedBox(width: 20),
                      Icon(Icons.monetization_on, size: 18, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(job['salary']),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFF006B3C),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          job['type'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        '${job['applications']} applications',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24),
            
            // Job Description
            Text(
              'Job Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006B3C),
              ),
            ),
            SizedBox(height: 12),
            Text(
              job['description'],
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            
            SizedBox(height: 24),
            
            // Requirements
            Text(
              'Requirements',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006B3C),
              ),
            ),
            SizedBox(height: 12),
            ...job['requirements'].map<Widget>((requirement) => Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 20,
                    color: Color(0xFF006B3C),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      requirement,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: 32),
            
            // Apply Button
            ElevatedButton(
              onPressed: () => _showApplicationDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF006B3C),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Apply for this Job',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showApplicationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => JobApplicationDialog(job: job),
    );
  }
}

// Job Application Dialog
class JobApplicationDialog extends StatefulWidget {
  final Map<String, dynamic> job;
  
  JobApplicationDialog({required this.job});

  @override
  _JobApplicationDialogState createState() => _JobApplicationDialogState();
}

class _JobApplicationDialogState extends State<JobApplicationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _coverLetterController = TextEditingController();
  final _experienceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Apply for ${widget.job['title']}'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _coverLetterController,
                decoration: InputDecoration(
                  labelText: 'Cover Letter',
                  hintText: 'Tell us why you\'re perfect for this role...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a cover letter';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _experienceController,
                decoration: InputDecoration(
                  labelText: 'Relevant Experience',
                  hintText: 'Describe your relevant experience...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe your experience';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitApplication,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF006B3C),
            foregroundColor: Colors.white,
          ),
          child: Text('Submit Application'),
        ),
      ],
    );
  }

  void _submitApplication() {
    if (_formKey.currentState!.validate()) {
      bool success = JobManager.applyForJob(
        widget.job['id'],
        {
          'coverLetter': _coverLetterController.text,
          'experience': _experienceController.text,
        },
      );

      if (success) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Application submitted successfully!'),
            backgroundColor: Color(0xFF006B3C),
          ),
        );
      }
    }
  }
}

// Placeholder implementations for Provider, Admin, and Diaspora apps
class ProviderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Dashboard'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Provider Dashboard - Coming Soon'),
      ),
    );
  }
}

class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Admin Dashboard - Coming Soon'),
      ),
    );
  }
}

class DiasporaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diaspora Services'),
        backgroundColor: Color(0xFF006B3C),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Diaspora Services - Coming Soon'),
      ),
    );
  }
}