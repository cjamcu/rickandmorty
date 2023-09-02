import 'package:rickandmorty/features/shared/domain/entities/get_all_api_response.dart';

class GetAllApiModelModel<T> extends GetAllApiResponse<T> {
  final List<T> results;
  final int pages;
  final int count;

  const GetAllApiModelModel({
    required this.results,
    required this.pages,
    required this.count,
  }) : super(
          totalElements: count,
          totalPages: pages,
          items: results,
        );

  factory GetAllApiModelModel.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    final results =
        (json['results'] as List).map((item) => fromJson(item)).toList();



    return GetAllApiModelModel(
      results: results,
      pages: json['info']['pages'],
      count: json['info']['count'],
    );
  }
}
