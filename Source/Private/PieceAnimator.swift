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
    func addAnimationForPieces(pieces: [Piece], completion: PieceAnimatorCompletion?)
    func removeAnimationFromPieces(pieces: [Piece])
}

class AbstractPieceAnimator: NSObject {

    private let basicForwardPieceAnimationKey = "com.antondomashnev.PuzzleAnimation.basicForwardPieceAnimationKey"
    private let basicBackwardPieceAnimationKey = "com.antondomashnev.PuzzleAnimation.basicBackwardPieceAnimationKey"
    
    private let configuration: PuzzleAnimationConfiguration
    
    internal var runningAnimationsCount = 0
    internal var animationCompletion: PieceAnimatorCompletion?
    
    init(animationConfiguration: PuzzleAnimationConfiguration) {
        configuration = animationConfiguration
        super.init()
    }
    
    //MARK: - CAAnimationDelegate
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if flag {
            self.runningAnimationsCount = max(0, self.runningAnimationsCount - 1)
            if self.runningAnimationsCount == 0 {
                self.animationCompletion?(finished: true)
                self.animationCompletion = nil
            }
        }
        else {
            self.animationCompletion?(finished: false)
            self.animationCompletion = nil
            self.runningAnimationsCount = 0
        }
    }
}

class PieceForwardAnimator: AbstractPieceAnimator, PieceAnimator {
    
    //MARK: - Helpers
    
    private func piecesInAnimationGroupCount(totalPiecesCount: Int) -> Int {
        if totalPiecesCount < 4 {
            return totalPiecesCount
        }
        return Int(Random.within(0.0...3.0)) + 1
    }
    
    //MARK: - Interface
    
    func addAnimationForPieces(pieces: [Piece], completion: PieceAnimatorCompletion? = nil) {
        if pieces.count == 0 {
            completion?(finished: true)
            return
        }
        self.animationCompletion = completion
        
        var numberOfPiecesInCurrentGroup = self.piecesInAnimationGroupCount(pieces.count)
        var groupDelay = 0.0
        var indexInCurrentGroup = 0
        
        for piece in pieces {
            let pieceDelay = Random.within(self.configuration.pieceAnimationDelay.minimumDelay...self.configuration.pieceAnimationDelay.maximumDelay) + groupDelay
            let animation = CAAnimation.basicForwardPieceAnimation(piece, velocity: self.configuration.animationVelocity, delay: pieceDelay, scale: self.configuration.animationScale)
            animation.delegate = self
            piece.view.layer.addAnimation(animation, forKey: basicForwardPieceAnimationKey)
            if indexInCurrentGroup == numberOfPiecesInCurrentGroup - 1 {
                groupDelay += Random.within(self.configuration.pieceGroupAnimationDelay.minimumDelay...self.configuration.pieceGroupAnimationDelay.maximumDelay)
                numberOfPiecesInCurrentGroup = self.piecesInAnimationGroupCount(pieces.count)
                indexInCurrentGroup = 0
            }
            else {
                indexInCurrentGroup += 1
            }
            self.runningAnimationsCount = self.runningAnimationsCount + 1
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
            return totalPiecesCount
        }
        return totalPiecesCount / 4
    }
    
    //MARK: - Interface
    
    func addAnimationForPieces(pieces: [Piece], completion: PieceAnimatorCompletion? = nil) {
        if pieces.count == 0 {
            completion?(finished: true)
            return
        }
        self.animationCompletion = completion
        
        var numberOfPiecesInCurrentGroup = self.piecesInAnimationGroupCount(pieces.count)
        var groupDelay = 0.0
        var indexInCurrentGroup = 0
        
        for piece in pieces {
            let pieceDelay = Random.within(self.configuration.pieceAnimationDelay.minimumDelay...self.configuration.pieceAnimationDelay.maximumDelay) + groupDelay
            let animation = CAAnimation.basicBackwardPieceAnimation(piece, velocity: self.configuration.animationVelocity, delay: pieceDelay, scale: self.configuration.animationScale)
            animation.delegate = self
            piece.view.layer.addAnimation(animation, forKey: basicBackwardPieceAnimationKey)
            if indexInCurrentGroup == numberOfPiecesInCurrentGroup - 1 {
                groupDelay += Random.within(self.configuration.pieceGroupAnimationDelay.minimumDelay...self.configuration.pieceGroupAnimationDelay.maximumDelay)
                numberOfPiecesInCurrentGroup = self.piecesInAnimationGroupCount(pieces.count)
                indexInCurrentGroup = 0
            }
            else {
                indexInCurrentGroup += 1
            }
            self.runningAnimationsCount = self.runningAnimationsCount + 1
        }
    }
    
    func removeAnimationFromPieces(pieces: [Piece]) {
        for piece in pieces {
            piece.view.layer.removeAnimationForKey(basicBackwardPieceAnimationKey)
        }
        self.animationCompletion?(finished: false)
    }
}
