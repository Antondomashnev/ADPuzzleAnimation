//
//  PieceAnimator.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/10/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

class PieceAnimator {

    let basicbasicForwardPieceAnimationKey = "com.antondomashnev.PuzzleAnimation.basicbasicForwardPieceAnimationKey"
    
    //MARK: - Helpers
    
    private func piecesInForwardAnimationGroupCount(totalPiecesCount: Int) -> Int {
        if totalPiecesCount < 4 {
            return 4
        }
        return Int(Random.within(0.0...3.0)) + 1
    }
    
    private func piecesInBackwardAnimationGroupCount(totalPiecesCount: Int) -> Int {
        if totalPiecesCount < 4 {
            return 4
        }
        return 1
    }
    
    //MARK: - Interface
    
    func addForwardAnimationForPieces(pieces: [Piece], withVelocity velocity: Double) {
        var numberOfPiecesInCurrentGroup = self.piecesInForwardAnimationGroupCount(pieces.count)
        var groupDelay = 0.0
        var indexInCurrentGroup = 0
        
        for piece in pieces {
            let pieceDelay = Random.within(0.3...1.0) + groupDelay
            piece.view.layer.addAnimation(CAAnimation.basicForwardPieceAnimation(piece, velocity: velocity, delay: pieceDelay), forKey: basicbasicForwardPieceAnimationKey)
            if indexInCurrentGroup == numberOfPiecesInCurrentGroup {
                groupDelay += Random.within(0.5...1.0)
                numberOfPiecesInCurrentGroup = self.piecesInForwardAnimationGroupCount(pieces.count)
                indexInCurrentGroup = 0
            }
            else {
                indexInCurrentGroup++
            }
        }
    }
    
    func removeForwardAnimationFromPieces(pieces: [Piece]) {
        for piece in pieces {
            piece.view.layer.removeAnimationForKey(basicbasicForwardPieceAnimationKey)
        }
    }
    
    func addBackwardAnimationForPieces(pieces: [Piece], withVelocity velocity: Double) {
        var numberOfPiecesInCurrentGroup = self.piecesInBackwardAnimationGroupCount(pieces.count)
        var groupDelay = 0.0
        var indexInCurrentGroup = 0
        
        for piece in pieces {
            let pieceDelay = Random.within(0.2...0.5) + groupDelay
            piece.view.layer.addAnimation(CAAnimation.basicBackwardPieceAnimation(piece, velocity: velocity, delay: pieceDelay), forKey: basicbasicForwardPieceAnimationKey)
            if indexInCurrentGroup == numberOfPiecesInCurrentGroup {
                groupDelay += Random.within(0.3...0.7)
                numberOfPiecesInCurrentGroup = self.piecesInBackwardAnimationGroupCount(pieces.count)
                indexInCurrentGroup = 0
            }
            else {
                indexInCurrentGroup++
            }
        }
    }
    
    func removeBackwardAnimationFromPieces(pieces: [Piece]) {
        for piece in pieces {
            piece.view.layer.removeAnimationForKey(basicbasicForwardPieceAnimationKey)
        }
    }
}
