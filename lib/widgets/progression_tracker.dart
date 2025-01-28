import 'package:flutter/material.dart';

// Custom color scheme
class AppColors {
  static const primary = Color(0xFF2563eb);    // Blue
  static const secondary = Color(0xFF22c55e);  // Green
  static const accent = Color(0xFFf97316);     // Orange
  static const charcoal = Color(0xFF1f2937);   // Deep Charcoal
  static const lightGray = Color(0xFFF3F4F6);  // Light Gray
}

class ExerciseLevel {
  final String name;
  final bool completed;
  final bool current;
  final Map<String, String> requirements;

  ExerciseLevel({
    required this.name,
    this.completed = false,
    this.current = false,
    required this.requirements,
  });
}

class ProgressionTracker extends StatelessWidget {
  final String exerciseName;
  final List<ExerciseLevel> levels;

  ProgressionTracker({
    super.key,
    required this.exerciseName,
    required this.levels,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise Title
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.lightGray),
              ),
            ),
            child: Text(
              exerciseName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.charcoal,
              ),
            ),
          ),
          // Levels List
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: levels.length,
            itemBuilder: (context, index) {
              final level = levels[index];
              return _buildLevelCard(level, index == levels.length - 1);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard(ExerciseLevel level, bool isLast) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Icon Column with Connection Line
          Column(
            children: [
              _buildStatusIcon(level),
              if (!isLast)
                Container(
                  width: 2,
                  height: 40,
                  color: AppColors.lightGray,
                  margin: EdgeInsets.symmetric(vertical: 8),
                ),
            ],
          ),
          SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Level Name
                Text(
                  level.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: level.current
                        ? AppColors.primary
                        : level.completed
                            ? AppColors.secondary
                            : AppColors.charcoal,
                  ),
                ),
                SizedBox(height: 8),
                // Requirements Grid
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: level.requirements.entries.map((entry) {
                    return _buildRequirement(entry.key, entry.value);
                  }).toList(),
                ),
              ],
            ),
          ),
          // Action Button
          if (level.current)
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text('Start'),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(ExerciseLevel level) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: level.completed
            ? AppColors.secondary
            : level.current
                ? AppColors.primary
                : AppColors.lightGray,
      ),
      child: Icon(
        level.completed ? Icons.check : Icons.circle_outlined,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildRequirement(String key, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$key: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.charcoal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

// Example usage
class ExerciseProgressionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pullUpLevels = [
      ExerciseLevel(
        name: 'Dead Hangs',
        completed: true,
        requirements: {
          'Hold Time': '30-60s',
          'Sets': '3-4',
          'Rest': '60s',
          'Criteria': 'Hold for 60s for all sets',
        },
      ),
      ExerciseLevel(
        name: 'Scapular Pulls',
        completed: true,
        requirements: {
          'Reps': '5-8',
          'Sets': '3-4',
          'Rest': '90s',
          'Criteria': '8 reps for all sets',
        },
      ),
      ExerciseLevel(
        name: 'Negative Pull-ups',
        current: true,
        requirements: {
          'Tempo': '4s negative',
          'Reps': '5-8',
          'Sets': '3-4',
          'Rest': '120s',
          'Criteria': '8 controlled negatives',
        },
      ),
      ExerciseLevel(
        name: 'Band-Assisted Pull-ups',
        requirements: {
          'Reps': '8-12',
          'Sets': '3-4',
          'Rest': '120s',
          'Criteria': '12 reps with light band',
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Progression'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: ProgressionTracker(
          exerciseName: 'Pull-up Progression',
          levels: pullUpLevels,
        ),
      ),
    );
  }
}
