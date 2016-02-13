//
//  PieceTests.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/10/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import XCTest
import Nimble

@testable import ADPuzzleAnimation

class PieceTests: XCTestCase {

    var view: UIView!
    var piece: Piece!
    
    override func setUp() {
        super.setUp()
        view = UIView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        piece = Piece(pieceView: view)
    }
    
    func testThatItHasAViewAfterInit() {
        expect(self.piece.view).to(equal(view))
    }
    
    func testThatItHasAnOriginalPositionAfterInit() {
        expect(self.piece.originalPosition).to(equal(CGPoint(x: 10, y: 10)))
    }

    func testThatItChangesViewOriginAfterSetInitialPosition() {
        self.piece.initialPosition = CGPoint(x: 50, y: 100)
        expect(self.piece.view.frame.origin).to(equal(CGPoint(x: 50, y: 100)))
    }
}
