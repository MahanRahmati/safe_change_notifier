import 'package:flutter_test/flutter_test.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

void main() {
  test('dispose', () {
    final SafeValueNotifier<int> notifier = SafeValueNotifier<int>(12);
    expect(notifier.isDisposed, isFalse);
    expect(notifier.hasListeners, isFalse);

    int expectedNotifications = 0;
    int actualNotifications = 0;
    void listener() => ++actualNotifications;

    notifier.addListener(listener);
    expect(notifier.hasListeners, isTrue);

    notifier.value = 34;
    expect(actualNotifications, ++expectedNotifications);

    notifier.removeListener(listener);
    expect(notifier.hasListeners, isFalse);

    notifier.value = 56;
    expect(actualNotifications, expectedNotifications);

    notifier.addListener(listener);
    notifier.dispose();
    expect(notifier.isDisposed, isTrue);
    expect(notifier.hasListeners, isFalse);

    expect(() => notifier.value = 78, returnsNormally);
    expect(actualNotifications, expectedNotifications);

    expect(() => notifier.addListener(() {}), returnsNormally);
    expect(notifier.hasListeners, isFalse);
    expect(() => notifier.removeListener(() {}), returnsNormally);
  });
}
