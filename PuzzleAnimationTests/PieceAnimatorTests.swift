//
//  PieceAnimatorTests.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/24/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import XCTest
import Nimble

@testable import PuzzleAnimation

class PieceAnimatorTests: XCTestCase {
    
    func testThatItShouldAddForwardAnimationForEachPiecesViewOnAddForwardAnimationForPieces() {
        let view1 = UIView(frame: CGRectZero)
        let view2 = UIView(frame: CGRectZero)
        let view3 = UIView(frame: CGRectZero)
        let piece1 = Piece(pieceView: view1)
        let piece2 = Piece(pieceView: view2)
        let piece3 = Piece(pieceView: view3)
        piece1.initialPosition = CGPoint(x: 0, y: 0)
        piece1.desiredPosition = CGPoint(x: 0, y: 0)
        piece2.initialPosition = CGPoint(x: 0, y: 0)
        piece2.desiredPosition = CGPoint(x: 0, y: 0)
        piece3.initialPosition = CGPoint(x: 0, y: 0)
        piece3.desiredPosition = CGPoint(x: 0, y: 0)
        
        let configuration = PuzzleAnimationConfiguration()
        
        let forwardPieceAnimator = PieceForwardAnimator(animationConfiguration: configuration)
        forwardPieceAnimator.addAnimationForPieces([piece1, piece2, piece3])
        
        for piece in [piece1, piece2, piece3] {
            expect(piece.view.layer.animationForKey("com.antondomashnev.PuzzleAnimation.basicForwardPieceAnimationKey")).toNot(beNil())
        }
    }
    
    func testThatItShouldRemoveForwardAnimationFromEachPiecesViewOnRemoveForwardAnimationFromPieces() {
        let view1 = UIView(frame: CGRectZero)
        let view2 = UIView(frame: CGRectZero)
        let view3 = UIView(frame: CGRectZero)
        let piece1 = Piece(pieceView: view1)
        let piece2 = Piece(pieceView: view2)
        let piece3 = Piece(pieceView: view3)
        let animation1 = CAAnimation()
        let animation2 = CAAnimation()
        let animation3 = CAAnimation()
        
        view1.layer.addAnimation(animation1, forKey: "com.antondomashnev.PuzzleAnimation.basicForwardPieceAnimationKey")
        view2.layer.addAnimation(animation2, forKey: "com.antondomashnev.PuzzleAnimation.basicForwardPieceAnimationKey")
        view3.layer.addAnimation(animation3, forKey: "com.antondomashnev.PuzzleAnimation.basicForwardPieceAnimationKey")
        
        let configuration = PuzzleAnimationConfiguration()
        
        let forwardPieceAnimator = PieceForwardAnimator(animationConfiguration: configuration)
        forwardPieceAnimator.removeAnimationFromPieces([piece1, piece2, piece3])
        
        for piece in [piece1, piece2, piece3] {
            expect(piece.view.layer.animationForKey("com.antondomashnev.PuzzleAnimation.basicForwardPieceAnimationKey")).to(beNil())
        }
    }
    
    func testThatItShouldAddBackwardAnimationForEachPiecesViewOnAddForwardAnimationForPieces() {
        let view1 = UIView(frame: CGRectZero)
        let view2 = UIView(frame: CGRectZero)
        let view3 = UIView(frame: CGRectZero)
        let piece1 = Piece(pieceView: view1)
        let piece2 = Piece(pieceView: view2)
        let piece3 = Piece(pieceView: view3)
        piece1.initialPosition = CGPoint(x: 0, y: 0)
        piece1.desiredPosition = CGPoint(x: 0, y: 0)
        piece2.initialPosition = CGPoint(x: 0, y: 0)
        piece2.desiredPosition = CGPoint(x: 0, y: 0)
        piece3.initialPosition = CGPoint(x: 0, y: 0)
        piece3.desiredPosition = CGPoint(x: 0, y: 0)
        
        let configuration = PuzzleAnimationConfiguration()
        
        let backwardPieceAnimator = PieceBackwardAnimator(animationConfiguration: configuration)
        backwardPieceAnimator.addAnimationForPieces([piece1, piece2, piece3])
        
        for piece in [piece1, piece2, piece3] {
            expect(piece.view.layer.animationForKey("com.antondomashnev.PuzzleAnimation.basicBackwardPieceAnimationKey")).toNot(beNil())
        }
    }
    
