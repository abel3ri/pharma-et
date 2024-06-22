import 'dart:async';

import 'package:pharma_et/utils/Constants.dart';

class DBSeeder {
  static Future<void> seedMedicines() async {
    final medicines = db.collection("medicines");
    List<Map<String, dynamic>> medicineData = [
      {
        "name": "Acetaminophen",
        "manufacturer": "Various",
        "dosage": {
          "strength": "325 mg",
          "form": "tablet",
          "instructions": "Take 1-2 tablets every 4-6 hours as needed."
        },
        "description":
            "An analgesic and antipyretic used to treat pain and reduce fever.",
        "sideEffects": {
          "common": ["Nausea", "Liver toxicity (with high doses)"],
          "serious": ["Severe skin reactions"]
        }
      },
      {
        "name": "Alprazolam",
        "manufacturer": "Various",
        "dosage": {
          "strength": "0.25 mg",
          "form": "tablet",
          "instructions": "Take 1-2 tablets three times daily as needed."
        },
        "description":
            "Benzodiazepine used to treat anxiety disorders and panic disorder.",
        "sideEffects": {
          "common": ["Drowsiness", "Dizziness"],
          "serious": ["Respiratory depression", "Severe allergic reactions"]
        }
      },
      {
        "name": "Amlodipine",
        "manufacturer": "Various",
        "dosage": {
          "strength": "5 mg",
          "form": "tablet",
          "instructions": "Take one tablet daily."
        },
        "description":
            "Calcium channel blocker used to treat high blood pressure and chest pain (angina).",
        "sideEffects": {
          "common": ["Swelling (edema)", "Fatigue"],
          "serious": ["Low blood pressure", "Worsening heart failure"]
        }
      },
      {
        "name": "Azithromycin",
        "manufacturer": "Various",
        "dosage": {
          "strength": "250 mg",
          "form": "tablet",
          "instructions": "Take one tablet daily for 5 days."
        },
        "description":
            "Macrolide antibiotic used to treat bacterial infections like respiratory tract infections, skin infections, and sexually transmitted infections (STIs).",
        "sideEffects": {
          "common": ["Nausea", "Diarrhea"],
          "serious": ["Severe allergic reactions", "Liver problems"]
        }
      },
      {
        "name": "Bupropion",
        "manufacturer": "Various",
        "dosage": {
          "strength": "150 mg",
          "form": "tablet",
          "instructions": "Take one tablet twice daily, at least 8 hours apart."
        },
        "description":
            "Atypical antidepressant used to treat depression and to aid in smoking cessation.",
        "sideEffects": {
          "common": ["Dry mouth", "Insomnia"],
          "serious": [
            "Seizures (especially with higher doses)",
            "Psychiatric symptoms"
          ]
        }
      },
      {
        "name": "Carvedilol",
        "manufacturer": "Various",
        "dosage": {
          "strength": "12.5 mg",
          "form": "tablet",
          "instructions": "Take one tablet twice daily."
        },
        "description":
            "Beta-blocker used to treat high blood pressure, heart failure, and to improve survival after a heart attack.",
        "sideEffects": {
          "common": ["Dizziness", "Fatigue"],
          "serious": ["Low blood pressure", "Worsening heart failure"]
        }
      },
      {
        "name": "Cephalexin",
        "manufacturer": "Various",
        "dosage": {
          "strength": "500 mg",
          "form": "capsule",
          "instructions": "Take one capsule every 6 hours."
        },
        "description":
            "First-generation cephalosporin antibiotic used to treat bacterial infections like skin infections and respiratory tract infections.",
        "sideEffects": {
          "common": ["Diarrhea", "Nausea"],
          "serious": ["Severe allergic reactions", "Kidney problems"]
        }
      },
      {
        "name": "Citalopram",
        "manufacturer": "Various",
        "dosage": {
          "strength": "20 mg",
          "form": "tablet",
          "instructions": "Take one tablet daily in the morning or evening."
        },
        "description":
            "Selective serotonin reuptake inhibitor (SSRI) used to treat depression and anxiety disorders.",
        "sideEffects": {
          "common": ["Nausea", "Insomnia"],
          "serious": [
            "Suicidal thoughts (in younger patients)",
            "Serotonin syndrome"
          ]
        }
      },
      {
        "name": "Clarithromycin",
        "manufacturer": "Various",
        "dosage": {
          "strength": "500 mg",
          "form": "tablet",
          "instructions": "Take one tablet twice daily for 7-14 days."
        },
        "description":
            "Macrolide antibiotic used to treat bacterial infections like respiratory tract infections, skin infections, and Helicobacter pylori infections.",
        "sideEffects": {
          "common": ["Nausea", "Diarrhea"],
          "serious": ["Severe allergic reactions", "Liver problems"]
        }
      },
      {
        "name": "Clonazepam",
        "manufacturer": "Various",
        "dosage": {
          "strength": "0.5 mg",
          "form": "tablet",
          "instructions": "Take 1-2 tablets three times daily as needed."
        },
        "description":
            "Benzodiazepine used to treat seizures, panic disorder, and certain types of anxiety disorders.",
        "sideEffects": {
          "common": ["Drowsiness", "Dizziness"],
          "serious": ["Respiratory depression", "Severe allergic reactions"]
        }
      },
      {
        "name": "Donepezil",
        "manufacturer": "Various",
        "dosage": {
          "strength": "5 mg",
          "form": "tablet",
          "instructions": "Take one tablet daily in the evening."
        },
        "description":
            "Acetylcholinesterase inhibitor used to treat Alzheimer's disease and other forms of dementia.",
        "sideEffects": {
          "common": ["Nausea", "Diarrhea"],
          "serious": ["Heart problems", "Severe allergic reactions"]
        }
      },
      {
        "name": "Duloxetine",
        "manufacturer": "Various",
        "dosage": {
          "strength": "30 mg",
          "form": "capsule",
          "instructions": "Take one capsule daily in the morning or evening."
        },
        "description":
            "Serotonin-norepinephrine reuptake inhibitor (SNRI) used to treat depression and anxiety disorders, as well as chronic pain disorders like fibromyalgia.",
        "sideEffects": {
          "common": ["Nausea", "Dry mouth"],
          "serious": [
            "Suicidal thoughts (in younger patients)",
            "Serotonin syndrome"
          ]
        }
      },
      {
        "name": "Esomeprazole",
        "manufacturer": "Various",
        "dosage": {
          "strength": "20 mg",
          "form": "capsule",
          "instructions": "Take one capsule daily before breakfast."
        },
        "description":
            "Proton pump inhibitor (PPI) used to reduce stomach acid and treat conditions like gastroesophageal reflux disease (GERD) and ulcers.",
        "sideEffects": {
          "common": ["Headache", "Nausea"],
          "serious": ["Kidney problems", "Severe diarrhea"]
        }
      },
      {
        "name": "Escitalopram",
        "manufacturer": "Various",
        "dosage": {
          "strength": "10 mg",
          "form": "tablet",
          "instructions": "Take one tablet daily in the morning."
        },
        "description":
            "Selective serotonin reuptake inhibitor (SSRI) used to treat depression and anxiety disorders.",
        "sideEffects": {
          "common": ["Nausea", "Insomnia"],
          "serious": [
            "Suicidal thoughts (in younger patients)",
            "Serotonin syndrome"
          ]
        }
      },
      {
        "name": "Fluticasone",
        "manufacturer": "Various",
        "dosage": {
          "strength": "50 mcg",
          "form": "inhaler",
          "instructions": "Use two inhalations twice daily."
        },
        "description":
            "Corticosteroid used as an inhaler to treat asthma and allergic rhinitis.",
        "sideEffects": {
          "common": ["Sore throat", "Nosebleeds"],
          "serious": ["Cataracts", "Glaucoma"]
        }
      },
      {
        "name": "Furosemide",
        "manufacturer": "Various",
        "dosage": {
          "strength": "20 mg",
          "form": "tablet",
          "instructions": "Take one tablet daily in the morning."
        },
        "description":
            "Loop diuretic used to treat edema (fluid retention) and high blood pressure.",
        "sideEffects": {
          "common": ["Dehydration", "Electrolyte imbalance"],
          "serious": ["Kidney problems", "Low blood pressure"]
        }
      },
      {
        "name": "Gabapentin",
        "manufacturer": "Various",
        "dosage": {
          "strength": "300 mg",
          "form": "capsule",
          "instructions": "Take one capsule three times daily."
        },
        "description":
            "Anticonvulsant used to treat seizures and neuropathic pain.",
        "sideEffects": {
          "common": ["Dizziness", "Drowsiness"],
          "serious": [
            "Severe skin reactions",
            "Seizures (especially in overdose)"
          ]
        }
      },
      {
        "name": "Hydrochlorothiazide",
        "manufacturer": "Various",
        "dosage": {
          "strength": "25 mg",
          "form": "tablet",
          "instructions": "Take one tablet daily in the morning."
        },
        "description":
            "Thiazide diuretic used to treat high blood pressure and reduce fluid retention (edema).",
        "sideEffects": {
          "common": ["Dizziness", "Muscle cramps"],
          "serious": ["Electrolyte imbalance", "Kidney problems"]
        }
      },
      {
        "name": "Hydroxyzine",
        "manufacturer": "Various",
        "dosage": {
          "strength": "25 mg",
          "form": "tablet",
          "instructions": "Take one tablet three times daily as needed."
        },
        "description":
            "Antihistamine used to treat anxiety, allergies, and as a sedative.",
        "sideEffects": {
          "common": ["Drowsiness", "Dry mouth"],
          "serious": [
            "Seizures (especially in overdose)",
            "Severe allergic reactions"
          ]
        }
      },
      {
        "name": "Ibuprofen",
        "manufacturer": "Various",
        "dosage": {
          "strength": "200 mg",
          "form": "tablet",
          "instructions": "Take 1-2 tablets every 4-6 hours as needed."
        },
        "description":
            "Nonsteroidal anti-inflammatory drug (NSAID) used to treat pain, fever, and inflammation.",
        "sideEffects": {
          "common": ["Nausea", "Stomach ulcers"],
          "serious": ["Heart attack or stroke (especially with long-term use)"]
        }
      },
      {
        "name": "Lisinopril",
        "manufacturer": "Various",
        "dosage": {
          "strength": "10 mg",
          "form": "tablet",
          "instructions": "Take one tablet daily."
        },
        "description":
            "Angiotensin-converting enzyme (ACE) inhibitor used to treat high blood pressure and heart failure.",
        "sideEffects": {
          "common": ["Dizziness", "Cough"],
          "serious": ["Kidney problems", "Low blood pressure"]
        }
      },
      {
        "name": "Metformin",
        "manufacturer": "Various",
        "dosage": {
          "strength": "500 mg",
          "form": "tablet",
          "instructions": "Take one tablet twice daily with meals."
        },
        "description":
            "Oral antidiabetic medication used to treat type 2 diabetes.",
        "sideEffects": {
          "common": ["Nausea", "Diarrhea"],
          "serious": ["Lactic acidosis (rare but serious)"]
        }
      },
      {
        "name": "Metoprolol",
        "manufacturer": "Various",
        "dosage": {
          "strength": "50 mg",
          "form": "tablet",
          "instructions": "Take one tablet twice daily."
        },
        "description":
            "Beta-blocker used to treat high blood pressure, chest pain (angina), and heart failure.",
        "sideEffects": {
          "common": ["Dizziness", "Fatigue"],
          "serious": ["Slow heart rate", "Worsening heart failure"]
        }
      },
      {
        "name": "Montelukast",
        "manufacturer": "Various",
        "dosage": {
          "strength": "10 mg",
          "form": "tablet",
          "instructions": "Take one tablet daily in the evening."
        },
        "description":
            "Leukotriene receptor antagonist used to prevent asthma attacks and to treat seasonal allergies.",
        "sideEffects": {
          "common": ["Headache", "Abdominal pain"],
          "serious": ["Neuropsychiatric events", "Allergic reactions"]
        }
      },
      {
        "name": "Naproxen",
        "manufacturer": "Various",
        "dosage": {
          "strength": "250 mg",
          "form": "tablet",
          "instructions": "Take 1-2 tablets twice daily with food."
        },
        "description":
            "Nonsteroidal anti-inflammatory drug (NSAID) used to treat pain, fever, and inflammation.",
        "sideEffects": {
          "common": ["Heartburn", "Stomach ulcers"],
          "serious": ["Heart attack or stroke (especially with long-term use)"]
        }
      },
      {
        "name": "Omeprazole",
        "manufacturer": "Various",
        "dosage": {
          "strength": "20 mg",
          "form": "capsule",
          "instructions": "Take one capsule daily before breakfast."
        },
        "description":
            "Proton pump inhibitor (PPI) used to reduce stomach acid and treat conditions like gastroesophageal reflux disease (GERD) and ulcers.",
        "sideEffects": {
          "common": ["Headache", "Nausea"],
          "serious": ["Kidney problems", "Severe diarrhea"]
        }
      },
      {
        "name": "Pantoprazole",
        "manufacturer": "Various",
        "dosage": {
          "strength": "40 mg",
          "form": "tablet",
          "instructions": "Take one tablet daily before breakfast."
        },
        "description":
            "Proton pump inhibitor (PPI) used to reduce stomach acid and treat conditions like gastroesophageal reflux disease (GERD) and ulcers.",
        "sideEffects": {
          "common": ["Headache", "Nausea"],
          "serious": ["Kidney problems", "Severe diarrhea"]
        }
      },
      {
        "name": "Quetiapine",
        "manufacturer": "Various",
        "dosage": {
          "strength": "100 mg",
          "form": "tablet",
          "instructions": "Take one tablet daily in the evening."
        },
        "description":
            "Atypical antipsychotic used to treat schizophrenia, bipolar disorder, and depression.",
        "sideEffects": {
          "common": ["Drowsiness", "Dizziness"],
          "serious": ["High blood sugar", "Neuroleptic malignant syndrome"]
        }
      },
      {
        "name": "Rosuvastatin",
        "manufacturer": "Various",
        "dosage": {
          "strength": "10 mg",
          "form": "tablet",
          "instructions": "Take one tablet daily."
        },
        "description":
            "Statins used to lower cholesterol levels and reduce the risk of heart disease.",
        "sideEffects": {
          "common": ["Muscle pain", "Digestive problems"],
          "serious": ["Liver problems", "Muscle breakdown"]
        }
      },
      {
        "name": "Sertraline",
        "manufacturer": "Various",
        "dosage": {
          "strength": "50 mg",
          "form": "tablet",
          "instructions": "Take one tablet daily in the morning."
        },
        "description":
            "Selective serotonin reuptake inhibitor (SSRI) used to treat depression, anxiety disorders, and obsessive-compulsive disorder (OCD).",
        "sideEffects": {
          "common": ["Nausea", "Insomnia"],
          "serious": [
            "Suicidal thoughts (in younger patients)",
            "Serotonin syndrome"
          ]
        }
      },
      {
        "name": "Trazodone",
        "manufacturer": "Various",
        "dosage": {
          "strength": "50 mg",
          "form": "tablet",
          "instructions": "Take one to two tablets daily at bedtime."
        },
        "description":
            "Serotonin antagonist and reuptake inhibitor (SARI) used to treat depression and insomnia.",
        "sideEffects": {
          "common": ["Drowsiness", "Dry mouth"],
          "serious": ["Priapism", "Suicidal thoughts"]
        }
      },
      {
        "name": "Valsartan",
        "manufacturer": "Various",
        "dosage": {
          "strength": "80 mg",
          "form": "tablet",
          "instructions": "Take one tablet daily."
        },
        "description":
            "Angiotensin II receptor blocker (ARB) used to treat high blood pressure and heart failure.",
        "sideEffects": {
          "common": ["Dizziness", "Fatigue"],
          "serious": ["Kidney problems", "Low blood pressure"]
        }
      },
      {
        "name": "Warfarin",
        "manufacturer": "Various",
        "dosage": {
          "strength": "2 mg",
          "form": "tablet",
          "instructions":
              "Take one tablet daily as directed by your healthcare provider."
        },
        "description":
            "Anticoagulant used to prevent blood clots and stroke in patients with atrial fibrillation, deep vein thrombosis (DVT), and pulmonary embolism (PE).",
        "sideEffects": {
          "common": ["Bleeding", "Bruising"],
          "serious": ["Severe bleeding"]
        }
      },
      {
        "name": "Xanax",
        "manufacturer": "Various",
        "dosage": {
          "strength": "0.5 mg",
          "form": "tablet",
          "instructions": "Take 1-2 tablets three times daily as needed."
        },
        "description":
            "Benzodiazepine used to treat anxiety disorders and panic disorder.",
        "sideEffects": {
          "common": ["Drowsiness", "Dizziness"],
          "serious": ["Respiratory depression", "Severe allergic reactions"]
        }
      },
      {
        "name": "Zolpidem",
        "manufacturer": "Various",
        "dosage": {
          "strength": "10 mg",
          "form": "tablet",
          "instructions": "Take one tablet at bedtime as needed."
        },
        "description": "Sedative-hypnotic used to treat insomnia.",
        "sideEffects": {
          "common": ["Drowsiness", "Dizziness"],
          "serious": ["Complex sleep behaviors", "Severe allergic reactions"]
        }
      }
    ];

    for (var medicine in medicineData) {
      await medicines.add(medicine);
    }

  }

