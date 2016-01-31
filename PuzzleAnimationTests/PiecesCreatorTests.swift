//
//  PiecesCreatorTests.swift
//  PuzzleAnimation
//
//  Created by Anton Domashnev on 1/17/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import FBSnapshotTestCase
import Nimble

@testable import PuzzleAnimation

class PiecesCreatorTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        self.recordMode = false
        self.usesDrawViewHierarchyInRect = true
    }
    
    func testThatItCreatesPiecesThatCanReconstructView() {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.makeKeyAndVisible()
        
        let view: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        view.image = UIImage(named: "image")
        view.contentMode = UIViewContentMode.ScaleAspectFill
        view.clipsToBounds = true
        window.addSubview(view)
        
        let reconstructedView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        window.addSubview(reconstructedView)
        
        let date1 = NSDate(timeIntervalSinceNow: 0.1)
        NSRunLoop.currentRunLoop().runUntilDate(date1)
        
        let pieces: [Piece] = PiecesCreator.createPiecesFromView(view, pieceSideSize: 40)
        for piece in pieces {
            reconstructedView.addSubview(piece.view)
        }
        
        let date2 = NSDate(timeIntervalSinceNow: 0.1)
        NSRunLoop.currentRunLoop().runUntilDate(date2)
        
        FBSnapshotVerifyView(reconstructedView)
    }
    
    func testItAssignsCornerForAllPieces() {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.makeKeyAndVisible()
        
        let view: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        view.image = UIImage(named: "image")
        view.contentMode = UIViewContentMode.ScaleAspectFill
        view.clipsToBounds = true
        window.addSubview(view)
        
        let pieces: [Piece] = PiecesCreator.createPiecesFromView(view, pieceSideSize: 40)
        for piece in pieces {
            expect(piece.corner).toNot(beNil())
        }
    }
}
