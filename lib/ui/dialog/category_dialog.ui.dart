import 'package:crud_todo_app/common/utils.dart';
import 'package:crud_todo_app/provider_dependency.dart';
import 'package:crud_todo_app/viewmodel/category/category_provider.dart';
import 'package:crud_todo_app/viewmodel/category/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:crud_todo_app/common/common.dart';

class CategoryFormDialog extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetReference ref) {
    final categoryViewModel = ref.watch(categoryViewModelProvider);

    return ProviderListener(
      provider: categoryViewModelProvider,
      onChange: _onChangeState,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.close, color: Colors.white),
          ).paddingSymmetric(v: 5),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Add category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ).paddingOnly(b: 15),
                _Name().paddingOnly(b: 5),
                _Emoji().paddingOnly(b: 25),
                if (categoryViewModel != CategoryState.loading()) _Submit(),
                if (categoryViewModel == CategoryState.loading())
                  CircularProgressIndicator()
              ],
            ).paddingSymmetric(h: 16, v: 10),
          ),
        ],
      ),
    );
  }

  void _onChangeState(BuildContext context, CategoryState state) {
    final action = state.maybeWhen(success: (a) => a, orElse: () => null);
    if (action == CategoryAction.add) Navigator.pop(context);
  }
}

class _Name extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetReference ref) {
    final nameText = ref.watch(nameCatProvider);
    final textController = useTextEditingController();

    return TextField(
      controller: textController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: 'Name',
        errorText: nameText.state.message,
      ),
      onChanged: (value) => nameText.state =
          ref.read(categoryViewModelProvider.notifier).onChangeName(value),
    );
  }
}

class _Emoji extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetReference ref) {
    final emoji = ref.watch(emojiCatProvider);
    final textController = useTextEditingController();

    return TextField(
      controller: textController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: 'Emoji',
        errorText: emoji.state.message,
      ),
      onChanged: (value) => emoji.state =
          ref.read(categoryViewModelProvider.notifier).onChangeEmoji(value),
    );
  }
}

class _Submit extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetReference ref) {
    final categoryViewModel = ref.watch(categoryViewModelProvider.notifier);
    final isValid = ref.watch(validationCategoryProvider).state;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Color(0xFF4A78FA)),
      onPressed: isValid ? categoryViewModel.saveCategory : null,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          'Create',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ).paddingSymmetric(v: 12),
    );
  }
}
