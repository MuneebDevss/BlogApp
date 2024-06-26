import 'dart:io';

import 'package:blog_app/Core/Cubits/user_cubit.dart';
import 'package:blog_app/Core/Utils/image_picker.dart';
import 'package:blog_app/feature/auth/Presentation/bloc/auth_bloc.dart';
import 'package:blog_app/feature/blog/Presentaion/Widgets/Button.dart';
import 'package:blog_app/feature/blog/Presentaion/blog_bloc/blog_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../Core/Theme/Palatte.dart';
import '../../../../Core/Utils/snack_bar.dart';
import '../../../../Core/Widgets/loading.dart';
import 'Blogs_page.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _BlogsState();
}

class _BlogsState extends State<AddBlog> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? image;
  List<String> selected = [];
   final _titleController =TextEditingController();
  final _contentController =TextEditingController();
  Future<void> selectedImage()
  async {
    final pickedImage=await imagePicker();
    if(pickedImage!=null) {
      image=pickedImage;
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: ()
        async{
          if(_formKey.currentState!.validate()&&
              image!=null&&selected.isNotEmpty) {
            final posterid=(context.read<UserCubit>().state as CubitLogin).user.id;
            final username=(context.read<UserCubit>().state as CubitLogin).user.name;
            context.read<BlogBloc>().add(UploadBlog(posterId: posterid, title: _titleController.text.trim(), content: _contentController.text.trim(), topic: selected, imageUrl: image!, name: username));
            setState(() {

            });
          }
        }, icon: const Icon(Icons.done))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<BlogBloc,BlogState>(
          listener:(context,state)
          {
            if(state is BlogFailure)
            {
              showSnackBar(context, state.message);
            }
            if(state is BlogSuccess)
            {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Blogs()), (route) => false);
            }
          },
          builder: (context,state)
          {
            if(state is BlogLoading) {

              return const Loader();
            }
            return Form(
              key: _formKey,
              child: SingleChildScrollView(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    image!=null?
                    GestureDetector(
                      onDoubleTap: (){
                        imagePicker();
                        setState(() {
                
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                
                            height: 150,
                            width: double.infinity,
                            child: Image.file(image!,fit: BoxFit.cover,)),
                      ),
                    ):
                    GestureDetector(
                      onTap: (){
                        selectedImage();
                        setState(() {
                        });
                      },
                      child: DottedBorder(
                        color: AppPallete.borderColor,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        child: const SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.drive_folder_upload,
                                size: 40,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Upload your image',
                                style: TextStyle(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                          ['Business', 'Technology', 'Entertainment', 'Programming']
                              .map((e) => GestureDetector(
                            onTap: () {
                              selected.contains(e)
                                  ? selected.remove(e)
                                  : selected.add(e);
                              setState(() {});
                            },
                            child: selected.contains(e)
                                ? Button(
                              text: e,
                              color: AppPallete.gradient1,
                            )
                                : Button(
                              text: e,
                              color: AppPallete.backgroundColor,
                            ),
                          ))
                              .toList(),
                        )),
                    const SizedBox(height:20 ,),
                
                    TextFormField(
                        controller: _titleController,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Blog Title is empty';
                          }
                          return null;
                        },
                        decoration: const  InputDecoration(
                            hintText: 'Blog title',
                            hintStyle: TextStyle(fontSize: 15)
                        )
                    ),
                    const SizedBox(height:20 ,),
                    TextFormField(
                        controller: _contentController,
                        maxLines: null,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Blog Title is empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Content',
                            hintStyle: TextStyle(fontSize: 15)
                        )
                    )
                  ],
                ),
              ),
            );
          },
        ),
            ),

    );
  }
}
