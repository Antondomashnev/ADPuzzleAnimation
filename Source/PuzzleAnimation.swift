//
//  ADPuzzleAnimation.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/7/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

public class PuzzleAnimation: NSObject {
    
    public var animationVelocity: Double = 10
    
    private let pieces: [Piece]
    private let pieceSide: CGFloat
    private let viewToAnimate: UIView
    private let animationContainerWindow: UIWindow
    private let pieceAnimator: PieceAnimator = PieceAnimator()
    
    private var piecesContainerView: UIView?
    
    init(viewToAnimate: UIView, inWindow animationContainerWindow: UIWindow, pieceSide: CGFloat) {
        self.pieceSide = pieceSide
        self.animationContainerWindow = animationContainerWindow
        self.pieces = PiecesCreator.createPiecesFromView(viewToAnimate, pieceSideSize: pieceSide)
        self.viewToAnimate = viewToAnimate
        super.init()
    }
    
    //MARK: - Interface
    
    public func start() {
        let piecesContainerView = self.piecesContainerViewFromViewToAnimate(self.viewToAnimate)
        self.viewToAnimate.superview?.addSubview(piecesContainerView)
        self.viewToAnimate.removeFromSuperview()
    }
    
    public func stop() {
        
    }
    
    //MARK: - Helpers
    
    private func piecesContainerViewFromViewToAnimate(viewToAnimate: UIView) -> UIView {
        let piecesContainerView = UIView(frame: self.viewToAnimate.frame)
        piecesContainerView.clipsToBounds = false
        self.piecesContainerView = piecesContainerView
        return piecesContainerView
    }
}

public class ForwardPuzzleAnimation: PuzzleAnimation {
    
    public override func start() {
        super.start()
        for piece in self.pieces {
            piece.initialPosition = PiecePositioner.piecePositionOutsideOfView(piece, pieceWidth: self.pieceSide, fromView: self.piecesContainerView!)
            piece.desiredPosition = piece.originalPosition
            self.piecesContainerView!.addSubview(piece.view)
        }
        
        self.pieceAnimator.addForwardAnimationForPieces(self.pieces, withVelocity: self.animationVelocity)
    }
    
    public override func stop() {
        super.stop()
        self.pieceAnimator.removeForwardAnimationFromPieces(self.pieces)
    }
}

public class BackwardPuzzleAnimation: PuzzleAnimation {
    
    public override func start() {
        super.start()
        for piece in self.pieces {
            piece.initialPosition = piece.originalPosition
            piece.desiredPosition = PiecePositioner.piecePositionOutsideOfView(piece, pieceWidth: self.pieceSide, fromView: self.piecesContainerView!)
            self.piecesContainerView!.insertSubview(piece.view, atIndex: 0)
        }
        
        self.pieceAnimator.addBackwardAnimationForPieces(self.pieces, withVelocity: self.animationVelocity)
    }
    
    public override func stop() {
        super.stop()
        self.pieceAnimator.removeForwardAnimationFromPieces(self.pieces)
    }
}
