import 'package:equatable/equatable.dart';

class GetAllApiResponse<T> extends Equatable {
  final List<T> items;
  final int totalPages;
  final int totalElements;

  const GetAllApiResponse({
    required this.items,
    required this.totalPages,
    required this.totalElements,
  });

  @override
  List<Object?> get props => [items, totalPages, totalElements];
}
