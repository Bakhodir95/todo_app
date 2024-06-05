import 'package:json_annotation/json_annotation.dart';

// part 'contact_model.g.dart';

@JsonSerializable()
class Contact {
  String fullname;
  String id;
  Contact({required this.fullname, required this.id});
}
