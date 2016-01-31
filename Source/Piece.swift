//
//  Piece.swift
//  ADPuzzleLoader
//
//  Created by Anton Domashnev on 1/7/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

class Piece: NSObject {

    /// What corner piece's view in superview belongs to
    var corner: Corner!
    
    /// Original underlined view position in it's superview
    var originalPosition: CGPoint
    
    /// Animation to position
    var desiredPosition: CGPoint!
    
    /// Animation from position
    var initialPosition: CGPoint! {
        didSet {
            self.view.frame = CGRect(origin: initialPosition, size: self.view.frame.size)
        }
    }
    
    let view: UIView
    
    init(pieceView: UIView) {
        view = pieceView
        if view.layer.anchorPoint != CGPointZero {
            let anchorDelta: CGPoint = view.layer.anchorPoint
            view.layer.anchorPoint = CGPointZero
            view.frame.origin = CGPoint(x: view.frame.origin.x - view.frame.width * anchorDelta.x, y: view.frame.origin.y - view.frame.height * anchorDelta.y)
            view.layer.position = view.frame.origin
        }
        
        originalPosition = pieceView.frame.origin
        super.init()
    }
    
}
