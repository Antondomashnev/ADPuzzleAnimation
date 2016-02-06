//
//  ADPuzzleAnimation.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/7/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

public typealias PuzzleAnimationCompletion = (animation: PuzzleAnimation, finished: Bool) -> Void

/// The `PuzzleAnimation` defines the abstract animation class
public class PuzzleAnimation {
    
    /// Called when animation completed, stoped or failed
    /// @note You can set it any time even during the animation
    public var animationCompletion: PuzzleAnimationCompletion?
    
    /// Defines the animation speed. More speed -> less animation duration
    /// @note The changes won't affect during the animation
    public var animationVelocity: Double = 10
    
    /// Defines the animation piece's scale
    /// @note The changes won't affect during the animation
    public var animationScale: Double = 2.5
    
    /// Information whether animation is currently running or not
    private(set) public var isAnimating: Bool = false
    
    private let pieces: [Piece]
    private let pieceSide: CGFloat
    private let viewToAnimate: UIView
    private var piecesContainerView: UIView?
    
    /**
     Desiganted initalizer for puzzle animation and it's subclasses
     
     - parameter viewToAnimate: view to render into pieces
     - parameter pieceSide:     each piece represents square and this value represents the number of pixels of square side
     
     - returns: newly created animation instance
     */
    init(viewToAnimate: UIView, pieceSide: CGFloat) {
        self.pieceSide = pieceSide
        self.pieces = PiecesCreator.createPiecesFromView(viewToAnimate, pieceSideSize: pieceSide)
        self.viewToAnimate = viewToAnimate
    }
    
    //MARK: - Interface
    
    /**
     Starts the animation. Makes view to anmate hidden
    */
    public func start() {
        let piecesContainerView = self.piecesContainerViewFromViewToAnimate(self.viewToAnimate)
        self.viewToAnimate.superview?.addSubview(piecesContainerView)
        self.viewToAnimate.hidden = true
        self.isAnimating = true
    }
    
    /**
     Stops the animation. Removes all pieces from superview. Makes view to animate visible
     */
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

/// The `ForwardPuzzleAnimation` defines the animation to create a full view from pieces
public class ForwardPuzzleAnimation: PuzzleAnimation {
    
    private let pieceAnimator: PieceForwardAnimator = PieceForwardAnimator()
    
    /**
     @see PuzzleAnimation start()
     */
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
    
    /**
     @see PuzzleAnimation stop()
     */
    public override func stop() {
        if !self.isAnimating {
            return
        }
        
        super.stop()
        self.pieceAnimator.removeAnimationFromPieces(self.pieces)
        self.animationCompletion?(animation: self, finished: false)
    }
}

/// The `BackwardPuzzleAnimation` defines the animation to split view into pieces
public class BackwardPuzzleAnimation: PuzzleAnimation {
    
    private let pieceAnimator: PieceBackwardAnimator = PieceBackwardAnimator()
    
    /**
     @see PuzzleAnimation start()
     */
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
    
    /**
     @see PuzzleAnimation stop()
     */
    public override func stop() {
        if !self.isAnimating {
            return
        }
        super.stop()
        self.pieceAnimator.removeAnimationFromPieces(self.pieces)
        self.animationCompletion?(animation: self, finished: false)
    }
}
