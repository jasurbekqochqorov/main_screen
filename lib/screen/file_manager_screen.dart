import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_screen/screen/widget/category_button.dart';
import 'package:open_filex/open_filex.dart';

import '../bloc/file_manager_bloc.dart';
import '../data/models/file_data_model.dart';
import '../data/repositories/file_repository.dart';
import '../utils/colors/app_colors.dart';
import '../utils/size/size_utils.dart';
import '../utils/styles/app_text_style.dart';

class FileManagerScreen extends StatefulWidget {
  const FileManagerScreen({super.key});

  @override
  State<FileManagerScreen> createState() => _FileManagerScreenState();
}

class _FileManagerScreenState extends State<FileManagerScreen> {
  List<FileDataModel> books=[];
  final List<String> categories = [
    "All",
    "Tarix",
    "IT",
    "Drama",
    "Romantika",
  ];
  String search='';
  int activeIndex=0;
  String name='All';
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title:  Text("Books",style: AppTextStyle.interSemiBold.copyWith(
          color: AppColors.black,fontSize: 26
        ),),
        elevation: 0,
      ),
      body: Column(children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(categories.length, (index) {
                  return CategoryButton(
                    isActive: activeIndex == index,
                    title:categories[index],
                    onTap: () {
                      setState(() {
                        activeIndex = index;
                        if(categories[index].toLowerCase()=='all'){
                        books=context.read<FileRepository>().files;
                        }
                        else{
                        books=context.read<FileRepository>().files.where((element) => element.status==context.read<FileRepository>().files[activeIndex].status).toList();
                        }
                      });
                    },
                  );
                }),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: TextField(
            style: AppTextStyle.interMedium.copyWith(
                color: AppColors.black,fontSize: 16
            ),
            onChanged: (v){
              setState(() {
                if(activeIndex==0){
                  books=context.read<FileRepository>().files.where((element) => element.fileName.toLowerCase().contains(v.toLowerCase())).toList();
                }
                else{
                  books=context.read<FileRepository>().files.where((element) => element.status==context.read<FileRepository>().files[activeIndex].status).toList().where((element) => element.fileName.toLowerCase().contains(v.toLowerCase())).toList();
                }
              });
            },
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: const Icon(Icons.search),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:const BorderSide(width: 1,color: AppColors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(width: 1,color: AppColors.black),
              )
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Expanded(child: GridView.count(
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.8,
          crossAxisCount: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: List.generate((activeIndex==0 && books.isEmpty)?context.read<FileRepository>().files.length:books.length,
                (index) {
              FileDataModel fileDataModel =(activeIndex==0 && books.isEmpty)?context.read<FileRepository>().files[index]:books[index];
              FileManagerBloc fileManagerBloc = FileManagerBloc();
              return Column(
                children: [
                  BlocProvider.value(
                    value: fileManagerBloc,
                    child: BlocBuilder<FileManagerBloc, FileManagerState>(
                      builder: (context, state) {
                        debugPrint("CURRENT MB: ${state.progress}");
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Image.network(fileDataModel.imageUrl,width: 150,height: 150,fit: BoxFit.cover,),
                                Row(children: [
                                  Text(fileDataModel.fileName),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () async {
                                      if (state.newFileLocation.isEmpty) {
                                        fileManagerBloc.add(
                                          DownloadFileEvent(
                                            fileDataModel: fileDataModel,
                                          ),
                                        );
                                      } else {
                                        await OpenFilex.open(state.newFileLocation);
                                      }
                                    },
                                    icon: Icon(
                                      state.newFileLocation.isEmpty
                                          ? Icons.download
                                          : Icons.check,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],)
                              ],),
                            ),
                            Visibility(
                              visible: state.progress != 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal:12),
                                child: LinearProgressIndicator(
                                  value: state.progress,
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ))
      ],),
    );
  }
}