  static Future<void> seedBeautyProds() async {
    final beautyProds = db.collection("beautyProds");
    List<Map<String, dynamic>> prods = [
      {
        "name": "Dove Body Wash",
        "brand": "Dove",
        "category": "Personal Care",
        "type": "Body Wash",
        "description":
            "Moisturizing body wash with gentle cleansers and NutriumMoisture technology for softer, smoother skin.",
        "benefits": ["Hydrates skin", "Gentle cleansing"],
        "usage": "Apply on wet skin, lather and rinse thoroughly.",
        "ingredients": [
          "Water",
          "Glycerin",
          "Cocamidopropyl Betaine",
          "Sodium Laureth Sulfate",
          "Fragrance"
        ],
        "price": 5.99,
        "currency": "ETB"
      },
      {
        "name": "Neutrogena Oil-Free Acne Wash",
        "brand": "Neutrogena",
        "category": "Personal Care",
        "type": "Facial Cleanser",
        "description":
            "Oil-free acne wash with salicylic acid to treat acne and prevent breakouts without over-drying.",
        "benefits": ["Clears breakouts", "Reduces acne"],
        "usage":
            "Wet face, apply a small amount and gently massage. Rinse thoroughly.",
        "ingredients": [
          "Salicylic Acid",
          "Water",
          "Cocamidopropyl Betaine",
          "Sodium C14-16 Olefin Sulfonate",
          "Glycerin"
        ],
        "price": 8.49,
        "currency": "ETB"
      },
      {
        "name": "L'Oréal Paris Elvive Total Repair 5 Shampoo",
        "brand": "L'Oréal Paris",
        "category": "Beauty Products",
        "type": "Shampoo",
        "description":
            "Repairing shampoo with ceramide and protein complex to restore hair's strength, vitality, and silkiness.",
        "benefits": ["Repairs damage", "Strengthens hair"],
        "usage":
            "Apply to wet hair, massage into a lather, and rinse thoroughly. Follow with conditioner.",
        "ingredients": [
          "Water",
          "Sodium Laureth Sulfate",
          "Cocamidopropyl Betaine",
          "Glycol Distearate",
          "Sodium Chloride"
        ],
        "price": 6.99,
        "currency": "ETB"
      },
      {
        "name": "Olay Regenerist Micro-Sculpting Cream",
        "brand": "Olay",
        "category": "Beauty Products",
        "type": "Face Cream",
        "description":
            "Anti-aging moisturizer with hyaluronic acid, amino-peptides, and vitamin B3 complex to firm and hydrate skin.",
        "benefits": ["Firms skin", "Hydrates intensely"],
        "usage":
            "Smooth evenly over your cleansed face and neck morning and night.",
        "ingredients": [
          "Water",
          "Glycerin",
          "Niacinamide",
          "Cyclopentasiloxane",
          "Dimethicone"
        ],
        "price": 24.99,
        "currency": "ETB"
      }
    ];
    for (var prod in prods) {
      await beautyProds.add(prod);
    }
  }

