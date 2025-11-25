import 'package:flutter/material.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Pending Homework
        Text(
          'Pending Assignments',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildHomeworkCard(
          context,
          'Surah Al-Fatiha Memorization',
          'Due: Tomorrow',
          Icons.pending_actions,
          Colors.orange,
          isPending: true,
        ),
        const SizedBox(height: 12),
        _buildHomeworkCard(
          context,
          'Arabic Verb Conjugation Exercise',
          'Due: In 3 days',
          Icons.pending_actions,
          Colors.orange,
          isPending: true,
        ),
        const SizedBox(height: 24),

        // Completed Homework
        Text(
          'Completed',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildHomeworkCard(
          context,
          'Tajweed Rules Quiz',
          'Completed: 2 days ago',
          Icons.check_circle,
          Colors.green,
          isPending: false,
          score: 95,
        ),
        const SizedBox(height: 12),
        _buildHomeworkCard(
          context,
          'Islamic History Essay',
          'Completed: 5 days ago',
          Icons.check_circle,
          Colors.green,
          isPending: false,
          score: 88,
        ),
      ],
    );
  }

  Widget _buildHomeworkCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color, {
    required bool isPending,
    int? score,
  }) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Opening $title')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isPending && score != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$score%',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
