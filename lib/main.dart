import 'package:flutter/material.dart';

class Produk {
  final String nama;
  final int harga;
  const Produk(this.nama, this.harga);
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const UtamaPage(),
        '/latihan1_tentang': (context) => const Latihan1Tentang(),
        '/latihan3_profil': (context) => const Latihan3Profil(),
        '/latihan3_detail': (context) => const Latihan3Detail(),
      },
    );
  }
}

class UtamaPage extends StatefulWidget {
  const UtamaPage({super.key});

  @override
  State<UtamaPage> createState() => _UtamaPageState();
}

class _UtamaPageState extends State<UtamaPage> {
  int _latihanAktif = 0;
  int _tabBottom = 0;

  final List<Produk> _produk = const [
    Produk('Laptop', 15000000),
    Produk('Mouse', 250000),
    Produk('Keyboard', 750000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_latihanAktif == 0
            ? 'Beranda'
            : _latihanAktif == 1
            ? 'Daftar Produk'
            : 'Named Routes (Halaman 1)'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert),
            onSelected: (val) => setState(() => _latihanAktif = val),
            itemBuilder: (context) => const [
              PopupMenuItem(value: 0, child: Text('Push & Pop')),
              PopupMenuItem(value: 1, child: Text('Kirim Data')),
              PopupMenuItem(value: 2, child: Text('Named Routes')),
            ],
          ),
        ],
      ),

      body: _buildBody(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabBottom,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _tabBottom = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cari'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_tabBottom == 1) {
      return const Center(child: Text('Tab Cari', style: TextStyle(fontSize: 20)));
    }
    if (_tabBottom == 2) {
      return const Center(child: Text('Tab Profil', style: TextStyle(fontSize: 20)));
    }

    if (_latihanAktif == 0) {
      //Push & Pop
      return Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/latihan1_tentang'),
          child: const Text('About Me'),
        ),
      );
    } else if (_latihanAktif == 1) {
      //Kirim Data
      return ListView.builder(
        itemCount: _produk.length,
        itemBuilder: (context, i) {
          final p = _produk[i];
          return ListTile(
            title: Text(p.nama),
            subtitle: Text('Rp ${p.harga}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DetailProdukPage(produk: p)),
            ),
          );
        },
      );
    } else {
      // Latihan 3
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ini Halaman 1',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/latihan3_profil'),
              child: const Text('Ke Halaman 2'),
            ),
          ],
        ),
      );
    }
  }
}

class Latihan1Tentang extends StatelessWidget {
  const Latihan1Tentang({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Kembali'),
        ),
      ),
    );
  }
}

class DetailProdukPage extends StatelessWidget {
  final Produk produk;
  const DetailProdukPage({super.key, required this.produk});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(produk.nama)),
      body: Center(
        child: Text(
          'Nama: ${produk.nama}\nHarga: Rp ${produk.harga}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class Latihan3Profil extends StatelessWidget {
  const Latihan3Profil({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman 2: Profil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ini Halaman 2',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/latihan3_detail',
                  arguments: 'Argumen dari Halaman Profil!',
                );
              },
              child: const Text('Ke Halaman 3'),
            ),
          ],
        ),
      ),
    );
  }
}

class Latihan3Detail extends StatelessWidget {
  const Latihan3Detail({super.key});
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as String? ?? 'Tidak ada argumen';

    return Scaffold(
      appBar: AppBar(title: const Text('Halaman 3: Detail')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Argumen Diterima:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text(
              arg,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}