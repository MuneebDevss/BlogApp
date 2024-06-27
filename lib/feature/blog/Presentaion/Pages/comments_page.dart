import 'package:blog_app_vs/Core/Utils/snack_bar.dart';
import 'package:blog_app_vs/feature/blog/Presentaion/blog_bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app_vs/Core/Theme/Palatte.dart';
import '../../../../Core/Widgets/loading.dart';
import '../../Domain/Entities/Comments.dart';

class CommentsPage extends StatefulWidget {
  final String blogId;

  const CommentsPage({super.key, required this.blogId});
  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController _commentController = TextEditingController();
  List<Comments> comments = [];
  @override
  void initState() {
    context.read<BlogBloc>().add(GetComments(BlogId: widget.blogId));
    super.initState();
  }

  double getHeight(String comment) {
    return double.parse(comment.length.toString()) * 2 + 100;
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments Page'),
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: BlocConsumer<BlogBloc, BlogState>(
                builder: (context, state) {
                  if (state is BlogLoading) {
                    return const Loader();
                  }

                  if (state is CommentsAchievedState) {
                    comments = state.comments;
                    return ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.account_circle_outlined,
                                  size: 40,
                                ),
                                Container(
                                  width: 300,
                                  height: getHeight(comment.comment),
                                  margin: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 188, 243, 240),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          comment.name,
                                          style: const TextStyle(
                                              color: AppPallete.backgroundColor,
                                              overflow: TextOverflow.clip),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          comment.comment,
                                          style: const TextStyle(
                                              color: AppPallete.backgroundColor,
                                              overflow: TextOverflow.clip),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Text(comment.uploadedAt.substring(0, 9)),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  if (state is CommentsUpdatedState) {
                    comments.add(state.comment);

                    return ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.account_circle_outlined,
                                  size: 40,
                                ),
                                Container(
                                  width: 300,
                                  height: getHeight(comment.comment),
                                  margin: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 188, 243, 240),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          comment.name,
                                          style: const TextStyle(
                                              color: AppPallete.backgroundColor,
                                              overflow: TextOverflow.clip),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          comment.comment,
                                          style: const TextStyle(
                                              color: AppPallete.backgroundColor,
                                              overflow: TextOverflow.clip),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Text(comment.uploadedAt.substring(0, 9)),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return const Center(child: Text('Add a new Comment'));
                },
                listener: (BuildContext context, BlogState state) {
                  if (state is CommentsNotUpdatedState) {
                    showSnackBar(context, state.message);
                  }
                  if (state is CommentsNotAchievedState) {
                    showSnackBar(context, state.message);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _commentController,
                    validator: (value) {
                      if (_commentController.text.isEmpty) {
                        return "Comment is empty";
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Comment',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_commentController.text.isNotEmpty &&
                          formkey.currentState!.validate()) {
                        context.read<BlogBloc>().add(
                              UpdateCommentEvent(
                                blogId: widget.blogId,
                                comment: _commentController.text,
                              ),
                            );
                        _commentController.clear();
                        setState(() {});
                      }
                    },
                    child: const Text('Add Comment'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
