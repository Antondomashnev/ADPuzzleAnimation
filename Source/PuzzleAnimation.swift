//
//  ADPuzzleAnimation.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/7/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

public class PuzzleAnimation: NSObject {
    
    public var animationVelocity: CGFloat = 12
    
    private let pieces: [Piece]
    private let pieceSide: CGFloat
    private let viewToAnimate: UIView
    private let animationContainerWindow: UIWindow
    private let pieceAnimator: PieceAnimator = PieceAnimator()
    
    private var piecesContainerView: UIView?
    
    init(viewToAnimate: UIView, inWindow animationContainerWindow: UIWindow, pieceSide: CGFloat) {
        self.pieceSide = pieceSide
        self.animationContainerWindow = animationContainerWindow
        self.pieces = PiecesCreator.createPiecesFromView(viewToAnimate, pieceSide: pieceSide)
        self.viewToAnimate = viewToAnimate
        super.init()
    }
    
    //MARK: - Interface
    
    public func start() {
        let piecesContainerView = self.piecesContainerViewFromViewToAnimate(self.viewToAnimate)
        self.viewToAnimate.superview?.addSubview(piecesContainerView)
        self.viewToAnimate.removeFromSuperview()

        for piece in self.pieces {
            piece.initialPosition = PiecePositioner.randomInitialPiecePosition(piece, pieceWidth: self.pieceSide, fromView: piecesContainerView)
            piecesContainerView.addSubview(piece.view)
        }
        
        self.pieceAnimator.addForwardAnimationForPieces(self.pieces)
    }
    
    public func stop() {
        
    }
    
    //MARK: - Helpers
    
    private func addForwardAnimationToPieces(pieces: [Piece]) {
        
    }
    
    private func piecesContainerViewFromViewToAnimate(viewToAnimate: UIView) -> UIView {
        let piecesContainerView = UIView(frame: self.viewToAnimate.frame)
        piecesContainerView.clipsToBounds = false
        self.piecesContainerView = piecesContainerView
        return piecesContainerView
    }
}
