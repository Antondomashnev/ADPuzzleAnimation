//
//  PuzzleAnimatorTests.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 2/4/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import XCTest
import Nimble

@testable import ADPuzzleAnimation

class PuzzleAnimatorTests: XCTestCase {
    
    var puzzleAnimation: PuzzleAnimation?
    var viewToAnimate: UIView?
    var configuration: PuzzleAnimationConfiguration?

    override func setUp() {
        super.setUp()
        self.configuration = PuzzleAnimationConfiguration()
        self.configuration?.pieceSide = 20
        self.viewToAnimate = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.puzzleAnimation = PuzzleAnimation(viewToAnimate: self.viewToAnimate!, configuration: self.configuration!)
    }
    
    override func tearDown() {
        self.viewToAnimate = nil
        self.puzzleAnimation = nil
        super.tearDown()
    }

    func testThatOnStartItHidesViewToAnimate() {
        self.viewToAnimate!.hidden = false
        self.puzzleAnimation?.start()
        expect(self.viewToAnimate!.hidden).to(beTrue())
    }
    
    func testThatOnStartItSetsIsAnimatingToTrue() {
        expect(self.puzzleAnimation?.isAnimating).to(beFalse())
        self.puzzleAnimation?.start()
        expect(self.puzzleAnimation?.isAnimating).to(beTrue())
    }
    
    func testThatOnFinishItShowsViewToAnimate() {
        self.viewToAnimate!.hidden = true
        self.puzzleAnimation?.stop()
        expect(self.viewToAnimate!.hidden).to(beFalse())
    }
    
    func testThatOnStopItSetsIsAnimatingToFalse() {
        self.puzzleAnimation?.start()
        self.puzzleAnimation?.stop()
        expect(self.puzzleAnimation?.isAnimating).to(beFalse())
    }

    func testThatOnStopBackwardAnimationCallsCompletionWithFinishedFalse() {
        let backwardAnimation = BackwardPuzzleAnimation(viewToAnimate: self.viewToAnimate!, configuration: self.configuration!)
        backwardAnimation.start()
        
        var isFinished: Bool? = nil
        backwardAnimation.animationCompletion = { (animation, finished) in
            isFinished = finished
        }
        backwardAnimation.stop()
        expect(isFinished).toEventually(beFalse())
    }
    
    func testThatOnStopForwardAnimationCallsCompletionWithFinishedFalse() {
        let forwardAnimation = ForwardPuzzleAnimation(viewToAnimate: self.viewToAnimate!, configuration: self.configuration!)
        forwardAnimation.start()
        
        var isFinished: Bool? = nil
        forwardAnimation.animationCompletion = { (animation, finished) in
            isFinished = finished
        }
        forwardAnimation.stop()
        expect(isFinished).toEventually(beFalse())
    }
    
}
