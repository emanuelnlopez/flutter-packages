import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_chopper_blog/data/built_value_converter.dart';
import 'package:flutter_chopper_blog/data/mobile_data_interceptor.dart';
import 'package:flutter_chopper_blog/model/built_post.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response<BuiltList<BuiltPost>>> getPosts();

  @Get(path: '/{id}')
  Future<Response<BuiltPost>> getPost(@Path('id') int id);

  @Post()
  Future<Response<BuiltPost>> postPost(
    @Body() BuiltPost body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$PostApiService(),
      ],
      converter: BuiltValueConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
        MobileDataInterceptor(),
      ],
    );
    return _$PostApiService(client);
  }
}
