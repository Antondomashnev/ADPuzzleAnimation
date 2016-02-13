//
//  PuzzleAnimationConfiguration.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 2/7/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import Foundation
import CoreGraphics

/// Default piece animation delay for backward animation
public let defaultBackwardPieceAnimationDelay = PuzzleAnimationDelay(minimumDelay: 0.1, maximumDelay: 0.5)

/// Default piece's group animation delay for backward animation
public let defaultBackwardPieceGroupAnimationDelay = PuzzleAnimationDelay(minimumDelay: 0.25, maximumDelay: 0.4)

/// Default piece animation delay for forward animation
public let defaultForwardPieceAnimationDelay = PuzzleAnimationDelay(minimumDelay: 0.3, maximumDelay: 1.0)

/// Default piece's group animation delay for forward animation
public let defaultForwardPieceGroupAnimationDelay = PuzzleAnimationDelay(minimumDelay: 0.5, maximumDelay: 1.0)

/**
 *  Defines the structure that contains the information about delay
 */
public struct PuzzleAnimationDelay {
    /// Defines the minimum delay between each group of pieces animation
    public var minimumDelay: NSTimeInterval = 1
    
    /// Defines the minimum delay between each group of pieces animation
    public var maximumDelay: NSTimeInterval = 1
    
    public init(minimumDelay: NSTimeInterval = 1, maximumDelay: NSTimeInterval = 1) {
        self.minimumDelay = minimumDelay
        self.maximumDelay = maximumDelay
    }
}

/**
 *  Defines the structure that contains configurable parameters for puzzle animation
 */
public struct PuzzleAnimationConfiguration {
    
    /// Defines the animation velocity. Higher velocity less animation duration
    public var animationVelocity: Double = 10
    
    /// Defines the delay between each piece in piece's group animation
    public var pieceAnimationDelay: PuzzleAnimationDelay = defaultForwardPieceAnimationDelay
    
    /// Defines the delay between each group of pieces animation
    public var pieceGroupAnimationDelay: PuzzleAnimationDelay = defaultForwardPieceGroupAnimationDelay
    
    /// Defines the animation piece's scale
    public var animationScale: Double = 2.5
    
    /// Each piece represents square and this value represents the number of pixels of square side
    public var pieceSide: CGFloat = 40
    
    public init(animationVelocity: Double = 10, pieceAnimationDelay: PuzzleAnimationDelay = defaultForwardPieceAnimationDelay, pieceGroupAnimationDelay: PuzzleAnimationDelay = defaultForwardPieceGroupAnimationDelay, animationScale: Double = 2.5, pieceSide: CGFloat = 40) {
        
    }
}