  static Future<void> seedBabyAndMotherProds() async {
    final babyAndMotherCare = db.collection("babyAndMotherCare");
    List<Map<String, dynamic>> prods = [
      {
        "name": "Johnson's Baby Shampoo",
        "brand": "Johnson's",
        "category": "Baby Care",
        "type": "Shampoo",
        "description":
            "Gentle shampoo with no more tears formula, suitable for babies' delicate hair and scalp.",
        "benefits": ["Tear-free", "Gentle cleansing"],
        "usage": "Apply on wet hair, lather and rinse.",
        "ingredients": [
          "Water",
          "Cocamidopropyl Betaine",
          "PEG-80 Sorbitan Laurate",
          "Citric Acid",
          "Sodium Benzoate"
        ],
        "price": 150.00,
        "currency": "ETB"
      },
      {
        "name": "Huggies Diapers",
        "brand": "Huggies",
        "category": "Baby Care",
        "type": "Diapers",
        "description":
            "Soft and absorbent diapers for infants and toddlers, with leak-lock system for overnight protection.",
        "benefits": ["Absorbent", "Leak-proof"],
        "usage": "Secure around baby's waist and adjust for a comfortable fit.",
        "ingredients": null,
        "price": 250.00,
        "currency": "ETB"
      },
      {
        "name":
            "Palmer's Cocoa Butter Formula Massage Lotion for Stretch Marks",
        "brand": "Palmer's",
        "category": "Mother Care",
        "type": "Lotion",
        "description":
            "Rich massage lotion with cocoa butter and shea butter, helps reduce appearance of stretch marks during and after pregnancy.",
        "benefits": ["Moisturizes skin", "Improves elasticity"],
        "usage":
            "Apply all over the body, especially on stretch mark prone areas, morning and night.",
        "ingredients": [
          "Water",
          "Cocoa Butter",
          "Shea Butter",
          "Glycerin",
          "Vitamin E"
        ],
        "price": 280.00,
        "currency": "ETB"
      },
      {
        "name": "Aveeno Baby Daily Moisture Lotion",
        "brand": "Aveeno",
        "category": "Baby Care",
        "type": "Lotion",
        "description":
            "Gentle lotion with natural oatmeal and dimethicone, moisturizes baby's sensitive skin for 24 hours.",
        "benefits": ["Gentle on skin", "Hypoallergenic"],
        "usage": "Apply on baby's skin as needed, especially after bath.",
        "ingredients": [
          "Water",
          "Glycerin",
          "Distearyldimonium Chloride",
          "Petrolatum",
          "Isopropyl Palmitate"
        ],
        "price": 180.00,
        "currency": "ETB"
      }
    ];
    for (var prod in prods) {
      await babyAndMotherCare.add(prod);
    }
  }

