import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String image;
  final String name;
  final String status;
  final String species;
  final String gender;

  const Character({
    required this.id,
    required this.image,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
  });

  @override
  List<Object?> get props => [id, image, name, status, species, gender];
}
