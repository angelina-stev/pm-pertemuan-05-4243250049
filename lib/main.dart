import 'package:flutter/material.dart';
// Jika sudah menjalankan 'flutter pub add material_ui', ganti baris di atas menjadi:
// import 'package:material_ui/material_ui.dart';

void main() => runApp(const UmkmKulinerApp());

class UmkmKulinerApp extends StatefulWidget {
  const UmkmKulinerApp({super.key});

  @override
  State<UmkmKulinerApp> createState() => _UmkmKulinerAppState();
}

class _UmkmKulinerAppState extends State<UmkmKulinerApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _gantiTema() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Satu-satunya warna hardcoded adalah seedColor sesuai spesifikasi
    const warnaDasar = Color(0xFFB3261E);

    return MaterialApp(
      title: 'Waroeng Deli Keladi',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: warnaDasar,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: warnaDasar,
          brightness: Brightness.dark,
        ),
      ),
      home: HalamanMenuUmkm(
        isDark: _themeMode == ThemeMode.dark,
        onToggleTema: _gantiTema,
      ),
    );
  }
}

class HalamanMenuUmkm extends StatelessWidget {
  const HalamanMenuUmkm({
    super.key,
    required this.isDark,
    required this.onToggleTema,
  });

  final bool isDark;
  final VoidCallback onToggleTema;

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;

    const daftarMenu = [
      (
        nama: 'Mie Sop Kampung Medan',
        harga: 'Rp 18.000',
        kategori: 'Makanan Berat',
      ),
      (
        nama: 'Bolu Gulung Keladi Keju',
        harga: 'Rp 35.000',
        kategori: 'Oleh-Oleh',
      ),
      (
        nama: 'Martabak Piring Keladi',
        harga: 'Rp 15.000',
        kategori: 'Cemilan',
      ),
      (
        nama: 'Es Teh Tarik Medan',
        harga: 'Rp 12.000',
        kategori: 'Minuman',
      ),
      (
        nama: 'Jus Martabe Segar',
        harga: 'Rp 14.000',
        kategori: 'Minuman',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu UMKM Medan'),
        actions: [
          // Komponen Material 3 #1: IconButton
          IconButton(
            tooltip: 'Ganti Tema Terang/Gelap',
            onPressed: onToggleTema,
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bagian Kepala: Gambar banner, nama usaha, dan deskripsi
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800',
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 170,
                  color: skema.primaryContainer,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.restaurant,
                    size: 56,
                    color: skema.onPrimaryContainer,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Waroeng Deli Keladi',
              style: teks.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Sajian kuliner khas Medan dengan olahan keladi pilihan dan racikan rempah autentik sejak 2019.',
              style: teks.bodyMedium?.copyWith(color: skema.onSurfaceVariant),
            ),
            const SizedBox(height: 16),

            // Bagian Kontak: Card + 3 ListTile
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.location_on_outlined, color: skema.primary),
                    title: const Text('Jl. Williem Iskandar No. 45, Medan'),
                    subtitle: const Text('Buka setiap hari, 09.00 - 22.00 WIB'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.phone_outlined, color: skema.primary),
                    title: const Text('+62 813-7000-4243'),
                    subtitle: const Text('Telepon & WhatsApp Pesanan'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.storefront_outlined, color: skema.primary),
                    title: const Text('@waroengdelikeladi'),
                    subtitle: const Text('Tersedia di GrabFood & GoFood'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Komponen Material 3 #2 & #3: FilledButton.icon & OutlinedButton.icon
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Menghubungkan ke WhatsApp kasir...'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                    label: const Text('Pesan Sekarang'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Lokasi disalin ke clipboard'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.map_outlined),
                    label: const Text('Petunjuk Arah'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text(
              'Daftar Menu Andalan',
              style: teks.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Daftar Menu (StatelessWidget KartuMenu)
            for (final item in daftarMenu)
              KartuMenu(
                nama: item.nama,
                harga: item.harga,
                kategori: item.kategori,
              ),
            const SizedBox(height: 64),
          ],
        ),
      ),
      // Komponen Material 3 #4: FloatingActionButton
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Promo Mahasiswa UNIMED: Diskon 10% di kasir!'),
            ),
          );
        },
        icon: const Icon(Icons.local_offer_outlined),
        label: const Text('Promo'),
      ),
    );
  }
}

// Widget buatan sendiri (Stateless) untuk menampilkan setiap item menu
class KartuMenu extends StatelessWidget {
  const KartuMenu({
    super.key,
    required this.nama,
    required this.harga,
    required this.kategori,
  });

  final String nama;
  final String harga;
  final String kategori;

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nama, style: teks.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    harga,
                    style: teks.bodyMedium?.copyWith(
                      color: skema.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Komponen Material 3 #5: Chip
                  Chip(
                    label: Text(kategori, style: teks.labelSmall),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            // Hanya bagian tombol favorit yang Stateful
            TombolFavorit(namaMenu: nama),
          ],
        ),
      ),
    );
  }
}

// Widget Stateful kecil khusus tombol ikon hati
class TombolFavorit extends StatefulWidget {
  const TombolFavorit({super.key, required this.namaMenu});

  final String namaMenu;

  @override
  State<TombolFavorit> createState() => _TombolFavoritState();
}

class _TombolFavoritState extends State<TombolFavorit> {
  bool _favorit = false;

  void _toggleFavorit() {
    setState(() {
      _favorit = !_favorit;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Text(
            _favorit
                ? '${widget.namaMenu} ditambahkan ke favorit'
                : '${widget.namaMenu} dihapus dari favorit',
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;

    return IconButton(
      tooltip: 'Tandai Favorit',
      onPressed: _toggleFavorit,
      icon: Icon(
        _favorit ? Icons.favorite : Icons.favorite_border,
        color: _favorit ? skema.primary : skema.onSurfaceVariant,
      ),
    );
  }
}