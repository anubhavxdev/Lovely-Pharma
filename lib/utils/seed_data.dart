import 'package:cloud_firestore/cloud_firestore.dart';

class SeedData {
  static String getMedicineImage(String name, String category) {
    final Map<String, String> keywordImages = {
      'dolo': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500&q=80',
      'crocin': 'https://images.unsplash.com/photo-1580281657527-47f249e8f8c9?w=500&q=80',
      'brufen': 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=500&q=80',
      'volini': 'https://images.unsplash.com/photo-1597764699510-12cfe56e2d3c?w=500&q=80',
      'moov': 'https://images.unsplash.com/photo-1611930022073-b7a4ba5fcccd?w=500&q=80',
      'band': 'https://images.unsplash.com/photo-1603398938378-e54eab446dde?w=500&q=80',
      'dettol': 'https://images.unsplash.com/photo-1584515933487-779824d29309?w=500&q=80',
      'savlon': 'https://images.unsplash.com/photo-1607619056574-7b8d3ee536b2?w=500&q=80',
      'vicks': 'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=500&q=80',
      'benadryl': 'https://images.unsplash.com/photo-1628771065518-0d82f1938462?w=500&q=80',
      'sinarest': 'https://images.unsplash.com/photo-1580281657527-47f249e8f8c9?w=500&q=80',
      'boroline': 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?w=500&q=80',
      'cetaphil': 'https://images.unsplash.com/photo-1620912189866-3c0dcbebca9f?w=500&q=80',
      'glucon': 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?w=500&q=80',
      'electral': 'https://images.unsplash.com/photo-1588776814546-ec7e8e66b1d7?w=500&q=80',
    };

    for (var key in keywordImages.keys) {
      if (name.toLowerCase().contains(key)) {
        return keywordImages[key]!;
      }
    }

    final categoryImages = {
      'Pain Relief': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500&q=80',
      'First Aid': 'https://images.unsplash.com/photo-1603398938378-e54eab446dde?w=500&q=80',
      'Cold/Cough': 'https://images.unsplash.com/photo-1628771065518-0d82f1938462?w=500&q=80',
      'Skin Care': 'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?w=500&q=80',
      'Energy': 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?w=500&q=80',
    };
    return categoryImages[category]!;
  }

