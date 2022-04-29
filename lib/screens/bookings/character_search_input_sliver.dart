import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CharacterSearchInputSliver extends StatefulWidget {
  const CharacterSearchInputSliver({
    Key? key,
    this.onChanged,
    this.debounceTime,
  }) : super(key: key);
  final ValueChanged<String>? onChanged;
  final Duration? debounceTime;

  @override
  _CharacterSearchInputSliverState createState() =>
      _CharacterSearchInputSliverState();
}

class _CharacterSearchInputSliverState
    extends State<CharacterSearchInputSliver> {
  final StreamController<String> _textChangeStreamController =
      StreamController();
  late StreamSubscription _textChangesSubscription;
  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    _textChangesSubscription = _textChangeStreamController.stream
        .debounceTime(
          widget.debounceTime ?? const Duration(seconds: 1),
        )
        .distinct()
        .listen((text) {
      final onChanged = widget.onChanged;
      if (onChanged != null) {
        onChanged(text);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, size: 14),
              suffixIcon: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () {
                  final onChanged = widget.onChanged;
                  if (onChanged != null && !_controller.text.isEmpty) {
                    _controller.clear();
                    onChanged('');
                  }
                  FocusScope.of(context).unfocus();
                },
                icon: Icon(Icons.clear),
                iconSize: 14
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(25.0), 
                ),
                borderSide: BorderSide(
                  width: 0, 
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'search...',
              hintStyle: TextStyle(fontSize: 14, ),
              fillColor: const Color(0xFFE8E9EA),
              filled: true,
              isDense: true,
              contentPadding: EdgeInsets.all(0),
            ),
            onChanged: _textChangeStreamController.add,
          ),
        ),
      );

  @override
  void dispose() {
    _textChangeStreamController.close();
    _textChangesSubscription.cancel();
    _controller.dispose();
    super.dispose();
  }
}
