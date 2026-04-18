import 'package:cloud_firestore/cloud_firestore.dart';

class SeedData {
  static Future<void> pushDummyMedicines() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    List<Map<String, dynamic>> dummyMedicines = [
      {
        'name': 'Dolo 650',
        'price': 30,
        'description': 'Used for fever and mild to moderate pain relief.',
        'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500&q=80',
        'stock': 50,
      },
      {
        'name': 'Crocin Pain Relief',
        'price': 45,
        'description': 'Targeted relief for headache, backache, and body pain.',
        'image': 'https://images.unsplash.com/photo-1550572017-edb9b470bf75?w=500&q=80',
        'stock': 20,
      },
      {
        'name': 'Volini Spray',
        'price': 150,
        'description': 'Pain relief spray for muscle and joint pain.',
        'image': 'https://plus.unsplash.com/premium_photo-1675715924046-24ba0dae40e6?w=500&q=80',
        'stock': 0, // Out of stock example
      },
      {
        'name': 'Digene Antacid',
        'price': 120,
        'description': 'Relief from acidity and gas.',
        'image': 'https://images.unsplash.com/photo-1471864190281-a93a3070b6de?w=500&q=80',
        'stock': 15,
      },
      {
        'name': 'Vicks Vaporub',
        'price': 85,
        'description': 'Provides relief from cold and cough.',
        'image': 'https://images.unsplash.com/photo-1628771065518-0d82f1938462?w=500&q=80',
        'stock': 30,
      },
    ];

    for (var med in dummyMedicines) {
      await firestore.collection('medicines').add(med);
    }
  }
}