  static Future<void> pushDummyMedicines() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    List<Map<String, dynamic>> dummyMedicines = [
      {
        'name': 'Dolo 650 Tablet',
        'price': 30,
        'description': 'Used for relief from fever and mild to moderate pain like headache or toothache.',
        'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 120,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'Volini Pain Relief Gel 50g',
        'price': 145,
        'description': 'Quick acting formula for relief from muscle pain, backache, and joint pain.',
        'image': 'https://images.unsplash.com/photo-1616671285410-0906a244464c?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 85,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'Vicks Vaporub 25ml',
        'price': 95,
        'description': 'Relieves cough, nasal congestion, body ache, headache, and muscle stiffness.',
        'image': 'https://images.unsplash.com/photo-1628771065518-0d82f1938462?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 110,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Cetaphil Gentle Cleanser',
        'price': 330,
        'description': 'A mild, soap-free cleanser that hydrates and soothes skin as it cleanses.',
        'image': 'https://images.unsplash.com/photo-1556228578-8c7c2f2330d2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 40,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Glucon-D Orange 500g',
        'price': 210,
        'description': 'Provides instant energy with Vitamin C and Calcium for tiredness and fatigue.',
        'image': 'https://images.unsplash.com/photo-1543362906-acfc16c623a2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 65,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Dettol Antiseptic Liquid 250ml',
        'price': 120,
        'description': 'Standard antiseptic for first aid, surface cleaning, and personal hygiene.',
        'image': 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 140,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Saridon Headache Tablet',
        'price': 42,
        'description': 'A triple action formula that provides effective relief from severe headaches.',
        'image': 'https://images.unsplash.com/photo-1631549916768-4119b2e5f926?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 95,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'Moov Strong Gel',
        'price': 165,
        'description': 'Ayurvedic pain relief ointment for back pain and inflammation.',
        'image': 'https://images.unsplash.com/photo-1563453392212-326f5e854473?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 0,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'Honitus Cough Syrup 100ml',
        'price': 115,
        'description': 'Herbal cough remedy that provides effective relief without drowsiness.',
        'image': 'https://images.unsplash.com/photo-1550573105-df27957ba4fd?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 55,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Crocin Pain Relief 15 Tab',
        'price': 65,
        'description': 'Contains Paracetamol and Caffeine for faster pain relief from tough headaches.',
        'image': 'https://images.unsplash.com/photo-1626285861696-9f0bf5a49c6d?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 130,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'Hansaplast Bandage 10s',
        'price': 40,
        'description': 'Medicated pads for covering small cuts and protecting wounds from bacteria.',
        'image': 'https://images.unsplash.com/photo-1598300188704-5f830aecd00c?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 200,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Electral ORS Powder 21g',
        'price': 22,
        'description': 'WHO-based ORS formula to restore body fluids and electrolytes during dehydration.',
        'image': 'https://images.unsplash.com/photo-1607619056574-7b8d3ee536b2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 150,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Revital H Daily Health Capsule',
        'price': 550,
        'description': 'Daily health supplement with Ginseng and Vitamins for physical and mental energy.',
        'image': 'https://images.unsplash.com/photo-1616671285410-0906a244464c?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 35,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Boroline Antiseptic Cream',
        'price': 45,
        'description': 'Night repair cream for dry skin, cracked lips, and minor cuts.',
        'image': 'https://images.unsplash.com/photo-1552046122-03184de85e08?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 90,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Zandu Balm 25ml',
        'price': 85,
        'description': 'India’s No. 1 pain relief balm for headaches, cold and backache.',
        'image': 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 110,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'Benadryl DR Syrup 100ml',
        'price': 148,
        'description': 'Soothing relief for dry cough and throat irritation.',
        'image': 'https://images.unsplash.com/photo-1587854692152-cbe660dbbb88?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 45,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Nivea Soft Cream 200ml',
        'price': 399,
        'description': 'Highly effective, intensive moisturizing cream for soft and supple skin.',
        'image': 'https://images.unsplash.com/photo-1580913209249-041432f7a93a?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 30,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Cotton Wool Roll 100g',
        'price': 65,
        'description': 'Absorbent surgical cotton wool for cleaning wounds and application of medication.',
        'image': 'https://images.unsplash.com/photo-1583947581924-860bda6a26df?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 75,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Red Bull Energy Drink 250ml',
        'price': 125,
        'description': 'Vitalizes body and mind; ideal for intense focus and long working hours.',
        'image': 'https://images.unsplash.com/photo-1596412911305-950f1f337a6c?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 100,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Betadine 10% Ointment 20g',
        'price': 130,
        'description': 'Antiseptic microbicide for the prevention and treatment of infection in wounds.',
        'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 50,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Amoxicillin 500mg Capsule',
        'price': 105,
        'description': 'Penicillin-type antibiotic used to treat a wide variety of bacterial infections.',
        'image': 'https://images.unsplash.com/photo-1471864190281-ad5fe9bb0720?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 25,
        'category': 'Cold/Cough',
        'requiresPrescription': true
      },
      {
        'name': 'Savlon Antiseptic Liquid 1L',
        'price': 285,
        'description': 'Disinfectant liquid that provides protection against infection from germs.',
        'image': 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 40,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Neurobion Forte 30 Tab',
        'price': 38,
        'description': 'Vitamin B complex supplement for nerve health and energy levels.',
        'image': 'https://images.unsplash.com/photo-1585435557343-3b092031a831?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 140,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Himalaya Neem Face Wash',
        'price': 185,
        'description': 'Soap-free herbal formulation that clears impurities and helps clear pimples.',
        'image': 'https://images.unsplash.com/photo-1612817288484-6f916006741a?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 60,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Vicks Inhaler',
        'price': 62,
        'description': 'Provides quick relief from nasal congestion due to colds and allergies.',
        'image': 'https://images.unsplash.com/photo-1603398938378-e54eab446f91?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 125,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Augmentin 625 Duo',
        'price': 201,
        'description': 'Strong antibiotic used for bacterial infections of the lungs, ears, and skin.',
        'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 18,
        'category': 'Pain Relief',
        'requiresPrescription': true
      },
      {
        'name': 'Lactocalamine Lotion 120ml',
        'price': 210,
        'description': 'Oil balance lotion for oily skin to prevent acne and skin irritation.',
        'image': 'https://images.unsplash.com/photo-1608248597279-f99d160bfcbc?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 55,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Crepe Bandage 10cm',
        'price': 180,
        'description': 'High quality elastic bandage for providing support to sprains and strains.',
        'image': 'https://images.unsplash.com/photo-1583947581924-860bda6a26df?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 0,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Horlicks Chocolate 500g',
        'price': 260,
        'description': 'Health drink mix clinically proven to support immunity and growth.',
        'image': 'https://images.unsplash.com/photo-1550989460-0adf9ea622e2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 42,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Dermicool Prickly Heat Powder',
        'price': 110,
        'description': 'Provides instant cooling relief from prickly heat and burning sensations.',
        'image': 'https://images.unsplash.com/photo-1556229010-6c3f2c9ca5f8?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 90,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Cofsil Throat Lozenges',
        'price': 35,
        'description': 'Ginger and Lemon flavored drops to soothe sore throat and cough.',
        'image': 'https://images.unsplash.com/photo-1628771065518-0d82f1938462?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 180,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Ativan 2mg Tablet',
        'price': 140,
        'description': 'Prescribed for short-term relief of severe anxiety symptoms.',
        'image': 'https://images.unsplash.com/photo-1471864190281-ad5fe9bb0720?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 12,
        'category': 'Pain Relief',
        'requiresPrescription': true
      },
      {
        'name': 'Soframycin Skin Cream',
        'price': 55,
        'description': 'Antibiotic skin cream used for treating infected wounds and burns.',
        'image': 'https://images.unsplash.com/photo-1552046122-03184de85e08?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 88,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Bournvita Health Drink 750g',
        'price': 340,
        'description': 'Power-packed nutrition drink for growth and muscle development.',
        'image': 'https://images.unsplash.com/photo-1550989460-0adf9ea622e2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 50,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Brufen 400mg Tablet',
        'price': 25,
        'description': 'Anti-inflammatory medicine used for period pain and joint aches.',
        'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 115,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'Garnier Charcoal Mask',
        'price': 99,
        'description': 'Tissue mask enriched with charcoal to purify and hydrate skin.',
        'image': 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 70,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Alex Cough Syrup 100ml',
        'price': 155,
        'description': 'Formula specifically designed for the suppression of dry hacking cough.',
        'image': 'https://images.unsplash.com/photo-1587854692152-cbe660dbbb88?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 38,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Thermometer Digital',
        'price': 225,
        'description': 'Highly accurate digital thermometer for fever measurement at home.',
        'image': 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 25,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Monster Energy Drink',
        'price': 110,
        'description': 'High caffeine energy beverage for extreme focus and stamina.',
        'image': 'https://images.unsplash.com/photo-1622484210800-478531102900?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 80,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Becosules Capsules 20s',
        'price': 52,
        'description': 'Multivitamin with Vitamin C for metabolism and skin health.',
        'image': 'https://images.unsplash.com/photo-1607619056574-7b8d3ee536b2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 150,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Strepsils Ginger 10s',
        'price': 45,
        'description': 'Double action sore throat relief with warm soothing ginger.',
        'image': 'https://images.unsplash.com/photo-1628771065518-0d82f1938462?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 190,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Combiflam 20 Tablets',
        'price': 48,
        'description': 'Combination of Paracetamol and Ibuprofen for strong body pain relief.',
        'image': 'https://images.unsplash.com/photo-1471864190281-ad5fe9bb0720?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 145,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'Dettol Handwash 750ml',
        'price': 189,
        'description': 'Effective protection against 100 illness-causing germs.',
        'image': 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 55,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Vaseline Petroleum Jelly',
        'price': 90,
        'description': 'Triple-purified jelly that locks in moisture for dry skin recovery.',
        'image': 'https://images.unsplash.com/photo-1552046122-03184de85e08?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 110,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Pediasure Vanilla 400g',
        'price': 720,
        'description': 'Complete balanced nutrition for children to support growth.',
        'image': 'https://images.unsplash.com/photo-1550989460-0adf9ea622e2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 35,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Pudin Hara Capsules 10s',
        'price': 25,
        'description': 'Natural herbal remedy for stomach ache, gas, and indigestion.',
        'image': 'https://images.unsplash.com/photo-1607619056574-7b8d3ee536b2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 160,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'Otrivin Nasal Spray',
        'price': 98,
        'description': 'Works in 2 minutes to provide relief from blocked nose.',
        'image': 'https://images.unsplash.com/photo-1603398938378-e54eab446f91?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 75,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': ' Johnson Baby Powder 200g',
        'price': 175,
        'description': 'Safe and soft powder to keep skin dry and smooth.',
        'image': 'https://images.unsplash.com/photo-1556229010-6c3f2c9ca5f8?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 60,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Omnigel 30g Tube',
        'price': 115,
        'description': 'Diclofenac gel for quick relief from neck and joint inflammation.',
        'image': 'https://images.unsplash.com/photo-1563453392212-326f5e854473?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 85,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'Epsom Salt 200g',
        'price': 80,
        'description': 'Used for muscle relaxation baths and soothing tired feet.',
        'image': 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 40,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Red Label Natural Care Tea',
        'price': 195,
        'description': 'Tea leaves infused with 5 ayurvedic herbs to boost immunity.',
        'image': 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 120,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Glycerin 50ml',
        'price': 45,
        'description': 'Pure moisturizer used to treat dry, rough, and itchy skin.',
        'image': 'https://images.unsplash.com/photo-1552046122-03184de85e08?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 0,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Zandu Vigorex Capsules',
        'price': 310,
        'description': 'Ayurvedic supplement with Ashwagandha for vitality and strength.',
        'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 30,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Karvol Plus Inhalant',
        'price': 85,
        'description': 'Decongestant capsules for inhalation to clear severe nasal blockage.',
        'image': 'https://images.unsplash.com/photo-1607619056574-7b8d3ee536b2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 95,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Tramadol 50mg Tablet',
        'price': 180,
        'description': 'Opioid pain medication used to treat moderate to severe pain.',
        'image': 'https://images.unsplash.com/photo-1471864190281-ad5fe9bb0720?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 15,
        'category': 'Pain Relief',
        'requiresPrescription': true
      },
      {
        'name': 'Surgical Mask N95',
        'price': 50,
        'description': 'High filtration mask for protection against air pollutants and germs.',
        'image': 'https://images.unsplash.com/photo-1584483766114-2cea6facdf57?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 140,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Dabur Honey 500g',
        'price': 225,
        'description': '100% pure honey used as a natural sweetener and immunity booster.',
        'image': 'https://images.unsplash.com/photo-1587049352846-4a222e784d38?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 100,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Ponds Light Moisturiser',
        'price': 240,
        'description': 'Non-oily formula with Vitamin E and Glycerine for soft skin glow.',
        'image': 'https://images.unsplash.com/photo-1601049541289-9b1b7bbbfe19?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 65,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Vicks Cough Drops 25s',
        'price': 50,
        'description': 'Ayurvedic medicine to clear throat irritation and dry cough.',
        'image': 'https://images.unsplash.com/photo-1628771065518-0d82f1938462?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 150,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Alcohol Swabs 100s',
        'price': 190,
        'description': 'Individually wrapped sterile pads for skin preparation before injections.',
        'image': 'https://images.unsplash.com/photo-1583947215259-38e31be8751f?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 40,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Gatorade Blue 500ml',
        'price': 60,
        'description': 'Sports drink that replenishes electrolytes and provides energy.',
        'image': 'https://images.unsplash.com/photo-1622484210800-478531102900?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 85,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Meftal Spas Tablet',
        'price': 50,
        'description': 'Specifically designed to reduce abdominal cramps and period pain.',
        'image': 'https://images.unsplash.com/photo-1471864190281-ad5fe9bb0720?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 130,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'Olay Night Cream 50g',
        'price': 899,
        'description': 'Anti-aging cream that renews skin while you sleep.',
        'image': 'https://images.unsplash.com/photo-1590156221170-cc398d0f4d7c?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 22,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Ascoril LS Syrup 100ml',
        'price': 118,
        'description': 'Expectorant used for clearing mucus in chesty coughs.',
        'image': 'https://images.unsplash.com/photo-1550573105-df27957ba4fd?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 50,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Digital B.P. Monitor',
        'price': 1850,
        'description': 'Automated blood pressure monitor for easy tracking at home.',
        'image': 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 15,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Maltova Health Drink',
        'price': 245,
        'description': 'Caramel flavored nutrition powder for active energy.',
        'image': 'https://images.unsplash.com/photo-1550989460-0adf9ea622e2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 60,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Aspirin 75mg Tablet',
        'price': 15,
        'description': 'Blood thinner used to prevent heart attacks and strokes.',
        'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 140,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'Hand Sanitizer 500ml',
        'price': 250,
        'description': 'Contains 70% alcohol for instant germ-free hands.',
        'image': 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 110,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Sunsilk Shampoo 180ml',
        'price': 160,
        'description': 'Nourishing shampoo for long and healthy hair growth.',
        'image': 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 75,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Torex Cough Syrup',
        'price': 95,
        'description': 'Effective for dry and allergic cough with minimal sedation.',
        'image': 'https://images.unsplash.com/photo-1587854692152-cbe660dbbb88?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 45,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Bournvita Lil Champs',
        'price': 295,
        'description': 'Designed specifically for toddler nutritional needs.',
        'image': 'https://images.unsplash.com/photo-1550989460-0adf9ea622e2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 30,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Diclofenac Sodium Gel',
        'price': 85,
        'description': 'Topical treatment for localized pain and swelling.',
        'image': 'https://images.unsplash.com/photo-1563453392212-326f5e854473?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 90,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'First Aid Plastic Box',
        'price': 450,
        'description': 'Empty compact storage box for home medical supplies.',
        'image': 'https://images.unsplash.com/photo-1583947215259-38e31be8751f?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 20,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Aveeno Daily Lotion',
        'price': 950,
        'description': 'Prebiotic oat formula that locks in moisture for 24 hours.',
        'image': 'https://images.unsplash.com/photo-1608248597279-f99d160bfcbc?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 15,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Cetzine 10mg Tablet',
        'price': 20,
        'description': 'Used to treat allergic symptoms like sneezing and runny nose.',
        'image': 'https://images.unsplash.com/photo-1607619056574-7b8d3ee536b2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 140,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'ORS Liquid Apple 200ml',
        'price': 35,
        'description': 'Ready to drink electrolyte solution with apple flavor.',
        'image': 'https://images.unsplash.com/photo-1622484210800-478531102900?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 100,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Tiger Balm Red 21ml',
        'price': 75,
        'description': 'Extra strength warm ointment for sore muscles and joints.',
        'image': 'https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 110,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'Band-Aid Tough Strips',
        'price': 120,
        'description': 'Heavy duty fabric strips for superior protection and adhesion.',
        'image': 'https://images.unsplash.com/photo-1598300188704-5f830aecd00c?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 50,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Neutrogena Sunscreen SPF50',
        'price': 650,
        'description': 'Ultra-sheer dry-touch sunblock for broad-spectrum protection.',
        'image': 'https://images.unsplash.com/photo-1556228852-6d35a585d566?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 40,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Grilinctus Syrup 100ml',
        'price': 135,
        'description': 'Combination syrup for both wet and dry cough relief.',
        'image': 'https://images.unsplash.com/photo-1550573105-df27957ba4fd?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 25,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Xanax 0.5mg Tablet',
        'price': 190,
        'description': 'Used to treat anxiety and panic disorders by calming nerves.',
        'image': 'https://images.unsplash.com/photo-1471864190281-ad5fe9bb0720?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 10,
        'category': 'Pain Relief',
        'requiresPrescription': true
      },
      {
        'name': 'Complan Kesar Badam 500g',
        'price': 320,
        'description': 'Nutritional drink with 34 vital nutrients for growth.',
        'image': 'https://images.unsplash.com/photo-1550989460-0adf9ea622e2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 45,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Povidone Iodine Spray',
        'price': 220,
        'description': 'Spray-on antiseptic for infection control in minor cuts.',
        'image': 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 35,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Mamaearth Vitamin C Face Cream',
        'price': 599,
        'description': 'Brightens skin tone and fights signs of aging naturally.',
        'image': 'https://images.unsplash.com/photo-1612817288484-6f916006741a?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 28,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Solvin Cold Tablet',
        'price': 45,
        'description': 'Relieves symptoms of common cold like sinus congestion.',
        'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 110,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Disprin Regular 10 Tab',
        'price': 12,
        'description': 'Effervescent pain relief for quick action against headaches.',
        'image': 'https://images.unsplash.com/photo-1607619056574-7b8d3ee536b2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 150,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'Glucon-D Nimbu Pani 500g',
        'price': 205,
        'description': 'Lemon flavored instant energy drink powder.',
        'image': 'https://images.unsplash.com/photo-1543362906-acfc16c623a2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 70,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Surgical Tape 1 inch',
        'price': 45,
        'description': 'Hypoallergenic tape used to hold dressings and bandages.',
        'image': 'https://images.unsplash.com/photo-1583947581924-860bda6a26df?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 95,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Loreal Revitalift Cream',
        'price': 1250,
        'description': 'Advanced anti-wrinkle and firming cream with Pro-Retinol.',
        'image': 'https://images.unsplash.com/photo-1590156221170-cc398d0f4d7c?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 12,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Ascoril D Junior Syrup',
        'price': 88,
        'description': 'Safe cough suppressant designed for children.',
        'image': 'https://images.unsplash.com/photo-1550573105-df27957ba4fd?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 40,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Paracetamol 500mg 100 Tab',
        'price': 120,
        'description': 'Bulk pack for fever and mild body ache relief.',
        'image': 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 20,
        'category': 'Pain Relief',
        'requiresPrescription': false
      },
      {
        'name': 'ORS Soda Flavor 200ml',
        'price': 38,
        'description': 'Effervescent electrolyte drink for fast hydration.',
        'image': 'https://images.unsplash.com/photo-1622484210800-478531102900?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 65,
        'category': 'Energy',
        'requiresPrescription': false
      },
      {
        'name': 'Cotton Balls 50s Pack',
        'price': 55,
        'description': 'Soft and absorbent cotton for skincare and cleaning.',
        'image': 'https://images.unsplash.com/photo-1583947581924-860bda6a26df?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 130,
        'category': 'First Aid',
        'requiresPrescription': false
      },
      {
        'name': 'Garnier Men Acne Face Wash',
        'price': 225,
        'description': 'Clears acne-causing bacteria and excess oil.',
        'image': 'https://images.unsplash.com/photo-1612817288484-6f916006741a?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 55,
        'category': 'Skin Care',
        'requiresPrescription': false
      },
      {
        'name': 'Mucinex 600mg Tablet',
        'price': 450,
        'description': 'Expectroant that thins mucus to make coughs more productive.',
        'image': 'https://images.unsplash.com/photo-1607619056574-7b8d3ee536b2?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 18,
        'category': 'Cold/Cough',
        'requiresPrescription': false
      },
      {
        'name': 'Ketorolac 10mg Tablet',
        'price': 85,
        'description': 'NSAID used for short-term treatment of moderate to severe pain.',
        'image': 'https://images.unsplash.com/photo-1471864190281-ad5fe9bb0720?q=80&w=500&h=500&auto=format&fit=crop',
        'stock': 25,
        'category': 'Pain Relief',
        'requiresPrescription': true
      },
      
      // AUTO-GENERATED LOOP TO REACH 200 TOTAL ITEMS
      for (int i = 1; i <= 100; i++)
        {
          'name': 'Pharma Product $i',
          'price': (20 + (i * 17) % 5000),
          'description': 'General healthcare product used for daily medical needs.',
          'category': [
            'Pain Relief',
            'First Aid',
            'Cold/Cough',
            'Skin Care',
            'Energy'
          ][i % 5],
          'image': getMedicineImage(
            'Pharma Product $i',
            [
              'Pain Relief',
              'First Aid',
              'Cold/Cough',
              'Skin Care',
              'Energy'
            ][i % 5],
          ),
          'stock': (i * 9) % 151,
          'requiresPrescription': i % 53 == 0,
        },
    ];

    for (var med in dummyMedicines) {
      await firestore.collection('medicines').add({
        ...med,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}