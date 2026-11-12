
import 'package:flutter/material.dart';

void main() {
  runApp(const OhmApp());
}

class OhmApp extends StatelessWidget {
  const OhmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Hukum Ohm',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
        ),
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
      ),
      home: const OhmCalculatorPage(),
    );
  }
}

class OhmCalculatorPage extends StatefulWidget {
  const OhmCalculatorPage({super.key});

  @override
  State<OhmCalculatorPage> createState() =>
      _OhmCalculatorPageState();
}

class _OhmCalculatorPageState extends State<OhmCalculatorPage> {
  final TextEditingController voltageController =
      TextEditingController();

  final TextEditingController currentController =
      TextEditingController();

  final TextEditingController resistanceController =
      TextEditingController();

  String selectedMode = 'Tegangan (V)';
  String result = '';
  String formula = '';

  void calculate() {
    double? voltage = double.tryParse(
      voltageController.text.replaceAll(',', '.'),
    );

    double? current = double.tryParse(
      currentController.text.replaceAll(',', '.'),
    );

    double? resistance = double.tryParse(
      resistanceController.text.replaceAll(',', '.'),
    );

    double answer;

    setState(() {
      result = '';
      formula = '';

      if (selectedMode == 'Tegangan (V)') {
        if (current == null ||
            resistance == null ||
            current < 0 ||
            resistance < 0) {
          result = 'Masukkan arus dan hambatan yang valid!';
          return;
        }

        answer = current * resistance;

        formula =
            'V = I × R\n'
            'V = $current × $resistance';

        result =
            'Hasil Tegangan = ${answer.toStringAsFixed(2)} Volt';
      } else if (selectedMode == 'Arus (I)') {
        if (voltage == null ||
            resistance == null ||
            voltage < 0 ||
            resistance <= 0) {
          result =
              'Masukkan tegangan dan hambatan yang valid!';
          return;
        }

        answer = voltage / resistance;

        formula =
            'I = V ÷ R\n'
            'I = $voltage ÷ $resistance';

        result =
            'Hasil Arus = ${answer.toStringAsFixed(2)} Ampere';
      } else {
        if (voltage == null ||
            current == null ||
            voltage < 0 ||
            current <= 0) {
          result =
              'Masukkan tegangan dan arus yang valid!';
          return;
        }

        answer = voltage / current;

        formula =
            'R = V ÷ I\n'
            'R = $voltage ÷ $current';

        result =
            'Hasil Hambatan = ${answer.toStringAsFixed(2)} Ohm';
      }
    });
  }

  void reset() {
    setState(() {
      voltageController.clear();
      currentController.clear();
      resistanceController.clear();

      selectedMode = 'Tegangan (V)';
      result = '';
      formula = '';
    });
  }

  @override
  void dispose() {
    voltageController.dispose();
    currentController.dispose();
    resistanceController.dispose();
    super.dispose();
  }

  Widget inputField({
    required String label,
    required String symbol,
    required String unit,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Masukkan nilai $symbol',
          suffixText: unit,
          prefixIcon: Icon(
            Icons.electric_bolt,
            color: Colors.blue.shade700,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE2E8F0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Kalkulator Hukum Ohm',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // HEADER
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2563EB),
                    Color(0xFF1D4ED8),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(
                children: [
                  Icon(
                    Icons.electric_bolt,
                    color: Colors.white,
                    size: 55,
                  ),

                  SizedBox(height: 12),

                  Text(
                    'HUKUM OHM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'V = I × R',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Hitung tegangan, arus, dan hambatan '
                    'dengan mudah.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // RUMUS
            const Text(
              'Rumus Dasar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'V = I × R',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2563EB),
                      ),
                    ),

                    SizedBox(height: 12),

                    Text('V = Tegangan (Volt)'),
                    Text('I = Arus (Ampere)'),
                    Text('R = Hambatan (Ohm)'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // KALKULATOR
            const Text(
              'Kalkulator',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              color: Colors.white,
              elevation: 0,

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                  children: [

                    const Text(
                      'Pilih yang ingin dihitung:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    DropdownButtonFormField<String>(
                      value: selectedMode,

                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),

                      items: const [
                        DropdownMenuItem(
                          value: 'Tegangan (V)',
                          child: Text('Tegangan (V)'),
                        ),
                        DropdownMenuItem(
                          value: 'Arus (I)',
                          child: Text('Arus (I)'),
                        ),
                        DropdownMenuItem(
                          value: 'Hambatan (R)',
                          child: Text('Hambatan (R)'),
                        ),
                      ],

                      onChanged: (value) {
                        setState(() {
                          selectedMode = value!;
                          result = '';
                          formula = '';
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    if (selectedMode == 'Tegangan (V)') ...[
                      inputField(
                        label: 'Arus (I)',
                        symbol: 'I',
                        unit: 'A',
                        controller: currentController,
                      ),

                      inputField(
                        label: 'Hambatan (R)',
                        symbol: 'R',
                        unit: 'Ω',
                        controller: resistanceController,
                      ),
                    ],

                    if (selectedMode == 'Arus (I)') ...[
                      inputField(
                        label: 'Tegangan (V)',
                        symbol: 'V',
                        unit: 'V',
                        controller: voltageController,
                      ),

                      inputField(
                        label: 'Hambatan (R)',
                        symbol: 'R',
                        unit: 'Ω',
                        controller: resistanceController,
                      ),
                    ],

                    if (selectedMode == 'Hambatan (R)') ...[
                      inputField(
                        label: 'Tegangan (V)',
                        symbol: 'V',
                        unit: 'V',
                        controller: voltageController,
                      ),

                      inputField(
                        label: 'Arus (I)',
                        symbol: 'I',
                        unit: 'A',
                        controller: currentController,
                      ),
                    ],

                    const SizedBox(height: 8),

                    // TOMBOL HITUNG
                    ElevatedButton.icon(
                      onPressed: calculate,

                      icon: const Icon(
                        Icons.calculate,
                      ),

                      label: const Text(
                        'HITUNG',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // TOMBOL RESET
                    OutlinedButton.icon(
                      onPressed: reset,

                      icon: const Icon(
                        Icons.refresh,
                      ),

                      label: const Text('RESET'),

                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // HASIL
            if (result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFF2563EB),
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'HASIL PERHITUNGAN',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2563EB),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      result,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (formula.isNotEmpty)
                      Text(
                        formula,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                  ],
                ),
              ),

            const SizedBox(height: 30),

            const Center(
              child: Text(
                'Aplikasi Pembelajaran Fisika',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
