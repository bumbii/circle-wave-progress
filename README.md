# Circle Wave Progress

1. Add this to your package's pubspec.yaml file:
```
dependencies:
  circle_wave_progress: ^0.0.4
```

2. Install it: You can install packages from the command line:
```
$ flutter packages get
```

3. Import it: Now in your Dart code, you can use:

```
import 'package:circle_wave_progress/circle_wave_progress.dart';
```

4. Demo

```
class StatelessWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.teal,
            body: Center(
                child: CircleWaveProgress(
              size: 300,
              borderWidth: 10.0,
              backgroundColor: Colors.transparent,
              borderColor: Colors.white,
              waveColor: Colors.white54,
              progress: 50,
            ))));
  }
}
```

![](https://github.com/nextfunc/circle_wave_progress/blob/master/screenshot/screenshot.png?raw=true)


![](https://github.com/nextfunc/circle_wave_progress/blob/master/screenshot/circle_wave_progress.gif)
