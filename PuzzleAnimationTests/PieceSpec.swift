//
//  PieceSpec.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/10/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import Quick
import Nimble

@testable import PuzzleAnimation

class PieceSpec: QuickSpec {
    override func spec() {
        describe("the 'Piece'") {
            var view: UIView!
            var piece: Piece!
            beforeEach {
                view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                piece = Piece(pieceView: view)
            }
            it("has a view after init") {
                expect(piece.view).to(equal(view))
            }
            it("should update view frame on initialPosition set") {
                piece.initialPosition = CGPoint(x: 50, y: 100)
                expect(piece.view.frame.origin).to(equal(CGPoint(x: 50, y: 100)))
            }
        }
    }
}
