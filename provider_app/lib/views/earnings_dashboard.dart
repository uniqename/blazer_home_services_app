import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../models/job.dart';
import '../services/job_service.dart';

class EarningsDashboard extends StatefulWidget {
  const EarningsDashboard({super.key});

  @override
  State<EarningsDashboard> createState() => _EarningsDashboardState();
}

class _EarningsDashboardState extends State<EarningsDashboard> {
  List<Job> completedJobs = [];
  bool isLoading = true;
  String selectedPeriod = 'This Month';

  @override
  void initState() {
    super.initState();
    _loadEarningsData();
  }

  void _loadEarningsData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      JobService.getProviderJobs(user.uid).listen((jobs) {
        setState(() {
          completedJobs = jobs.where((job) => job.status == 'completed').toList();
          isLoading = false;
        });
      });
    }
  }

  List<Job> get filteredJobs {
    final now = DateTime.now();
    switch (selectedPeriod) {
      case 'Today':
        return completedJobs.where((job) => 
          job.scheduledDate.year == now.year &&
          job.scheduledDate.month == now.month &&
          job.scheduledDate.day == now.day
        ).toList();
      case 'This Week':
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        return completedJobs.where((job) => 
          job.scheduledDate.isAfter(weekStart)
        ).toList();
      case 'This Month':
        return completedJobs.where((job) => 
          job.scheduledDate.year == now.year &&
          job.scheduledDate.month == now.month
        ).toList();
      case 'All Time':
      default:
        return completedJobs;
    }
  }

  double get totalEarnings {
    return filteredJobs.fold(0.0, (sum, job) => sum + (job.price * 0.85)); // 15% platform fee
  }

  double get platformFees {
    return filteredJobs.fold(0.0, (sum, job) => sum + (job.price * 0.15));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Earnings Overview',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedPeriod,
                  onChanged: (value) {
                    setState(() {
                      selectedPeriod = value!;
                    });
                  },
                  items: ['Today', 'This Week', 'This Month', 'All Time']
                      .map((period) => DropdownMenuItem(
                            value: period,
                            child: Text(period),
                          ))
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Earnings Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildEarningsCard(
                    'Total Earnings',
                    'GH₵${totalEarnings.toStringAsFixed(2)}',
                    Colors.green,
                    Icons.account_balance_wallet,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildEarningsCard(
                    'Platform Fees',
                    'GH₵${platformFees.toStringAsFixed(2)}',
                    Colors.orange,
                    Icons.receipt,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildEarningsCard(
                    'Jobs Completed',
                    filteredJobs.length.toString(),
                    Colors.blue,
                    Icons.check_circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildEarningsCard(
                    'Avg per Job',
                    filteredJobs.isNotEmpty 
                        ? 'GH₵${(totalEarnings / filteredJobs.length).toStringAsFixed(0)}'
                        : 'GH₵0',
                    Colors.purple,
                    Icons.trending_up,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Completed Jobs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Completed Jobs',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Show all completed jobs
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Jobs List
            Expanded(
              child: filteredJobs.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.money_off, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No earnings yet',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Text(
                            'Complete jobs to start earning money',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredJobs.length,
                      itemBuilder: (context, index) {
                        final job = filteredJobs[index];
                        return _buildJobEarningCard(job);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsCard(String title, String value, Color color, IconData icon) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 24),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobEarningCard(Job job) {
    final grossAmount = job.price;
    final platformFee = grossAmount * 0.15;
    final netEarnings = grossAmount - platformFee;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.withValues(alpha: 0.2),
          child: const Icon(Icons.check_circle, color: Colors.green),
        ),
        title: Text('${job.serviceType} - ${job.customerName}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📍 ${job.address}'),
            Text('📅 ${DateFormat('MMM dd, yyyy').format(job.scheduledDate)}'),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Gross: GH₵${grossAmount.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(width: 8),
                Text(
                  'Fee: GH₵${platformFee.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 12, color: Colors.orange),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'GH₵${netEarnings.toStringAsFixed(0)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            const Text(
              'Net Earned',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
        onTap: () {
          _showEarningsBreakdown(job);
        },
      ),
    );
  }

  void _showEarningsBreakdown(Job job) {
    final grossAmount = job.price;
    final platformFee = grossAmount * 0.15;
    final netEarnings = grossAmount - platformFee;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${job.serviceType} Earnings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBreakdownRow('Service:', job.serviceType),
            _buildBreakdownRow('Customer:', job.customerName),
            _buildBreakdownRow('Date:', DateFormat('MMM dd, yyyy').format(job.scheduledDate)),
            const Divider(),
            _buildBreakdownRow('Gross Amount:', 'GH₵${grossAmount.toStringAsFixed(2)}'),
            _buildBreakdownRow('Platform Fee (15%):', '-GH₵${platformFee.toStringAsFixed(2)}'),
            const Divider(),
            _buildBreakdownRow(
              'Net Earnings:',
              'GH₵${netEarnings.toStringAsFixed(2)}',
              isTotal: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.green : null,
            ),
          ),
        ],
      ),
    );
  }
}