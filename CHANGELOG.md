# Changelog

## Version 1.4.1 (25.04.2025)

* Fixed `AnimationController.dispose() called more than once` error when using external controllers
* Fixed `TooltipState is a SingleTickerProviderStateMixin but multiple tickers were created` error
* Improved animation listener management to prevent memory leaks
* Enhanced widget lifecycle handling with proper `didUpdateWidget` implementation
* Added internal controller tracking to prevent controller disposal conflicts

## Version 1.4.0 (22.04.2025)

* Updated dependencies.
* pauseIcon and pauseIconColor props added.
* Props validation method updated.
* Auto start after the timer is reset, removed.
* Fixed compatibility issues with the latest Flutter version.

## Version 1.3.1 (18.01.2024)

* Bug fix, the shape of the circular overlay was fixed.

## Version 1.3.0 (17.01.2024)

* Feature/pie animation start angle change.

## Version 1.2.0 (14.09.2022)

* VoidCallback onLongPress added to PieAnimationController to call _onLongPress.
* VoidCallback startAnim added to PieAnimationController to call _startAnim.
* VoidCallback stopAnim added to PieAnimationController to call _stopAnim.
* VoidCallback resetAnim added to PieAnimationController to call _resetAnim.

## Version 1.1.2 (14.09.2022)

* VoidCallback onTap added to PieAnimationController to call _onTap.
* Bug Fix (Stop icon animation)

## Version 1.1.1 (14.09.2022)

* Bug fix (Flickering effect with multiple timers)

## Version 1.1.0 (07.09.2022)

* Shadow properties removed in CustomPainter.
* PhysicalModel added for material shadow.

## Version 1.0.0 (06.09.2022)

* Initial release. Features, usage, etc. are added in readme.md.
