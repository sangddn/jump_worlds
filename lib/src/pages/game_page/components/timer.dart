part of '../game_page.dart';

class _Timer extends StatefulWidget {
  const _Timer();

  @override
  State<_Timer> createState() => _TimerState();
}

class _TimerState extends State<_Timer> {
  late final Stopwatch _stopwatch;
  late final Timer _timer;
  String _timeString = '00:00';

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _startTimer();
  }

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          final minutes = (_stopwatch.elapsed.inSeconds ~/ 60)
              .toString()
              .padLeft(2, '0');
          final seconds = (_stopwatch.elapsed.inSeconds % 60)
              .toString()
              .padLeft(2, '0');
          _timeString = '$minutes:$seconds';
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final s = context.watchGameState();
    if (s.isSolved()) {
      _stopwatch.stop();
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_timeString, style: context.textTheme.h4);
  }
}
