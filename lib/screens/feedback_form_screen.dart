import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedbackFormScreen extends StatefulWidget {
  final Map<String, dynamic>? feedback;

  const FeedbackFormScreen({super.key, this.feedback});

  @override
  State<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final messageCtrl = TextEditingController();
  String requestType = "Feedback";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.feedback != null) {
      nameCtrl.text = widget.feedback!['name'] ?? '';
      messageCtrl.text = widget.feedback!['message'] ?? '';
      requestType = widget.feedback!['request_type'] ?? 'Feedback';
    }
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final data = {
      'name': nameCtrl.text.trim(),
      'request_type': requestType,
      'message': messageCtrl.text.trim(),
    };

    final supabase = Supabase.instance.client;

    try {
      if (widget.feedback == null) {
        await supabase.from('student_feedback').insert(data);
      } else {
        await supabase
            .from('student_feedback')
            .update(data)
            .eq('id', widget.feedback!['id']);
      }
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving feedback: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.feedback == null ? "Add Feedback" : "Edit Feedback",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 6, 49),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: "Student Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: requestType,
                items: const [
                  DropdownMenuItem(value: "Feedback", child: Text("Feedback")),
                  DropdownMenuItem(value: "Request", child: Text("Request")),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => requestType = value);
                  }
                },
                decoration: const InputDecoration(
                  labelText: "Request Type",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: messageCtrl,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Message",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter a message";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 1, 6, 49),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                        widget.feedback == null ? "Submit" : "Update",
                        style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
}
