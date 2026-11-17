import 'package:flutter/material.dart';

void main() {
  runApp(const TraderApp());
}

class TraderApp extends StatelessWidget {
  const TraderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMC Trader Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: const TraderHome(),
    );
  }
}

class TraderHome extends StatefulWidget {
  const TraderHome({super.key});

  @override
  State<TraderHome> createState() => _TraderHomeState();
}

class _TraderHomeState extends State<TraderHome> {
  int tab = 0;
  bool closed = false;

  Widget metric(String label, String value) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tradeCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Example option trade',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text('Instrument: NIFTY CALL — illustrative only'),
            const Text('Expiry / strike: not selected'),
            const Text('Sample entry premium: ₹120'),
            const Text('Sample stop premium: ₹115'),
            const Text('Sample target premium: ₹135'),
            const Text('Reward:risk before costs: 3:1'),
            const Text('Quantity: not selected'),
            const Text('Live price: not connected'),
            const Text('P&L: unavailable without market data'),
            const SizedBox(height: 12),
            Text(
              closed
                  ? 'Demo status: closed'
                  : 'Demo status: open',
            ),
            const SizedBox(height: 12),
            const Text(
              'Example strategy checklist — not detected:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              'Liquidity sweep → demand-zone retest → '
              'bullish displacement → structure confirmation.',
            ),
            const SizedBox(height: 12),
            const Text(
              'This is a static example. No strategy has '
              'analysed live data or verified this setup.',
            ),
            if (!closed)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      closed = true;
                    });
                  },
                  child: const Text('Close demo card — no order sent'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Card(
            color: Color(0xFF493B12),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'DEMO ONLY\n'
                'No live data, broker connection or real orders.',
              ),
            ),
          ),
          Row(
            children: [
              metric('Demo capital', '₹25,000'),
              metric('Live P&L', 'Not connected'),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Requested risk settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('Maximum trades: 3 per day'),
          const Text('Planned risk budget: ₹125 per trade'),
          const Text('Planned daily loss limit: ₹375'),
          const Text('Desired reward:risk: 3:1 before costs'),
          const SizedBox(height: 8),
          const Text(
            'Settings are display-only in this demo. '
            '₹500 daily profit is not guaranteed. '
            'Actual lot size, costs and stop distance '
            'may make a trade exceed the risk budget.',
          ),
          const SizedBox(height: 16),
          tradeCard(),
        ],
      ),
      ListView(
        padding: const EdgeInsets.all(12),
        children: [
          tradeCard(),
        ],
      ),
      const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Charts are not connected yet.\n\n'
            'Real index and option-strike charts require '
            'verified market data. This demo does not '
            'show invented prices as live charts.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('SMC Trader Demo'),
      ),
      body: pages[tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (value) {
          setState(() {
            tab = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long),
            label: 'Trade details',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart),
            label: 'Charts',
          ),
        ],
      ),
    );
  }
}
