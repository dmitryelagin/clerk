import 'dart:async';

import 'action.dart';
import 'interfaces_private.dart';
import 'interfaces_public.dart';

class StoreExecutorImpl implements StoreExecutor {
  StoreExecutorImpl(this._controller, this._innerExecutor) {
    _zone = _executionZone;
  }

  final StoreController _controller;
  final StoreExecutor _innerExecutor;

  Zone _zone;

  @override
  void execute(Action action) {
    if (action == null || _controller.isTeardowned) return;
    _zone.runUnary(_innerExecutor.execute, action);
  }

  Zone get _executionZone {
    return Zone.current.fork(
      specification: ZoneSpecification(
        run: _run,
        runUnary: _runUnary,
        runBinary: _runBinary,
      ),
    );
  }

  RunHandler get _run {
    return <R>(source, parent, zone, fn) {
      if (_controller.isTeardowned) return null;
      if (_controller.hasTransanction) {
        return parent.run(zone, fn);
      } else {
        _controller.beginTransanction();
        final result = parent.run(zone, fn);
        _controller.endTransanction();
        return result;
      }
    };
  }

  RunUnaryHandler get _runUnary {
    return <R, X>(source, parent, zone, fn, x) {
      if (_controller.isTeardowned) return null;
      if (_controller.hasTransanction) {
        return parent.runUnary(zone, fn, x);
      } else {
        _controller.beginTransanction();
        final result = parent.runUnary(zone, fn, x);
        _controller.endTransanction();
        return result;
      }
    };
  }

  RunBinaryHandler get _runBinary {
    return <R, X, Y>(source, parent, zone, fn, x, y) {
      if (_controller.isTeardowned) return null;
      if (_controller.hasTransanction) {
        return parent.runBinary(zone, fn, x, y);
      } else {
        _controller.beginTransanction();
        final result = parent.runBinary(zone, fn, x, y);
        _controller.endTransanction();
        return result;
      }
    };
  }
}
