//
//  ADPuzzleAnimation.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/7/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

public typealias PuzzleAnimationCompletion = (animation: PuzzleAnimation, finished: Bool) -> Void

public class PuzzleAnimation: NSObject {
    
    public var animationCompletion: PuzzleAnimationCompletion?
    public var animationVelocity: Double = 10
    public var animationScale: Double = 2.5
    
    private(set) public var isAnimating: Bool = false
    
    private let pieces: [Piece]
    private let pieceSide: CGFloat
    private let viewToAnimate: UIView
    private let animationContainerWindow: UIWindow
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
        self.viewToAnimate.hidden = true
        self.isAnimating = true
    }
    
    public func stop() {
        self.finish()
    }
    
    //MARK: - Helpers
    
    private func piecesContainerViewFromViewToAnimate(viewToAnimate: UIView) -> UIView {
        let piecesContainerView = UIView(frame: self.viewToAnimate.frame)
        piecesContainerView.clipsToBounds = false
        self.piecesContainerView = piecesContainerView
        return piecesContainerView
    }
    
    private func finish() {
        self.piecesContainerView?.removeFromSuperview()
        self.viewToAnimate.hidden = false
        self.isAnimating = false
    }
}

public class ForwardPuzzleAnimation: PuzzleAnimation {
    
    private let pieceAnimator: PieceForwardAnimator = PieceForwardAnimator()
    
    public override func start() {
        if self.isAnimating {
            return
        }
        
        super.start()
        for piece in self.pieces {
            piece.initialPosition = PiecePositioner.piecePositionOutsideOfView(piece, pieceWidth: self.pieceSide, fromView: self.piecesContainerView!, pieceScale: self.animationScale)
            piece.desiredPosition = piece.originalPosition
            self.piecesContainerView!.addSubview(piece.view)
        }
        
        self.pieceAnimator.addAnimationForPieces(self.pieces, withVelocity: self.animationVelocity, withScale: self.animationScale) {
            [weak self] (finished: Bool) in
            self?.finish()
            self?.animationCompletion?(animation: self!, finished: finished)
        }
    }
    
    public override func stop() {
        if !self.isAnimating {
            return
        }
        
        super.stop()
        self.pieceAnimator.removeAnimationFromPieces(self.pieces)
        self.animationCompletion?(animation: self, finished: false)
    }
}

public class BackwardPuzzleAnimation: PuzzleAnimation {
    
    private let pieceAnimator: PieceBackwardAnimator = PieceBackwardAnimator()
    
    public override func start() {
        if self.isAnimating {
            return
        }
        
        super.start()
        for piece in self.pieces {
            piece.initialPosition = piece.originalPosition
            piece.desiredPosition = PiecePositioner.piecePositionOutsideOfView(piece, pieceWidth: self.pieceSide, fromView: self.piecesContainerView!, pieceScale: self.animationScale)
            self.piecesContainerView!.insertSubview(piece.view, atIndex: 0)
        }
        
        self.pieceAnimator.addAnimationForPieces(self.pieces, withVelocity: self.animationVelocity, withScale: self.animationScale) {
            [weak self] (finished: Bool) in
            self?.finish()
            self?.animationCompletion?(animation: self!, finished: finished)
        }
    }
    
    public override func stop() {
        if !self.isAnimating {
            return
        }
        super.stop()
        self.pieceAnimator.removeAnimationFromPieces(self.pieces)
        self.animationCompletion?(animation: self, finished: false)
    }
}
