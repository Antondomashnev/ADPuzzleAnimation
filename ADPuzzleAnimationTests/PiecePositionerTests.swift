//
//  PiecePositionerTests.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/10/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import XCTest
import Nimble

@testable import ADPuzzleAnimation

class PiecePositionerTests: XCTestCase {

    let pieceContainerView = UIView(frame: CGRect(x: 60, y: 130, width: 200, height: 200))
    let keyWindow = UIApplication.sharedApplication().keyWindow
    let screenBounds = UIScreen.mainScreen().bounds
    
    override func setUp() {
        super.setUp()
        self.keyWindow?.addSubview(pieceContainerView)
    }
    
    override func tearDown() {
        self.pieceContainerView.removeFromSuperview()
        super.tearDown()
    }

    func testThatItShouldReturnPositionOutsideTopLeftCornerOfTheScreenForPieceInTopLeftAreaOfPiecesContainerView() {
        let pieceView = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        let piece = Piece(pieceView: pieceView)
        for _ in 1...100 {
            let initialPosition = PiecePositioner.piecePositionOutsideOfView(piece, pieceWidth: 20, fromView: pieceContainerView, pieceScale: 2.5)
            if(initialPosition.x < -CGRectGetMinX(pieceContainerView.frame)){
                expect(initialPosition.x) < -CGRectGetMinX(pieceContainerView.frame)
                expect(initialPosition.y) < CGRectGetMidY(pieceContainerView.bounds)
            }
            else {
                expect(initialPosition.x) < CGRectGetMidX(pieceContainerView.bounds)
                expect(initialPosition.y) < -CGRectGetMinY(pieceContainerView.frame)
            }
        }
    }
    
    func testThatItShouldReturnPositionOutsideTopRightCornerOfTheScreenForPieceInTopRightAreaOfPiecesContainerView() {
        let pieceView = UIView(frame: CGRect(x: 120, y: 20, width: 20, height: 20))
        let piece = Piece(pieceView: pieceView)
        for _ in 1...100 {
            let initialPosition = PiecePositioner.piecePositionOutsideOfView(piece, pieceWidth: 20, fromView: pieceContainerView, pieceScale: 2.5)
            if(initialPosition.x > CGRectGetWidth(screenBounds) - CGRectGetMinX(pieceContainerView.frame)){
                expect(initialPosition.x) > CGRectGetWidth(screenBounds) - CGRectGetMinX(pieceContainerView.frame)
                expect(initialPosition.y) < CGRectGetMidY(pieceContainerView.bounds)
            }
            else {
                expect(initialPosition.x) > CGRectGetMidX(pieceContainerView.bounds)
                expect(initialPosition.y) < -CGRectGetMinY(pieceContainerView.frame)
            }
        }
    }
    
    func testThatItShouldReturnPositionOutsideBottomLeftCornerOfTheScreenForPieceInBottomLeftAreaOfPiecesContainerView() {
        let pieceView = UIView(frame: CGRect(x: 20, y: 120, width: 20, height: 20))
        let piece = Piece(pieceView: pieceView)
        for _ in 1...100 {
            let initialPosition = PiecePositioner.piecePositionOutsideOfView(piece, pieceWidth: 20, fromView: pieceContainerView, pieceScale: 2.5)
            if(initialPosition.x < -CGRectGetMinX(pieceContainerView.frame)){
                expect(initialPosition.x) < -CGRectGetMinX(pieceContainerView.frame)
                expect(initialPosition.y) > CGRectGetMidY(pieceContainerView.bounds)
            }
            else {
                expect(initialPosition.x) < CGRectGetMidX(pieceContainerView.bounds)
                expect(initialPosition.y) > CGRectGetHeight(screenBounds) - CGRectGetMinY(pieceContainerView.frame)
            }
        }
    }
    
    func testThatItShouldReturnPositionOutsideBottomRightCornerOfTheScreenForPieceInBottomRightAreaOfPiecesContainerView() {
        let pieceView = UIView(frame: CGRect(x: 120, y: 120, width: 20, height: 20))
        let piece = Piece(pieceView: pieceView)
        for _ in 1...100 {
            let initialPosition = PiecePositioner.piecePositionOutsideOfView(piece, pieceWidth: 20, fromView: pieceContainerView, pieceScale: 2.5)
            if(initialPosition.x > CGRectGetWidth(screenBounds) - CGRectGetMinX(pieceContainerView.frame)){
                expect(initialPosition.x) > CGRectGetWidth(screenBounds) - CGRectGetMinX(pieceContainerView.frame)
                expect(initialPosition.y) > CGRectGetMidY(pieceContainerView.bounds)
            }
            else {
                expect(initialPosition.x) > CGRectGetMidX(pieceContainerView.bounds)
                expect(initialPosition.y) > CGRectGetHeight(screenBounds) - CGRectGetMinY(pieceContainerView.frame)
            }
        }
    }
    
    func testThatItShouldReturnCorrectCornerForPiece() {
        let pieceView1 = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        let piece1 = Piece(pieceView: pieceView1)
        expect(PiecePositioner.cornerForPosition(piece1.originalPosition, inRect: self.pieceContainerView.bounds)).to(equal(Corner.TopLeft))
        
        let pieceView2 = UIView(frame: CGRect(x: 120, y: 20, width: 20, height: 20))
        let piece2 = Piece(pieceView: pieceView2)
        expect(PiecePositioner.cornerForPosition(piece2.originalPosition, inRect: self.pieceContainerView.bounds)).to(equal(Corner.TopRight))
        
        let pieceView3 = UIView(frame: CGRect(x: 20, y: 120, width: 20, height: 20))
        let piece3 = Piece(pieceView: pieceView3)
        expect(PiecePositioner.cornerForPosition(piece3.originalPosition, inRect: self.pieceContainerView.bounds)).to(equal(Corner.BottomLeft))
        
        let pieceView4 = UIView(frame: CGRect(x: 120, y: 120, width: 20, height: 20))
        let piece4 = Piece(pieceView: pieceView4)
        expect(PiecePositioner.cornerForPosition(piece4.originalPosition, inRect: self.pieceContainerView.bounds)).to(equal(Corner.BottomRight))
    }

}
