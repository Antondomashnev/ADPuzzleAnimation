# Meet ADPuzzleAnimation

![](https://travis-ci.org/Antondomashnev/ADPuzzleAnimation.svg?branch=master) [![codecov.io](http://codecov.io/github/Antondomashnev/ADPuzzleAnimation/coverage.svg?branch=master)](http://codecov.io/github/Antondomashnev/ADPuzzleAnimation?branch=master)

## Whats inside
Custom animation for UIView inspired by Fabric - Answers animation.

<img src="http://i.giphy.com/u1rehLIHD822I.gif" width="320" /> <img src="http://i.giphy.com/5cdjNOUroagwM.gif" width="320" /> <img src="http://i.giphy.com/10h7RbGYReryNO.gif" width="320" /> <img src="http://i.giphy.com/iXlkj9HtB6FHO.gif" width="320" />

-----
## Usage
=====

For the detail example of usage see viewController.swift file in demo project.

```swift
    /**
     Desiganted initalizer for puzzle animation and it's subclasses
     
     - parameter viewToAnimate: view to render into pieces
     - parameter configuration: animation configuration
     
     - returns: newly created animation instance
     */
    init(viewToAnimate: UIView, configuration: PuzzleAnimationConfiguration)
    
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
