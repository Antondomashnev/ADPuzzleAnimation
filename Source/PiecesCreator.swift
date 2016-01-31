//
//  PiecesCreator.swift
//  ADPuzzleLoader
//
//  Created by Anton Domashnev on 1/7/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

class PiecesCreator {
    static func createPiecesFromView(view: UIView, pieceSideSize: CGFloat) -> [Piece] {
        var pieces: [Piece] = []
        let size = view.frame.size
        
        let fromViewSnapshot = view.snapshotViewAfterScreenUpdates(false)
        
        let width = pieceSideSize
        let height = pieceSideSize
        
        for x in CGFloat(0).stride(through: size.width, by: width) {
            for y in CGFloat(0).stride(through: size.height, by: height) {
                let pieceRegion = CGRect(x: x, y: y , width: min(width, size.width - x), height: min(height, size.height - y))
                let pieceView = fromViewSnapshot.resizableSnapshotViewFromRect(pieceRegion, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
                pieceView.frame = pieceRegion
                let piece = Piece(pieceView: pieceView)
                piece.corner = PiecePositioner.cornerForPosition(piece.originalPosition, inRect: view.bounds)
                pieces.append(piece)
            }
        }
        pieces.shuffleInPlace()
        return pieces
    }
}
