# ADPuzzleAnimation

![](https://travis-ci.org/Antondomashnev/ADPuzzleAnimation.svg?branch=master)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/PuzzleAnimation.svg)](https://img.shields.io/cocoapods/v/PuzzleAnimation.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Whats inside
Custom animation for UIView inspired by Fabric - Answers animation.

<img src="http://i.giphy.com/u1rehLIHD822I.gif" width="320" /> <img src="http://i.giphy.com/5cdjNOUroagwM.gif" width="320" /> <img src="http://i.giphy.com/10h7RbGYReryNO.gif" width="320" /> <img src="http://i.giphy.com/iXlkj9HtB6FHO.gif" width="320" />

## Easy to use

To create your first animation you need to know only about one method:

```swift
/**
 Desiganted initalizer for puzzle animation and it's subclasses
 
 - parameter viewToAnimate: view to render into pieces
 - parameter configuration: animation configuration
 
 - returns: newly created animation instance
 */
init(viewToAnimate: UIView, configuration: PuzzleAnimationConfiguration = PuzzleAnimationConfiguration())
```
   
It's flixible - you can configure almost any parameter for the animation:
    
```swift
/**
 *  Defines the structure that contains configurable parameters for puzzle animation
*/
struct PuzzleAnimationConfiguration {

  /// Defines the animation velocity. Higher velocity less animation duration
  var animationVelocity: NSTimeInterval = 1

  /// Defines the delay between each piece in piece's group animation
  var pieceAnimationDelay: PuzzleAnimationDelay = defaultForwardPieceAnimationDelay

  /// Defines the delay between each group of pieces animation
  var pieceGroupAnimationDelay: PuzzleAnimationDelay = defaultForwardPieceGroupAnimationDelay

  /// Defines the animation piece's scale
  var animationScale: Double = 2.5

  /// Each piece represents square and this value represents the number of pixels of square side
  var pieceSide: CGFloat = 40
}
```

Handle callbacks about status to start new animation or do something else:
```swift
/// Called when animation completed, stoped or failed
/// @note You can set it any time even during the animation
public var animationCompletion: PuzzleAnimationCompletion?
```

Intuitive and simple interface:
```swift
/**
 Starts the animation. Makes view to animate hidden
*/
public func start()
    
/**
 Stops the animation. Removes all pieces from superview. Makes view to animate visible
 */
public func stop()
```
    
For the complete example check the viewController.swift

## Easy to install

### CocoaPods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'PuzzleAnimation', '~> 1.0.0'
```
### Carthage

To integrate ADPuzzleAnimation into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "Antondomashnev/ADPuzzleAnimation" ~> 1.0.0
```

Run `carthage update` to build the framework and drag the built `ADPuzzleAnimation.framework` into your Xcode project.
