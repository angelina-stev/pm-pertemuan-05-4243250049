import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pm_pertemuan_05_4243250049/main.dart';

void main() {
  testWidgets('Tombol favorit mengubah ikon hati dan menampilkan SnackBar',
      (tester) async {
    await tester.pumpWidget(const UmkmKulinerApp());

    // Pastikan nama usaha dan menu tampil
    expect(find.text('Waroeng Deli Keladi'), findsOneWidget);
    expect(find.text('Mie Sop Kampung Medan'), findsOneWidget);

    // Sebelum ditekan, semua ikon masih favorite_border
    expect(find.byIcon(Icons.favorite), findsNothing);
    expect(find.byIcon(Icons.favorite_border), findsWidgets);

    // Gulir ke tombol favorit pertama lalu tekan
    final tombolPertama = find.byIcon(Icons.favorite_border).first;
    await tester.ensureVisible(tombolPertama);
    await tester.pumpAndSettle();
    await tester.tap(tombolPertama);
    await tester.pump();

    // Setelah ditekan, ikon berubah menjadi Icons.favorite dan SnackBar muncul
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.text('Mie Sop Kampung Medan ditambahkan ke favorit'),
        findsOneWidget);
  });
} 