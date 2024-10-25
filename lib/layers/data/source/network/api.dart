import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:wordle_exam/layers/data/dto/word_dto.dart';

import 'route_api.dart';

abstract class Api {
  Future<List<WordDto>> guessWord(
      {required String word, required String guess});
  Future<String> getWord(int length);
}

@Singleton(as: Api)
class ApiImpl implements Api {
  final Dio dio;

  ApiImpl({required this.dio});

  @override
  Future<List<WordDto>> guessWord(
      {required String word, required String guess}) async {
    try {
      final response = await dio
          .get(RouteApi.guessWord + word, queryParameters: {'guess': guess});
      return (response.data as List).map((e) => WordDto.fromMap(e)).toList();
    } on DioException catch (e) {
      errorMsg(e);
      throw e.message ?? 'Something wrong!!!';
    }
  }

  void errorMsg(DioException err) {
    switch (err.response?.statusCode) {
      case 422:
        throw (err.response?.data['detail'] as List).first['msg'] ??
            'Something wrong!!!';
      case 400:
        throw err.response?.data ?? 'Something wrong!!!';
    }
  }

  @override
  Future<String> getWord(int length) async {
    try {
      final response = await dio.get(RouteApi.getWord, queryParameters: { 'length' : length });
      return (response.data as List).map((e) => e.toString()).toList().first;
    } on DioException catch (e) {
      errorMsg(e);
      throw e.message ?? 'Something wrong!!!';
    }
  }
}
