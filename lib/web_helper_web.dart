// Web-specific implementation
import 'dart:html' as html;

class WebHelper {
  static html.Element? _element;
  static void Function(html.Event)? _eventListener;

  static void disableContextMenu() {
    _element = html.document.body;
    _eventListener = _preventDefault;
    _element?.addEventListener('contextmenu', _eventListener!);
  }

  static void enableContextMenu() {
    if (_element != null && _eventListener != null) {
      _element?.removeEventListener('contextmenu', _eventListener!);
      _element = null;
      _eventListener = null;
    }
  }

  static void _preventDefault(html.Event event) {
    event.preventDefault();
  }
}
