part of '../mh_items_view.dart';

class _MhItemsViewController<T> {
  final _listeners = <Function()>[];

  MhItemsViewState<T>? state;
  _MhItemsViewState<T>? widgetState;

  addListener(Function() listener) {
    if (_listeners.contains(listener)) {
      return;
    }
    _listeners.add(listener);
  }

  removeListener(Function() listener) {
    if (!_listeners.contains(listener)) {
      return;
    }
    _listeners.remove(listener);
  }

  callListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }
}
