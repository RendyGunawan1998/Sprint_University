import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sprint University',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nilaiCont = TextEditingController();

  List<String> nilaiPembulatan = [];

  List<String> listNilaiMurid(List<int> grades) {
    List<String> result = [];
    for (int grade in grades) {
      if (grade < 38) {
        result.add(grade.toString());
      } else {
        int nextMultipleOfFive = (grade / 5).ceil() * 5;
        if (nextMultipleOfFive - grade < 3) {
          result.add(nextMultipleOfFive.toString());
        } else {
          result.add(grade.toString());
        }
      }
    }
    return result;
  }

  void doTheGrade() {
    if (formKey.currentState!.validate()) {
      List<int> grades = nilaiCont.text
          .split(',')
          .map((grade) => int.tryParse(grade.trim()) ?? 0)
          .toList();

      setState(() {
        nilaiPembulatan = listNilaiMurid(grades);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Grading Students'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Input nilai siswa (pisahkan dengan koma):',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nilaiCont,
                decoration: InputDecoration(
                  hintText: 'Cth : 24, 50, 19, 98',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please input 1 value';
                  }

                  return null;
                },
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: doTheGrade,
                  child: Text('Proses Nilai'),
                ),
              ),
              SizedBox(height: 16),
              if (nilaiPembulatan.isNotEmpty) ...[
                Text(
                  'Hasil Pembulatan Nilai:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Output: $nilaiPembulatan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
                // nilaiPembulatan
                //     .map((x) => Text(
                //           'Output: ${x.toString()}',
                //           style: TextStyle(
                //               fontSize: 16, fontWeight: FontWeight.bold),
                //         ))
                //     .toList(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
