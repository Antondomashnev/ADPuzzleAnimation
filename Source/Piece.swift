//
//  Piece.swift
//  ADPuzzleLoader
//
//  Created by Anton Domashnev on 1/7/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

class Piece: NSObject {

    var desiredPosition: CGPoint!
    var initialPosition: CGPoint! {
        didSet {
            self.view.frame = CGRect(origin: initialPosition, size: self.view.frame.size)
        }
    }
    
    let view: UIView
    
    init(pieceView: UIView) {
        view = pieceView
        super.init()
    }
    
}
