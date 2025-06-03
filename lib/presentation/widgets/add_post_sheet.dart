import 'package:breeze/data/models/local_post.dart';
import 'package:breeze/presentation/bloc/local_posts/local_posts_bloc.dart';
import 'package:breeze/utils/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddPostSheet extends StatefulWidget {
  const AddPostSheet({super.key});

  @override
  State<AddPostSheet> createState() => _AddPostSheetState();
}

class _AddPostSheetState extends State<AddPostSheet> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String body = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.close, size: 30),
                  ),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context.read<LocalPostsBloc>().add(
                          LocalPostsAddEvent(
                            LocalPostModel(id: 0, title: title, body: body),
                          ),
                        );
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: context.theme.colorScheme.primary,
                            content: Text("Post added successfully!"),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    child: Text("Post"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                onSaved: (newValue) => title = newValue!,
                decoration: InputDecoration(hintText: "Title"),
                validator:
                    (value) => value!.isEmpty ? "Title cannot be empty" : null,
              ),
              SizedBox(height: 20),
              Expanded(
                child: TextFormField(
                  onSaved: (newValue) => body = newValue!,
                  validator:
                      (value) => value!.isEmpty ? "Body cannot be empty" : null,
                  decoration: InputDecoration(
                    hintText: "Body",
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  expands: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
