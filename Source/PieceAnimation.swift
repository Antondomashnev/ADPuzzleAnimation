//
//  PieceAnimation.swift
//  ADPuzzleLoader
//
//  Created by Anton Domashnev on 1/9/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

extension CAAnimation {
    
    //MARK: - Interface
    
    static func forwardPieceAnimation(piece: Piece, velocity: CGFloat, delay: CFTimeInterval) -> CAAnimation {
        func setDefaultValuesForAnimation(animation: CAAnimation) {
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        }
        
        let moveAnimation: CASpringAnimation = CASpringAnimation(keyPath: "position")
        setDefaultValuesForAnimation(moveAnimation)
        moveAnimation.fromValue = NSValue(CGPoint: piece.initialPosition)
        moveAnimation.toValue = NSValue(CGPoint: piece.desiredPosition)
        moveAnimation.damping = 1000
        moveAnimation.stiffness = 20
        moveAnimation.mass = 10
        moveAnimation.initialVelocity = velocity
        moveAnimation.duration = moveAnimation.settlingDuration
        
        let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        setDefaultValuesForAnimation(scaleAnimation)
        scaleAnimation.duration = moveAnimation.duration
        scaleAnimation.fromValue = 5
        scaleAnimation.toValue = 1
        
        let forwardAnimation = CAAnimationGroup()
        setDefaultValuesForAnimation(forwardAnimation)
        forwardAnimation.duration = moveAnimation.duration
        forwardAnimation.animations = [moveAnimation, scaleAnimation]
        forwardAnimation.beginTime = CACurrentMediaTime() + delay
        
        return forwardAnimation
    }
    
}