  static Future<void> seedNutritionAndSupplements() async {
    final nutritionSupplements = db.collection("nutritionAndSupplements");
    List<Map<String, dynamic>> prods = [
      {
        "name": "Centrum Multivitamin Tablets",
        "brand": "Centrum",
        "category": "Supplements",
        "type": "Multivitamin",
        "description":
            "Daily multivitamin tablets with essential vitamins and minerals for overall health support.",
        "benefits": [
          "Supports immune health",
          "Provides energy",
          "Promotes healthy skin"
        ],
        "usage": "Take one tablet daily with food.",
        "ingredients": [
          "Vitamin A",
          "Vitamin C",
          "Vitamin D",
          "Calcium",
          "Iron"
        ],
        "price": 290.00,
        "currency": "ETB"
      },
      {
        "name": "Nature's Bounty Fish Oil",
        "brand": "Nature's Bounty",
        "category": "Supplements",
        "type": "Fish Oil",
        "description":
            "Fish oil softgels with omega-3 fatty acids EPA and DHA, supports heart health and joint health.",
        "benefits": [
          "Supports heart health",
          "Promotes joint health",
          "Brain health support"
        ],
        "usage": "Take one softgel daily with a meal.",
        "ingredients": ["Fish Oil", "Omega-3 Fatty Acids (EPA, DHA)"],
        "price": 250.00,
        "currency": "ETB"
      },
      {
        "name": "Protein Powder",
        "brand": "Optimum Nutrition",
        "category": "Nutrition",
        "type": "Protein Powder",
        "description":
            "Whey protein powder with fast-absorbing BCAAs and glutamine, ideal for muscle recovery and growth.",
        "benefits": [
          "Supports muscle growth",
          "Aids muscle recovery",
          "Promotes strength"
        ],
        "usage":
            "Mix one scoop with 6-8 ounces of cold water or milk. Shake well.",
        "ingredients": [
          "Whey Protein Isolate",
          "Whey Protein Concentrate",
          "BCAAs",
          "Glutamine"
        ],
        "price": 350.00,
        "currency": "ETB"
      },
      {
        "name": "Vitamin D3 Supplement",
        "brand": "Nature Made",
        "category": "Supplements",
        "type": "Vitamin D3",
        "description":
            "Vitamin D3 softgels for bone and immune health support.",
        "benefits": [
          "Supports bone health",
          "Boosts immune system",
          "Helps maintain calcium levels"
        ],
        "usage": "Take one softgel daily with a meal.",
        "ingredients": ["Vitamin D3", "Soybean Oil", "Gelatin", "Glycerin"],
        "price": 180.00,
        "currency": "ETB"
      }
    ];
    for (var prod in prods) {
      await nutritionSupplements.add(prod);
    }
  }

