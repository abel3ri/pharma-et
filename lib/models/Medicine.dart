class Medicine {
  String description;
  Map<String, dynamic> instructions;
  String form;
  String strength;
  String name;
  Map<String, dynamic> sideEffects;
  String manufacturer;

  Medicine({
    required String this.description,
    required Map<String, dynamic> this.instructions,
    required String this.form,
    required String this.strength,
    required String this.name,
    required Map<String, dynamic> this.sideEffects,
    required String this.manufacturer,
  });
}
