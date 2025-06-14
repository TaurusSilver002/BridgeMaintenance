
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/mcdays_bloc.dart';
import '../bloc/mcdays_event.dart';
import '../bloc/mcdays_state.dart';
import 'package:intl/intl.dart';

class MaintenanceDate extends StatefulWidget {
  const MaintenanceDate({super.key});

  @override
  State<MaintenanceDate> createState() => _MaintenanceDateState();
}

class _MaintenanceDateState extends State<MaintenanceDate> {
  @override
  void initState() {
    super.initState();
    context.read<McDaysBloc>().add(FetchPredictions());
  }
  String formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintenance Predictions'),
      ),
      body: BlocBuilder<McDaysBloc, McDaysState>(
        builder: (context, state) {
          if (state is McDaysLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          if (state is McDaysError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<McDaysBloc>().add(FetchPredictions());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          
          if (state is McDaysLoaded) {            if (state.predictions.isEmpty) {
              return const Center(
                child: Text('No predictions available'),
              );
            }
              return SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.predictions.length,
                itemBuilder: (context, index) {                final prediction = state.predictions[index];
                final daysToMaintain = prediction.daysToMaintain.toString();
                final predictedDate = prediction.predictedMaintenanceDate;
                final createdAt = prediction.createdAt;
                final id = prediction.id.toString();
                  return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 16),
                        Text(
                          '$daysToMaintain Days to Maintain',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [                            _buildInfoRow(
                              'Predicted Date',
                              formatDate(predictedDate),
                              Icons.event,
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              'Created',
                              formatDate(createdAt),
                              Icons.access_time,
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              'Percentile',
                              '${(prediction.percentile * 100).toStringAsFixed(1)}%',
                              Icons.analytics,
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              'ID',
                              '#$id',
                              Icons.tag,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );              },
            ),
            );
          }
          
          return const Center(
            child: Text('No predictions available'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<McDaysBloc>().add(FetchPredictions());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}