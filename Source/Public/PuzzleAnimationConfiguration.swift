//
//  PuzzleAnimationConfiguration.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 2/7/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import Foundation
import CoreGraphics

struct PuzzleAnimationConfiguration {
    
    /// Defines the animation velocity. Higher velocity less animation duration
    var animationVelocity: NSTimeInterval = 1
    
    /// Defines the animation piece's scale
    var animationScale: Double = 2.5
    
    /// Each piece represents square and this value represents the number of pixels of square side
    var pieceSide: CGFloat = 40
}