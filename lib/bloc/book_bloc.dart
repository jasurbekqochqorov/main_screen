import 'dart:io';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data/local/local_variables.dart';
import '../data/model/book_model.dart';
import '../data/model/book_status_model.dart';
import '../data/model/category_model.dart';
import '../services/book_manager_services.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc()
      : super(BookState(
          progress: 0,
          newFileLocation: "",
          books: files,
          searchBooks: files,
        )) {
    on<DownLoadEvent>(_downloadFile);
    on<CategoryBooksEvent>(categoryBook);
    on<SearchBooksEvent>(searchBooks);
  }

  Future<void> _downloadFile(DownLoadEvent event, emit) async {
    Dio dio = Dio();

    BookStatusModel fileStatusModel = await getStatus(event.bookModel);

    if (fileStatusModel.isExist) {
      OpenFilex.open(fileStatusModel.newFileLocation);
    } else {
      await dio.download(
        event.bookModel.fileUrl,
        fileStatusModel.newFileLocation,
        onReceiveProgress: (count, total) async {
          emit(state.copyWith(progress: count / total));
        },
      );
      await FileManagerService.init();
      emit(
        state.copyWith(
          progress: 1,
          newFileLocation: fileStatusModel.newFileLocation,
        ),
      );
    }
  }

  Future<void> searchBooks(SearchBooksEvent event, emit) async {
    List<FileDataModel> searchBooks = [];

    if (event.value.isEmpty) {
      emit(state.copyWith(searchBooks: files));
    } else {
      searchBooks = files
          .where((element) => element.fileName
              .toLowerCase()
              .contains(event.value.toLowerCase()))
          .toList();
      emit(state.copyWith(searchBooks: searchBooks));
    }
  }

  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }

  Future<Directory?> getDownloadPath() async {
    Directory? directory;

    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory("/storage/emulated/0/Download");
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (error) {
      debugPrint("Cannot get download folder path");
    }
    return directory;
  }

  Future<BookStatusModel> getStatus(FileDataModel fileDataModel) async {
    final BookStatusModel fileStatusModel =
        await Isolate.run<BookStatusModel>(() async {
      return await FileManagerService.checkFile(fileDataModel);
    });
    return fileStatusModel;
  }

  Future<void> categoryBook(CategoryBooksEvent event, emit) async {
    List<FileDataModel> booksModel = [];

    if (event.categoryModel == CategoryModel.all) {
      emit(state.copyWith(books: files));
    } else {
      booksModel = files
          .where((element) =>
              element.fileName == event.categoryModel.name)
          .toList();
      emit(state.copyWith(books: booksModel));
    }
  }
}
