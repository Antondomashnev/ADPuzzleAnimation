//
//  PieceAnimationTests.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/10/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import XCTest
import Nimble

@testable import ADPuzzleAnimation

class PieceAnimationTests: XCTestCase {

    var forwardAnimation: CAAnimationGroup!
    var piece: Piece!
    
    override func setUp() {
        super.setUp()
        piece = Piece(pieceView: UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        piece.initialPosition = CGPointZero
        piece.desiredPosition = CGPoint(x: 100, y: 100)
        forwardAnimation = CAAnimation.basicForwardPieceAnimation(piece, velocity: 10, delay: 10, scale: 2.5) as! CAAnimationGroup
    }
    
    func testThatItConsistsOfTwoAnimations() {
        let firstAnimation = forwardAnimation.animations![0] as! CAPropertyAnimation
        let secondAnimation = forwardAnimation.animations![1] as! CAPropertyAnimation
        expect(firstAnimation.keyPath).to(equal("position"))
        expect(secondAnimation.keyPath).to(equal("transform.scale"))
    }

    func testThatItHasForwardsFillMode() {
        expect(self.forwardAnimation.fillMode).to(equal(kCAFillModeForwards))
    }
    
    func testThatItIsNotRemovedOnCompletion() {
        expect(self.forwardAnimation.removedOnCompletion).to(beFalse())
    }
    
    func testThatItHasCorrectDelay() {
        expect(self.forwardAnimation.beginTime).to(beCloseTo(CACurrentMediaTime() + 10, within: 0.001))
    }
    
    func testThatItHasCorrectDuration() {
        let firstAnimation = forwardAnimation.animations![0] as! CABasicAnimation
        let secondAnimation = forwardAnimation.animations![1] as! CABasicAnimation
        expect(firstAnimation.duration).to(equal(1.0))
        expect(secondAnimation.duration).to(equal(1.0))
        expect(self.forwardAnimation.duration).to(equal(1.0))
    }
}
