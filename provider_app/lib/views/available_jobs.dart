import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../models/job.dart';
import '../services/job_service.dart';
import '../constants/service_types.dart';

class AvailableJobsScreen extends StatefulWidget {
  final List<String> providerServices;

  const AvailableJobsScreen({super.key, required this.providerServices});

  @override
  State<AvailableJobsScreen> createState() => _AvailableJobsScreenState();
}

class _AvailableJobsScreenState extends State<AvailableJobsScreen> {
  List<Job> availableJobs = [];
  bool isLoading = true;
  String selectedService = 'All';

  @override
  void initState() {
    super.initState();
    _loadAvailableJobs();
  }

  void _loadAvailableJobs() {
    JobService.getAvailableJobs(widget.providerServices).listen((jobs) {
      setState(() {
        availableJobs = jobs;
        isLoading = false;
      });
    });
  }

  List<Job> get filteredJobs {
    if (selectedService == 'All') return availableJobs;
    return availableJobs.where((job) => job.serviceType == selectedService).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Service Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('All'),
                ...widget.providerServices.map((service) => _buildFilterChip(service)),
              ],
            ),
          ),
          
          // Jobs List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredJobs.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.work_outline, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'No available jobs',
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            Text(
                              'New jobs will appear here when customers post requests',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          _loadAvailableJobs();
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: filteredJobs.length,
                          itemBuilder: (context, index) {
                            final job = filteredJobs[index];
                            return _buildJobCard(job);
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String service) {
    final isSelected = selectedService == service;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(service),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedService = service;
          });
        },
        backgroundColor: Colors.grey.shade200,
        selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
      ),
    );
  }

  Widget _buildJobCard(Job job) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with service type and price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(ServiceTypes.getIconForService(job.serviceType)),
                    const SizedBox(width: 8),
                    Text(
                      job.serviceType,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'GH₵${job.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Customer and description
            Text(
              'Customer: ${job.customerName}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              job.description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            
            // Location and date
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    job.address,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.schedule, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  DateFormat('MMM dd, yyyy - hh:mm a').format(job.scheduledDate),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            
            // Requirements
            if (job.requirements.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Text(
                'Requirements:',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              ...job.requirements.take(2).map((req) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text('• $req', style: const TextStyle(fontSize: 12)),
              )),
              if (job.requirements.length > 2)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    '+ ${job.requirements.length - 2} more',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
            ],
            
            const SizedBox(height: 12),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _showJobDetails(job),
                    child: const Text('View Details'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showApplyDialog(job),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showJobDetails(Job job) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${job.serviceType} Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Customer:', job.customerName),
              _buildDetailRow('Service:', job.serviceType),
              _buildDetailRow('Price:', 'GH₵${job.price.toStringAsFixed(0)}'),
              _buildDetailRow('Date:', DateFormat('MMM dd, yyyy - hh:mm a').format(job.scheduledDate)),
              _buildDetailRow('Location:', job.address),
              const SizedBox(height: 8),
              const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(job.description),
              if (job.requirements.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text('Requirements:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...job.requirements.map((req) => Text('• $req')),
              ],
              if (job.specialInstructions != null) ...[
                const SizedBox(height: 8),
                const Text('Special Instructions:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(job.specialInstructions!),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showApplyDialog(job);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _showApplyDialog(Job job) {
    final priceController = TextEditingController(text: job.price.toStringAsFixed(0));
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apply for Job'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Applying for: ${job.serviceType}'),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Your Price (GH₵)',
                prefixText: 'GH₵ ',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: messageController,
              decoration: const InputDecoration(
                labelText: 'Message to Customer',
                hintText: 'Tell them why you\'re the right choice...',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                final success = await JobService.applyForJob(
                  job.id,
                  user.uid,
                  double.tryParse(priceController.text) ?? job.price,
                  messageController.text,
                );
                
                Navigator.pop(context);
                
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Application submitted successfully!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to submit application or already applied')),
                  );
                }
              }
            },
            child: const Text('Submit Application'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}