    func testThatItShouldRemoveBackwardAnimationFromEachPiecesViewOnRemoveForwardAnimationFromPieces() {
        let view1 = UIView(frame: CGRectZero)
        let view2 = UIView(frame: CGRectZero)
        let view3 = UIView(frame: CGRectZero)
        let piece1 = Piece(pieceView: view1)
        let piece2 = Piece(pieceView: view2)
        let piece3 = Piece(pieceView: view3)
        let animation1 = CAAnimation()
        let animation2 = CAAnimation()
        let animation3 = CAAnimation()
        
        view1.layer.addAnimation(animation1, forKey: "com.antondomashnev.PuzzleAnimation.basicBackwardPieceAnimationKey")
        view2.layer.addAnimation(animation2, forKey: "com.antondomashnev.PuzzleAnimation.basicBackwardPieceAnimationKey")
        view3.layer.addAnimation(animation3, forKey: "com.antondomashnev.PuzzleAnimation.basicBackwardPieceAnimationKey")
        
        let configuration = PuzzleAnimationConfiguration()
        
        let backwardPieceAnimator = PieceBackwardAnimator(animationConfiguration: configuration)
        backwardPieceAnimator.removeAnimationFromPieces([piece1, piece2, piece3])
        
        for piece in [piece1, piece2, piece3] {
            expect(piece.view.layer.animationForKey("com.antondomashnev.PuzzleAnimation.basicBackwardPieceAnimationKey")).to(beNil())
        }
    }
    
    func testThatItShouldCallCompletionWithFinishedYesIfAddAnimationWithoutPieces() {
        var isFinished: Bool? = nil
        let forwardPieceAnimator = PieceForwardAnimator(animationConfiguration: PuzzleAnimationConfiguration())
        forwardPieceAnimator.addAnimationForPieces([]) { finished in
            isFinished = finished
        }
        
        expect(isFinished).toEventually(beTrue())
    }

    func testThatItShouldCallCompletionWithFinishedYesIfAllAnimationsAreFinished() {
        let forwardPieceAnimator = PieceForwardAnimator(animationConfiguration: PuzzleAnimationConfiguration())
        var isFinished: Bool? = nil
        forwardPieceAnimator.animationCompletion = { finished in
            isFinished = finished
        }
        
        let animation1 = CAAnimation()
        let animation2 = CAAnimation()
        let animation3 = CAAnimation()
        
        forwardPieceAnimator.runningAnimationsCount = 3
        
        forwardPieceAnimator.animationDidStop(animation2, finished: true)
        forwardPieceAnimator.animationDidStop(animation3, finished: true)
        forwardPieceAnimator.animationDidStop(animation1, finished: true)
        
        expect(isFinished).toEventually(beTrue())
    }
    
    func testThatItShouldCallCompletionWithFinishedNoIfAllAnimationIsFailed() {
        let forwardPieceAnimator = PieceForwardAnimator(animationConfiguration: PuzzleAnimationConfiguration())
        var isFinished: Bool? = nil
        forwardPieceAnimator.animationCompletion = { finished in
            isFinished = finished
        }
        
        let animation1 = CAAnimation()
        let animation2 = CAAnimation()
        let animation3 = CAAnimation()
        
        forwardPieceAnimator.runningAnimationsCount = 3
        
        forwardPieceAnimator.animationDidStop(animation2, finished: true)
        forwardPieceAnimator.animationDidStop(animation3, finished: false)
        forwardPieceAnimator.animationDidStop(animation1, finished: true)
        
        expect(isFinished).toEventually(beFalse())
    }
}
