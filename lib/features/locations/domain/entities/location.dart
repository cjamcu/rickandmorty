import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<int> residentsIds;

  const Location(
      {required this.id,
      required this.name,
      required this.type,
      required this.dimension,
      required this.residentsIds});

  @override
  List<Object?> get props => [id, name, type, dimension, residentsIds];
}
