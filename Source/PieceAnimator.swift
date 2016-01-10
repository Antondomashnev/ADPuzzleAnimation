//
//  PieceAnimator.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/10/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

class PieceAnimator {

    let forwardPieceAnimationKey = "com.antondomashnev.PuzzleAnimation.forwardPieceAnimationKey"
    
    //MARK: - Helpers
    
    private func piecesInGroupCount() -> Int {
        return Int(Random.within(0.0...4.0)) + 1
    }
    
    //MARK: - Interface
    
    func addForwardAnimationForPieces(pieces: [Piece]) {
        var numberOfPiecesInCurrentGroup = self.piecesInGroupCount()
        var groupDelay = 0.0
        var indexInCurrentGroup = 0
        
        for piece in pieces {
            let pieceDelay = Random.within(0.0...1.0) + groupDelay
            piece.view.layer.addAnimation(CAAnimation.forwardPieceAnimation(piece, velocity: 1, delay: pieceDelay), forKey: forwardPieceAnimationKey)
            if indexInCurrentGroup == numberOfPiecesInCurrentGroup {
                groupDelay += Random.within(1.0...2.5)
                numberOfPiecesInCurrentGroup = piecesInGroupCount()
                indexInCurrentGroup = 0
            }
            else {
                indexInCurrentGroup++
            }
        }
    }
    
}
