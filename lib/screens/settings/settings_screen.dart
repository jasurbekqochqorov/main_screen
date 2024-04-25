import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';

import '../../bloc/book_bloc.dart';
import '../../bloc/book_event.dart';
import '../../bloc/book_state.dart';
import '../../data/model/book_model.dart';
import '../../services/book_manager_services.dart';
import '../../utils/app_colors.dart';

class FileManagerScreen extends StatelessWidget {
  const FileManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("File Managaer Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Expanded(
          child: GridView.count(crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.72,
          children: [
            ...List.generate(
              context.read<BookBloc>().state.books.length,
                  (index) {
                FileDataModel fileDataModel =
                context.read<BookBloc>().state.books[index];

                BookBloc fileManagerBloc = BookBloc();

                return Column(children: [
                  BlocProvider.value(
                    value: fileManagerBloc,
                    child: BlocBuilder<BookBloc, BookState>(
                      builder: (context, state) {
                        debugPrint("CURRENT MB: ${state.progress}");
                        String filePath = FileManagerService.isExist(
                          fileDataModel.fileUrl,
                          fileDataModel.fileName,
                        );
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(fileDataModel.imageUrl,width: 150,height: 150,fit: BoxFit.cover,),
                                  Row(children: [
                                    Text(fileDataModel.fileName),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () async {
                                        if (filePath.isEmpty) {
                                          fileManagerBloc.add(
                                            DownLoadEvent(
                                              bookModel: fileDataModel,
                                            ),
                                          );
                                        } else {
                                          await OpenFilex.open(filePath);
                                        }
                                      },
                                      icon: Icon(
                                        filePath.isEmpty
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
                  )
                ],);
              },
            )
          ],),
        ),
      ),
    );
  }
}
