import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  DateTime selectedMonth = DateTime.now();
  bool showHomeworkBanner = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Homework overdue banner
        if (showHomeworkBanner) _buildHomeworkBanner(context),
        if (showHomeworkBanner) const SizedBox(height: 16),

        // Month selector
        _buildMonthSelector(context),
        const SizedBox(height: 20),

        // Next Lesson section
        _buildSectionHeader(context, 'Next Lesson'),
        const SizedBox(height: 12),
        _buildNextLesson(context),

        const SizedBox(height: 24),

        // This Week section
        _buildSectionHeader(context, 'This Week'),
        const SizedBox(height: 12),
        _buildLessonCard(
          context,
          'Wed, 6:00 PM',
          'Memorization',
          'Rescheduled',
          isRescheduled: true,
        ),

        const SizedBox(height: 24),

        // Next Week section
        _buildSectionHeader(context, 'Next Week'),
        const SizedBox(height: 12),
        _buildLessonCard(
          context,
          'Tue, 6:00 PM',
          'Memorization',
          null,
        ),

        const SizedBox(height: 24),

        // All Lessons button
        _buildAllLessonsButton(context),

        const SizedBox(height: 100), // Space for bottom nav
      ],
    );
  }

  Widget _buildHomeworkBanner(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.black87,
                ),
                children: [
                  const TextSpan(
                    text: 'Homework ',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: '2 days overdue',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening homework...')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Solve',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              setState(() {
                showHomeworkBanner = false;
              });
            },
            child: Icon(Icons.close, size: 22, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthSelector(BuildContext context) {
    final theme = Theme.of(context);
    final monthName = DateFormat('MMMM yyyy').format(selectedMonth);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              monthName,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, color: Colors.blue, size: 24),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  selectedMonth = DateTime(
                    selectedMonth.year,
                    selectedMonth.month - 1,
                  );
                });
              },
              icon: Icon(Icons.chevron_left, color: Colors.blue),
              visualDensity: VisualDensity.compact,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  selectedMonth = DateTime(
                    selectedMonth.year,
                    selectedMonth.month + 1,
                  );
                });
              },
              icon: Icon(Icons.chevron_right, color: Colors.blue),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);

    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildNextLesson(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2196F3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/avatar.png'), // Use actual image
            child: Container(), // Placeholder
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tue, 6:00 PM',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Memorization',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.95),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Upcoming - Starting in 5 min',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard(
    BuildContext context,
    String time,
    String subject,
    String? status, {
    bool isRescheduled = false,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: AssetImage('assets/avatar.png'), // Use actual image
            child: Container(), // Placeholder
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subject,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                if (status != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    status,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isRescheduled ? Colors.orange : Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllLessonsButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Showing all lessons...')),
          );
        },
        icon: const Icon(Icons.filter_list, size: 18),
        label: const Text('All Lessons'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF212121),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
