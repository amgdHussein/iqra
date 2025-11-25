import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Overall Progress Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Overall Progress',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: 0.68,
                        strokeWidth: 12,
                        backgroundColor: theme.colorScheme.surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation(
                          theme.colorScheme.primary,
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '68%',
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            Text(
                              'Complete',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Stats Grid
        Text(
          'Statistics',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                '24',
                'Lessons Completed',
                Icons.check_circle,
                Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                '18',
                'Assignments Done',
                Icons.assignment_turned_in,
                Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                '92%',
                'Average Score',
                Icons.star,
                Colors.amber,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                '45',
                'Study Hours',
                Icons.access_time,
                Colors.purple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Recent Activities
        Text(
          'Recent Activity',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildActivityItem(
          context,
          'Completed Tajweed Quiz',
          '2 hours ago',
          Icons.quiz,
          Colors.green,
        ),
        _buildActivityItem(
          context,
          'Started Arabic Lesson 5',
          '1 day ago',
          Icons.play_circle,
          Colors.blue,
        ),
        _buildActivityItem(
          context,
          'Submitted History Essay',
          '3 days ago',
          Icons.upload,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    String title,
    String time,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  time,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
