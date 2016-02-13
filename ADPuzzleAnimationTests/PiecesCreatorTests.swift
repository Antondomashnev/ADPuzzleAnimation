//
//  PiecesCreatorTests.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/17/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import FBSnapshotTestCase
import Nimble

@testable import ADPuzzleAnimation

class PiecesCreatorTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        self.recordMode = false
        self.usesDrawViewHierarchyInRect = true
    }
    
    func testItAssignsCornerForAllPieces() {
        
        let view: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        view.image = UIImage(named: "image")
        view.contentMode = UIViewContentMode.ScaleAspectFill
        view.clipsToBounds = true
        
        let pieces: [Piece] = PiecesCreator.createPiecesFromView(view, pieceSideSize: 40)
        for piece in pieces {
            expect(piece.corner).toNot(beNil())
        }
    }
}
