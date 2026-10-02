


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../add_task/add_screen.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final File? profileImage;

  const HomeScreen({super.key, this.name = 'Guest', this.profileImage});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color primary = Color(0xFF3F51B5);

  final List<Task> _tasks = [
    const Task(
      title: 'Flutter UI',
      description: 'Build Register Screen',
      status: TaskStatus.pending,
      color: Color(0xFF4A90E2),
    ),
    const Task(
      title: 'Workout',
      description: 'Gym at 6 PM',
      status: TaskStatus.done,
      color: Color(0xFF66AD5C),
    ),
    const Task(
      title: 'Meeting',
      description: 'Team Sync',
      status: TaskStatus.inProgress,
      color: Color(0xFFF0A23A),
    ),
    const Task(
      title: 'Read Book',
      description: 'Atomic Habits',
      status: TaskStatus.pending,
      color: Color(0xFF9C2FB0),
    ),
  ];

  int get _doneCount => _tasks.where((t) => t.status == TaskStatus.done).length;
  int get _pendingCount => _tasks.length - _doneCount;

  Future<void> _openAddTask() async {
    final newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (_) => const AddTaskScreen()),
    );
    if (newTask != null) {
      setState(() => _tasks.add(newTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddTask,
        backgroundColor: const Color(0xFFE3E4FB),
        foregroundColor: primary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        icon: Icon(Icons.add, size: 22.sp),
        label: Text(
          'Task',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 90.h),
          children: [
            _buildHeader(),
            SizedBox(height: 24.h),
            _buildStatsCard(),
            SizedBox(height: 28.h),
            Text(
              "Today's Tasks",
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1C1C1E),
              ),
            ),
            SizedBox(height: 16.h),
            ..._tasks.map((task) => TaskCard(task: task, onTap: () {})),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 28.r,
          backgroundColor: primary,
          backgroundImage: widget.profileImage != null
              ? FileImage(widget.profileImage!)
              : null,
          child: widget.profileImage == null
              ? Icon(Icons.person, color: Colors.white, size: 26.sp)
              : null,
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning 👋',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
              ),
              SizedBox(height: 2.h),
              Text(
                widget.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1C1C1E),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_none, size: 26.sp),
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 22.h),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem('${_tasks.length}', 'Tasks'),
          _statItem('$_doneCount', 'Done'),
          _statItem('$_pendingCount', 'Pending'),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(fontSize: 13.sp, color: Colors.white70),
        ),
      ],
    );
  }
}

// ===================== Task Model =====================

enum TaskStatus { pending, inProgress, done }

extension TaskStatusLabel on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.done:
        return 'Done';
    }
  }
}

class Task {
  final String title;
  final String description;
  final TaskStatus status;
  final Color color;

  const Task({
    required this.title,
    required this.description,
    required this.status,
    required this.color,
  });
}

// ===================== Task Card =====================

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const TaskCard({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 12.w, 16.h),
            child: Row(
              children: [
                // Colored side bar
                Container(
                  width: 8.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: task.color,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1C1C1E),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        task.description.isEmpty ? '—' : task.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      _StatusChip(status: task.status, color: task.color),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, size: 28.sp, color: Colors.black87),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final TaskStatus status;
  final Color color;

  const _StatusChip({required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}