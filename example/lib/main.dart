import 'package:flutter/material.dart';
import 'package:nibss_bank_logo_generator/nibss_bank_logo_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NIBSS Bank Logo Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BankListScreen(),
    );
  }
}

class BankListScreen extends StatefulWidget {
  const BankListScreen({super.key});

  @override
  State<BankListScreen> createState() => _BankListScreenState();
}

class _BankListScreenState extends State<BankListScreen> {
  // Sample bank list fetched (simulating NIBSS fetch response)
  final List<Map<String, String>> _sampleBanks = [
    {
      "institutionCode": "000014",
      "institutionName": "ACCESS BANK",
    },
    {
      "institutionCode": "000005",
      "institutionName": "ACCESS BANK PLC (DIAMOND)",
    },
    {
      "institutionCode": "000015",
      "institutionName": "ZENITH BANK PLC",
    },
    {
      "institutionCode": "100034",
      "institutionName": "Zenth Easy Wallet",
    },
    {
      "institutionCode": "100004",
      "institutionName": "OPAY DIGITAL SERVICES LIMITED",
    },
    {
      "institutionCode": "120001",
      "institutionName": "9 payment service Bank",
    },
    {
      "institutionCode": "090364",
      "institutionName": "Nuture MFB",
    },
    {
      "institutionCode": "999999",
      "institutionName": "Unknown Bank (Fallback Demo)",
    },
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter banks by name or code based on search query
    final filteredBanks = _sampleBanks.where((bank) {
      final name = bank['institutionName']!.toLowerCase();
      final code = bank['institutionCode']!.toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || code.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('NIBSS Bank Logos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by Bank Name or Code',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredBanks.length,
              itemBuilder: (context, index) {
                final bank = filteredBanks[index];
                final code = bank['institutionCode']!;
                final name = bank['institutionName']!;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(4),
                      // 1. Loading the logo widget by institution code
                      child: NibssBankLogo.getLogoByBankCode(
                        code,
                        fit: BoxFit.contain,
                      ),
                    ),
                    title: Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Code: $code'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      _showDetailsDialog(context, name, code);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, String name, String code) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Institution Code: $code'),
              const SizedBox(height: 20),
              // Show logo using Name lookup
              const Text(
                'Logo resolved by Name:',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                // 2. Loading the logo widget by name
                child: NibssBankLogo.getLogoByBankName(
                  name,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
