# pie_timer

Customizable Timer package with a pie animation for Flutter.

This package can render a circular countdown timer with animated pie-shaped progress.

## Preview

![preview_full_animation](https://media.giphy.com/media/jEcrJl9d0BClHnt9Tc/giphy.gif "Full Animation")

Please check below for more previews.

## Features

- Countdown for any duration.
- Change progress direction, forward or reverse.
- Customizable colors, widths, radius, shadow, text style, and pause icon.
- Callback functions when animation is completed or dismissed.
- Callback functions to start, stop, and reset the animation.
- Custom AnimationController to access the controller functions.
- Built-in GestureDetector. Tap to alternate between play and pause. Long tap to reset the animation.

## PieTimer Parameters

| Name                     | Type                      | Default Value                | Description                                                                       |
| :----------------------- | :------------------------ | :--------------------------- | :-------------------------------------------------------------------------------- |
| `key`                    | `Key`                     | `null`                       | _Key for PieTimer._                                                               |
| `pieAnimationController` | `PieAnimationController?` | `null`                       | _Controls (Start, Pause, Restart) for external buttons._                          |
| `duration`               | `Duration`                | `required`                   | _Countdown duration._                                                             |
| `countdownPassed`        | `Duration`                | `Duration.zero`              | _Countdown passed duration._                                                      |
| `radius`                 | `double`                  | `required`                   | _To determine the size of the pie._                                               |
| `pieColor`               | `Color`                   | `required`                   | _Background color of the pie._                                                    |
| `fillColor`              | `Color`                   | `required`                   | _Pie progress color._                                                             |
| `borderColor`            | `Color?`                  | `null`                       | _Sets `borderColor`. If null then there will be no border._                       |
| `borderWidth`            | `double?`                 | `null`                       | _Sets `borderWidth`. If null then there will be no border_                        |
| `shadowColor`            | `Color`                   | `Colors.black`               | _The shadow color._                                                               |
| `shadowElevation`        | `double`                  | `0.0`                        | _Shadow elevation. The value is non-negative._                                    |
| `isReverse`              | `bool`                    | `false`                      | _Sets the direction of pie progress. False is Clockwise, True is Anti-Clockwise._ |
| `textStyle`              | `TextStyle?`              | `null`                       | _`TextStyle` of timer text._                                                      |
| `enableTouchControls`    | `bool?`                   | `false`                      | _Enable start, stop and reset on touch of Pie Widget._                            |
| `onCompleted`            | `VoidCallback?`           | `null`                       | _Function to run when animation status is completed._                             |
| `onDismissed`            | `VoidCallback?`           | `null`                       | _Function to run when animation status is dismissed._                             |
| `pauseIcon`              | `IconData`                | `Icons.pause_circle_outline` | _Icon to display when paused._                                                    |
| `pauseIconColor`         | `Color`                   | `Colors.white`               | _Color of the pause icon._                                                        |

## Getting started

Run this command:

```flutter
flutter pub add pie_timer
```

Or add the latest version of `pie_timer` as a dependency in your pubspec.yaml file.

Then run `flutter pub get`

## Usage

### Without the `PieAnimationController`

```dart
PieTimer(
    duration: const Duration(seconds: 10),
    countdownPassed: const Duration(seconds: 6),
    radius: 150,
    fillColor: Colors.red,
    pieColor: Colors.black,
    borderColor: Colors.yellow,
    borderWidth: 15,
    shadowColor: Colors.black,
    shadowElevation: 10.0,
    textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold,
    ),
    isReverse: false,
    onCompleted: () => {},
    onDismissed: () => {},
    enableTouchControls: true,
    pauseIcon: Icons.pause,
    pauseIconColor: Colors.blue,
),
```

### With `PieAnimationController`

Please refer to the [/example/lib/main.dart](https://github.com/cavdarfurkan/pie_timer/blob/main/example/lib/main.dart) file to see how to use.

## Additional information

Please feel free to contribute.

[Watch How It's Developed](https://youtu.be/EB5E8IpBMJ4)

## Controls Preview

![play_touch](https://media.giphy.com/media/7yjldJzbiQbTdDk8n2/giphy.gif "Play Touch")![pause_touch](https://media.giphy.com/media/Xyw67ZRBSPhyMGMGXG/giphy.gif "Pause Touch")![reset_touch](https://media.giphy.com/media/MMxXFI5LbnOh42FLXR/giphy.gif "Reset Touch")
