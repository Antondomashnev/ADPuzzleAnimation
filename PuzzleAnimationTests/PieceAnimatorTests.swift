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
    
    private var pieceAnimator: PieceAnimator!
    
    override func setUp() {
        super.setUp()
        self.pieceAnimator = PieceAnimator()
    }
    
    override func tearDown() {
        self.pieceAnimator = nil
        super.tearDown()
    }
    
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
        
        self.pieceAnimator.addForwardAnimationForPieces([piece1, piece2, piece3], withVelocity: 10)
        
        for piece in [piece1, piece2, piece3] {
            expect(piece.view.layer.animationForKey("com.antondomashnev.PuzzleAnimation.basicbasicForwardPieceAnimationKey")).toNot(beNil())
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
        
        view1.layer.addAnimation(animation1, forKey: "com.antondomashnev.PuzzleAnimation.basicbasicForwardPieceAnimationKey")
        view2.layer.addAnimation(animation2, forKey: "com.antondomashnev.PuzzleAnimation.basicbasicForwardPieceAnimationKey")
        view3.layer.addAnimation(animation3, forKey: "com.antondomashnev.PuzzleAnimation.basicbasicForwardPieceAnimationKey")
        
        self.pieceAnimator.removeForwardAnimationFromPieces([piece1, piece2, piece3])
        
        for piece in [piece1, piece2, piece3] {
            expect(piece.view.layer.animationForKey("com.antondomashnev.PuzzleAnimation.basicbasicForwardPieceAnimationKey")).to(beNil())
        }
    }
}
