# Dart Futures, Streams, and Isolates

How Dart code hands off work, and who is responsible for stopping it.

Dart runs one isolate's code on one thread. Nothing else in that isolate runs
while your function holds the turn, so any wait that is not an `await` stops the
whole isolate.

## Pick the type by how many values arrive

| Delivers           | Type           |
| ------------------ | -------------- |
| One value, later   | `Future<T>`    |
| Many values, later | `Stream<T>`    |
| Nothing, but ends  | `Future<void>` |

An `async` function always returns a `Future`. Declare that return type;
`avoid_void_async` reports an `async` function typed `void`, because a caller
then has nothing to await and no way to see it fail.

## Every `Future` gets an owner

Await it, return it, or hand it to `unawaited` from `dart:async` with a comment
saying why nobody is waiting. Enable `unawaited_futures` so a dropped future is
a diagnostic rather than a silent lost failure — an unawaited future that throws
reaches the zone's error handler, far from the code that started it.

Await independent work together rather than in sequence:

```dart
final results = await Future.wait([fetchOrders(), fetchCustomer()]);
```

`Future.wait` starts every future immediately and completes when all of them do.
It surfaces the first error, so use it for work you would abandon together, not
for calls whose failures need separate handling.

Bound anything that leaves the isolate with `.timeout(...)`, and give
`onTimeout` a value or let it throw `TimeoutException`. A request with no
timeout waits as long as the other side is willing to keep the socket open.

Prefer `return future;` to `return await future;` inside an `async` function
where no surrounding `try` needs the result; `unnecessary_await_in_return`
reports the difference.

## Whoever listens, cancels

A `StreamSubscription` lives until someone cancels it. Store the subscription in
the object that created it and cancel it in that object's teardown:

```dart
class Watcher {
  StreamSubscription<Order>? _subscription;

  void start(Stream<Order> orders) {
    _subscription = orders.listen(_handle);
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
  }
}
```

Enable `cancel_subscriptions` and `close_sinks`: they catch the field that is
never cancelled and the `StreamController` that is never closed. A leaked
subscription keeps its source alive and keeps handling events after the owner is
gone.

A plain `StreamController` accepts one listener and throws on the second. Use
`StreamController.broadcast()` only when several listeners are genuinely
expected, and remember that a broadcast stream drops events emitted while nobody
is listening.

Prefer `async*` and `yield` to driving a controller by hand when the source is a
loop you own.

## Never block the isolate

Use the asynchronous form of every I/O call. `avoid_slow_async_io` flags the
async file and directory calls that are slower than their synchronous
counterparts, which is the one place the synchronous form is the right answer.

Move CPU-bound work off the isolate entirely with `Isolate.run`:

```dart
final total = await Isolate.run(() => sumEveryLine(rawCsv));
```

Anything that keeps the turn — a long loop, a large parse, a synchronous socket
read — freezes every other callback in that isolate until it returns.

## Finish

Finish when every future is awaited, returned, or explicitly unawaited, every
call leaving the isolate carries a timeout, every subscription and controller is
cancelled or closed by its owner, and no synchronous call holds the turn for
long.
