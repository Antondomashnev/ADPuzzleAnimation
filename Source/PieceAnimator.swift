//
//  PieceAnimator.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/10/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

typealias PieceAnimatorCompletion = ((finished: Bool) -> Void)

protocol PieceAnimator {
    func addAnimationForPieces(pieces: [Piece], withVelocity velocity: Double, withScale scale: Double, completion: PieceAnimatorCompletion?)
    func removeAnimationFromPieces(pieces: [Piece])
}

class AbstractPieceAnimator: NSObject {

    private let basicForwardPieceAnimationKey = "com.antondomashnev.PuzzleAnimation.basicForwardPieceAnimationKey"
    private let basicBackwardPieceAnimationKey = "com.antondomashnev.PuzzleAnimation.basicBackwardPieceAnimationKey"
    
    private var animationCompletion: PieceAnimatorCompletion?
    private var runningAnimations: [CAAnimation] = []
    
    //MARK: - CAAnimationDelegate
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if flag {
            self.runningAnimations.removeObject(anim)
            if self.runningAnimations.count == 0 {
                self.animationCompletion?(finished: true)
            }
        }
        else {
            self.animationCompletion?(finished: false)
            self.runningAnimations.removeAll()
        }
    }
    
    override func animationDidStart(anim: CAAnimation) {
        self.runningAnimations.append(anim)
    }
}

class PieceForwardAnimator: AbstractPieceAnimator, PieceAnimator {
    
    //MARK: - Helpers
    
    private func piecesInAnimationGroupCount(totalPiecesCount: Int) -> Int {
        if totalPiecesCount < 4 {
            return 4
        }
        return Int(Random.within(0.0...3.0)) + 1
    }
    
    //MARK: - Interface
    
    func addAnimationForPieces(pieces: [Piece], withVelocity velocity: Double, withScale scale: Double, completion: PieceAnimatorCompletion?) {
        self.animationCompletion = completion
        
        var numberOfPiecesInCurrentGroup = self.piecesInAnimationGroupCount(pieces.count)
        var groupDelay = 0.0
        var indexInCurrentGroup = 0
        
        for piece in pieces {
            let pieceDelay = Random.within(0.3...1.0) + groupDelay
            let animation = CAAnimation.basicForwardPieceAnimation(piece, velocity: velocity, delay: pieceDelay, scale: scale)
            animation.delegate = self
            piece.view.layer.addAnimation(animation, forKey: basicForwardPieceAnimationKey)
            if indexInCurrentGroup == numberOfPiecesInCurrentGroup {
                groupDelay += Random.within(0.5...1.0)
                numberOfPiecesInCurrentGroup = self.piecesInAnimationGroupCount(pieces.count)
                indexInCurrentGroup = 0
            }
            else {
                indexInCurrentGroup++
            }
        }
    }
    
    func removeAnimationFromPieces(pieces: [Piece]) {
        for piece in pieces {
            piece.view.layer.removeAnimationForKey(basicForwardPieceAnimationKey)
        }
    }
}

class PieceBackwardAnimator: AbstractPieceAnimator, PieceAnimator {
    
    //MARK: - Helpers
    
    private func piecesInAnimationGroupCount(totalPiecesCount: Int) -> Int {
        if totalPiecesCount < 4 {
            return 4
        }
        return totalPiecesCount / 4
    }
    
    //MARK: - Interface
    
    func addAnimationForPieces(pieces: [Piece], withVelocity velocity: Double, withScale scale: Double, completion: PieceAnimatorCompletion?) {
        self.animationCompletion = completion
        
        var numberOfPiecesInCurrentGroup = self.piecesInAnimationGroupCount(pieces.count)
        var groupDelay = 0.0
        var indexInCurrentGroup = 0
        
        for piece in pieces {
            let pieceDelay = Random.within(0.1...0.5) + groupDelay
            let animation = CAAnimation.basicBackwardPieceAnimation(piece, velocity: velocity, delay: pieceDelay, scale: scale)
            animation.delegate = self
            piece.view.layer.addAnimation(animation, forKey: basicBackwardPieceAnimationKey)
            if indexInCurrentGroup == numberOfPiecesInCurrentGroup {
                groupDelay += Random.within(0.25...0.4)
                numberOfPiecesInCurrentGroup = self.piecesInAnimationGroupCount(pieces.count)
                indexInCurrentGroup = 0
            }
            else {
                indexInCurrentGroup++
            }
        }
    }
    
    func removeAnimationFromPieces(pieces: [Piece]) {
        for piece in pieces {
            piece.view.layer.removeAnimationForKey(basicForwardPieceAnimationKey)
        }
    }
}
