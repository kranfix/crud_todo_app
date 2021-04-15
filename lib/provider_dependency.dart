import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_todo_app/repository/todo.repository.dart';
import 'package:crud_todo_app/viewmodel/category.viewModel.dart';
import 'package:crud_todo_app/viewmodel/todo.viewModel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Firestore

final databaseProvider = Provider((_) => FirebaseFirestore.instance);

/// Repository

final todoRepositoryProvider = Provider<ITodoRepository>(
  (ref) => TodoRepository(ref.watch(databaseProvider)),
);

/// ViewModel

final todoViewModelProvider = Provider(
  (ref) => TodoViewModel(ref.watch(todoRepositoryProvider)),
);

final categoryViewModelProvider = Provider(
  (ref) => CategoryViewModel(ref.watch(todoRepositoryProvider)),
);
