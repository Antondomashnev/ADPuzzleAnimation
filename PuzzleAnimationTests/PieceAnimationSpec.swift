//
//  PieceAnimationSpec.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/10/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import Quick
import Nimble

@testable import PuzzleAnimation

class PieceAnimationSpec: QuickSpec {

    override func spec() {
        describe("forward animation") {
            var forwardAnimation: CAAnimationGroup!
            var piece: Piece!
            beforeEach {
                piece = Piece(pieceView: UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
                piece.initialPosition = CGPointZero
                piece.desiredPosition = CGPoint(x: 100, y: 100)
                forwardAnimation = CAAnimation.forwardPieceAnimation(piece, velocity: 12, delay: 10) as! CAAnimationGroup
            }
            it("consists of two animations: position and transform.scale") {
                let firstAnimation = forwardAnimation.animations![0] as! CAPropertyAnimation
                let secondAnimation = forwardAnimation.animations![1] as! CAPropertyAnimation
                expect(firstAnimation.keyPath).to(equal("position"))
                expect(secondAnimation.keyPath).to(equal("transform.scale"))
            }
            it("has forwards fill mode") {
                expect(forwardAnimation.fillMode).to(equal(kCAFillModeForwards))
            }
            it("is not removed on completion") {
                expect(forwardAnimation.removedOnCompletion).to(beFalse())
            }
            it("has correct delay") {
                expect(forwardAnimation.beginTime).to(beCloseTo(CACurrentMediaTime() + 10))
            }
            it("has correct initial velocity for position animation") {
                let firstAnimation = forwardAnimation.animations![0] as! CASpringAnimation
                expect(firstAnimation.initialVelocity).to(equal(12))
            }
        }
    }
}
