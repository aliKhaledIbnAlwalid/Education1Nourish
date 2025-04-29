import 'package:dio/dio.dart';
import 'package:edunourish/features/Parent/features/Exam/data/models/exam_model.dart';
import '../../features/Bus Screen/data/models/bus_model.dart';
import '../../features/Parent Profile/data/models/Profile.dart';
import '../../features/Teacher Screen/data/models/teacher_model.dart';
  // adjust path as needed

class ApiService {
  final _baseUrl = 'http://54.242.19.19:3000/api/';
  final Dio _dio;

  ApiService({Dio? dio}) : _dio = dio ?? Dio();

  /// Fetches a single Profile (first item in the returned array)
  Future<Profile> fetchParentProfile({required String endPoint}) async {
    final response = await _dio.get('$_baseUrl$endPoint');
    final list = response.data as List<dynamic>;

    if (list.isEmpty) {
      throw Exception('No users found');
    }

    return Profile.fromJson(list.first as Map<String, dynamic>);
  }

  /// Fetches a list of Buses from your API
  Future<List<Bus>> fetchBuses({required String endPoint}) async {
    final response = await _dio.get('$_baseUrl$endPoint');
    final list = response.data as List<dynamic>;

    if (list.isEmpty) {
      // You can decide whether an empty list is "error" or just returns []
      return <Bus>[];
    }

    return list
        .map((json) => Bus.fromJson(json as Map<String, dynamic>))
        .toList();
  }

   
  Future<Exam> fetchExam({required String endPoint,required String id}) async {
    final response = await _dio.get('$_baseUrl$endPoint/$id');
    return Exam.fromJson(response.data as Map<String, dynamic>);
  }

  /// Fetches a Teacher by ID and wraps it in your ApiResponse model
  Future<ApiResponse> fetchTeacher({
    required String endPoint,
    required String id,
  }) async {
    final response = await _dio.get('$_baseUrl$endPoint/$id');
    return ApiResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
