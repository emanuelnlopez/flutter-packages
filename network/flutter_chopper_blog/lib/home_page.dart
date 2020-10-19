import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chopper_blog/data/post_api_service.dart';
import 'package:flutter_chopper_blog/model/built_post.dart';
import 'package:flutter_chopper_blog/single_post_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chopper Blog'),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPost = BuiltPost(
            (b) => b
              ..title = 'New Title'
              ..body = 'New Body',
          );

          final response = await Provider.of<PostApiService>(
            context,
            listen: false,
          ).postPost(
            newPost,
          );
          print(response.body);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder<Response<BuiltList<BuiltPost>>>(
      future: Provider.of<PostApiService>(context).getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError == true) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }
          final posts = snapshot.data.body;
          return _buildPosts(context, posts);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildPosts(BuildContext context, BuiltList<BuiltPost> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4.0,
          child: ListTile(
            title: Text(
              posts[index].title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index].body),
            onTap: () => _nagivateToPost(
              context,
              posts[index].id,
            ),
          ),
        );
      },
    );
  }

  _nagivateToPost(BuildContext context, postId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SinglePostPage(
          postId: postId,
        ),
      ),
    );
  }
}
