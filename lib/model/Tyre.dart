import 'package:objectbox/objectbox.dart';

@Entity()
class Tyre {
  @Id()
  int id = 0;

  String? name;
  double? psi;
  int? temp;
  bool? isLowPressure;

  @Property(type: PropertyType.date) // Store as int in milliseconds
  DateTime? date;

  @Transient() // Ignore this property, not stored in the database.
  int? computedProperty;

  Tyre({required this.name, required this.psi, required this.temp, required this.isLowPressure});
}
