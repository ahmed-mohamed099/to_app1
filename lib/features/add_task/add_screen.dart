


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home/home_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  TaskStatus _status = TaskStatus.pending;

  final List<Color> _colors = const [
    Color(0xFF4A90E2),
    Color(0xFF66AD5C),
    Color(0xFFF0A23A),
    Color(0xFF9C2FB0),
    Color(0xFFE5533D),
    Color(0xFF3F9488),
  ];
  int _selectedColor = 0;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      Task(
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        status: _status,
        color: _colors[_selectedColor],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F4FC),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Task', style: TextStyle(fontSize: 21.sp)),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(20.w),
            children: [
              _label('Task Title'),
              _field(
                controller: _titleController,
                hint: 'Design Login Screen',
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter a title'
                    : null,
              ),
              SizedBox(height: 22.h),
              _label('Description'),
              _field(
                controller: _descController,
                hint: 'Task Description...',
                maxLines: 5,
              ),
              SizedBox(height: 22.h),
              _label('Status'),
              _statusDropdown(),
              SizedBox(height: 22.h),
              _label('Choose Color'),
              _colorPicker(),
              SizedBox(height: 40.h),
              SizedBox(
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _saveTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF525A8C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    'Save Task',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: EdgeInsets.only(bottom: 10.h),
    child: Text(
      text,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
    ),
  );

  InputDecoration _decoration({String? hint}) => InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(fontSize: 15.sp, color: Colors.grey.shade600),
    filled: true,
    fillColor: Colors.white,
    contentPadding:
    EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide.none,
    ),
  );

  Widget _field({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: TextStyle(fontSize: 15.sp),
      decoration: _decoration(hint: hint),
    );
  }

  Widget _statusDropdown() {
    return DropdownButtonFormField<TaskStatus>(
      value: _status,
      decoration: _decoration(),
      borderRadius: BorderRadius.circular(14.r),
      icon: Icon(Icons.arrow_drop_down, size: 24.sp),
      items: TaskStatus.values
          .map((s) => DropdownMenuItem(
        value: s,
        child: Text(s.label, style: TextStyle(fontSize: 16.sp)),
      ))
          .toList(),
      onChanged: (v) => setState(() => _status = v!),
    );
  }

  Widget _colorPicker() {
    return Wrap(
      spacing: 14.w,
      runSpacing: 10.h,
      children: List.generate(_colors.length, (i) {
        final selected = i == _selectedColor;
        return GestureDetector(
          onTap: () => setState(() => _selectedColor = i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: _colors[i],
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? Colors.black87 : Colors.transparent,
                width: 2.5,
              ),
            ),
            child: selected
                ? Icon(Icons.check, color: Colors.white, size: 20.sp)
                : null,
          ),
        );
      }),
    );
  }
}