  static Future<void> seedMultiVitamins() async {
    final multiVitamins = db.collection("multiVitamins");
    List<Map<String, dynamic>> prods = [
      {
        "name": "One A Day Women's Multivitamin",
        "brand": "One A Day",
        "category": "Multi Vitamins",
        "type": "Women's Multivitamin",
        "description":
            "Daily multivitamin formulated specifically for women with key nutrients to support overall health.",
        "benefits": [
          "Supports immune health",
          "Provides energy",
          "Promotes healthy skin and hair"
        ],
        "usage": "Take one tablet daily with food.",
        "ingredients": [
          "Vitamin A",
          "Vitamin C",
          "Vitamin D",
          "Vitamin E",
          "B Vitamins"
        ],
        "price": 320.00,
        "currency": "ETB"
      },
      {
        "name": "Centrum Men's Multivitamin",
        "brand": "Centrum",
        "category": "Multi Vitamins",
        "type": "Men's Multivitamin",
        "description":
            "Complete multivitamin specially formulated for men with essential nutrients for heart health, energy, and immunity.",
        "benefits": [
          "Supports heart health",
          "Boosts energy",
          "Enhances immune function"
        ],
        "usage": "Take one tablet daily with a meal.",
        "ingredients": [
          "Vitamin A",
          "Vitamin C",
          "Vitamin D",
          "Vitamin K",
          "Zinc"
        ],
        "price": 340.00,
        "currency": "ETB"
      },
      {
        "name": "Nature Made Multi Daily Vitamin",
        "brand": "Nature Made",
        "category": "Multi Vitamins",
        "type": "Daily Multivitamin",
        "description":
            "Daily multivitamin tablets for adults with essential vitamins and minerals to support overall health.",
        "benefits": [
          "Provides essential nutrients",
          "Supports immune system",
          "Promotes energy metabolism"
        ],
        "usage": "Take one tablet daily with water and a meal.",
        "ingredients": [
          "Vitamin A",
          "Vitamin C",
          "Vitamin D",
          "Vitamin E",
          "B Vitamins"
        ],
        "price": 300.00,
        "currency": "ETB"
      },
      {
        "name": "SmartyPants Kids Complete Daily Gummy Vitamins",
        "brand": "SmartyPants",
        "category": "Multi Vitamins",
        "type": "Kids Multivitamin",
        "description":
            "Complete multivitamin gummies for kids with essential nutrients in a delicious gummy form.",
        "benefits": [
          "Supports growing kids",
          "Promotes immune health",
          "Provides vitamins A, C, D, E, and B12"
        ],
        "usage":
            "Children 4 years and older take 4 gummies daily. Chew thoroughly before swallowing.",
        "ingredients": [
          "Vitamin A",
          "Vitamin C",
          "Vitamin D",
          "Vitamin E",
          "Vitamin B12"
        ],
        "price": 280.00,
        "currency": "ETB"
      }
    ];
    for (var prod in prods) {
      await multiVitamins.add(prod);
    }
  }
}
