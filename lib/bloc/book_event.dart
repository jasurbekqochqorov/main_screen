import 'package:equatable/equatable.dart';
import 'package:homework/data/model/book_model.dart';
import 'package:homework/data/model/category_model.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();
}

class CategoryBooksEvent extends BookEvent {
  const CategoryBooksEvent({required this.categoryModel, required this.books});

  final CategoryModel categoryModel;
  final List<FileDataModel> books;

  @override
  List<Object?> get props => [books];
}

class SearchBooksEvent extends BookEvent {
  const SearchBooksEvent({required this.searchBooks, required this.value});

  final String value;
  final List<FileDataModel> searchBooks;

  @override
  List<Object?> get props => [searchBooks];
}

class DownLoadEvent extends BookEvent {
  const DownLoadEvent({required this.bookModel});

  final FileDataModel bookModel;

  @override
  List<Object?> get props => [bookModel];
}
