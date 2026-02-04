import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course.dart';

class RegisterCourseScreen extends StatefulWidget {
  final Course? course;

  const RegisterCourseScreen({super.key, this.course});

  @override
  State<RegisterCourseScreen> createState() => _RegisterCourseScreenState();
}

class _RegisterCourseScreenState extends State<RegisterCourseScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final idCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  String faculty = "ICT";
  String gender = "Male";
  String status = "Pending Approval";

  late Map<String, bool> courses;

  @override
  void initState() {
    super.initState();

    courses = {
      'Flutter Development': false,
      'Data Science Basics': false,
      'Web Development': false,
      'Graphic Design': false,
      'Digital Marketing': false,
      'Python Programming': false,
      'Cybersecurity Essentials': false,
      'Artificial Intelligence': false,
      'Cloud Computing': false,
      'Project Management': false,
    };

    if (widget.course != null && courses.containsKey(widget.course!.name)) {
      courses[widget.course!.name] = true;
    }
  }

  // ======================= PDF EXPORT =======================
  // ignore: unused_element
  Future<void> _exportPdf() async {
    final pdf = pw.Document();

    final selectedCourses =
        courses.entries.where((e) => e.value).map((e) => e.key).toList();

    const PdfColor themeColor = PdfColor.fromInt(0xFF010631);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (_) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  "Student Course Registration",
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                    color: themeColor,
                  ),
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Center(
                child: pw.Text(
                  "Academic Registration Form",
                  style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
                ),
              ),
              pw.SizedBox(height: 15),
              pw.Divider(),
              pw.SizedBox(height: 15),

              _sectionTitle("Student Details"),
              _infoRow("Name", nameCtrl.text),
              _infoRow("NIC", idCtrl.text),
              _infoRow("Phone", phoneCtrl.text),
              _infoRow("Email", emailCtrl.text),
              _infoRow("Gender", gender),
              _infoRow("Faculty", faculty),

              pw.SizedBox(height: 20),

              _sectionTitle("Registered Courses"),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey),
                columnWidths: {
                  0: const pw.FlexColumnWidth(1),
                  1: const pw.FlexColumnWidth(4),
                },
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: themeColor),
                    children: [
                      _tableHeader("No"),
                      _tableHeader("Course Name"),
                    ],
                  ),
                  ...selectedCourses.asMap().entries.map(
                        (e) => pw.TableRow(
                          children: [
                            _tableCell("${e.key + 1}"),
                            _tableCell(e.value),
                          ],
                        ),
                      ),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (_) async => pdf.save());
  }

  // ======================= SUBMIT =======================
  Future<void> _submitRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    final selectedCourses =
        courses.entries.where((e) => e.value).map((e) => e.key).toList();

    if (selectedCourses.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one course')),
      );
      return;
    }

    try {
      await Supabase.instance.client.from('students').insert({
        'name': nameCtrl.text.trim(),
        'student_id': idCtrl.text.trim(),
        'phone': phoneCtrl.text.trim(),
        'email': emailCtrl.text.trim(),
        'gender': gender,
        'faculty': faculty,
        'registered_courses': selectedCourses,
        'status': status,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Submitted Successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  // ======================= UI =======================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Registration",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color:Colors.white),),
        backgroundColor: const Color.fromARGB(255, 1, 6, 49),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _input("Name *", nameCtrl),
              _input("NIC *", idCtrl),
              _input("Phone Number", phoneCtrl, required: false),
              _input("Email *", emailCtrl),

              const SizedBox(height: 15),
              const Text("Gender"),

              /// SAFE & WORKING RADIO BUTTONS
              RadioListTile<String>(
                title: const Text("Male"),
                value: "Male",
                groupValue: gender,
                onChanged: (v) => setState(() => gender = v!),
              ),
              RadioListTile<String>(
                title: const Text("Female"),
                value: "Female",
                groupValue: gender,
                onChanged: (v) => setState(() => gender = v!),
              ),

              const SizedBox(height: 10),
              const Text("Select Courses"),

              ...courses.keys.map(
                (course) => CheckboxListTile(
                  title: Text(course),
                  value: courses[course],
                  onChanged: (v) =>
                      setState(() => courses[course] = v!),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitRegistration,
                  child: const Text("Submit"),
                ),
                
              ),

              Center(
                  child: ElevatedButton.icon(
                    onPressed: _exportPdf,
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text("Export PDF"),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(String label, TextEditingController ctrl,
      {bool required = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: ctrl,
        validator: (v) =>
            required && (v == null || v.trim().isEmpty) ? "Required" : null,
        decoration:
            const InputDecoration(border: OutlineInputBorder())
                .copyWith(labelText: label),
      ),
    );
  }
}

// ======================= PDF HELPERS =======================
pw.Widget _sectionTitle(String text) => pw.Padding(
  padding: const pw.EdgeInsets.symmetric(vertical: 6),
  child: pw.Text(
    text,
    style: pw.TextStyle(
      fontSize: 14,
      fontWeight: pw.FontWeight.bold,
    ),
  ),
);

pw.Widget _infoRow(String l, String v) => pw.Padding(
  padding: const pw.EdgeInsets.symmetric(vertical: 2),
  child: pw.Row(
    children: [
      pw.SizedBox(width: 120, child: pw.Text(l)),
      pw.Text(": $v"),
    ],
  ),
);

pw.Widget _tableHeader(String t) => pw.Padding(
  padding: const pw.EdgeInsets.all(6),
  child: pw.Text(
    t,
    style: pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.white,
    ),
  ),
);

pw.Widget _tableCell(String t) => pw.Padding(
  padding: const pw.EdgeInsets.all(6),
  child: pw.Text(t),
);
