//
//  PiecePositioner.swift
//  ADPuzzleLoader
//
//  Created by Anton Domashnev on 1/8/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

enum Corner {
    case BottomLeft
    case TopLeft
    case BottomRight
    case TopRight
}

class PiecePositioner {
    
    class func cornerForPosition(position: CGPoint, inRect rect: CGRect) -> Corner {
        let middleX = CGRectGetMidX(rect)
        let middleY = CGRectGetMidY(rect)
        if position.x < middleX {
            if position.y > middleY {
                return .BottomLeft
            }
            else {
                return .TopLeft
            }
        }
        else {
            if position.y < middleY {
                return .TopRight
            }
            else {
                return .BottomRight
            }
        }
    }
    
    /**
     It calculates the positions for the piece outside of the given container view. It divides the piece container view into for corners and based on the given piece position calculates the initial position for the piece. It should be outside of the key window.
     
     - parameter piece:              piece view to calculate position for
     - parameter pieceWidth:         piece view width
     - parameter pieceContainerView: view that contains pieces
     
     - returns: initial top left point for the given piece view
     */
    class func piecePositionOutsideOfView(piece: Piece, pieceWidth: CGFloat, fromView pieceContainerView: UIView, screenSize: CGSize = UIScreen.mainScreen().bounds.size) -> CGPoint {
        let delta: CGFloat = pieceWidth
        let pieceContainerShiftInWindow = pieceContainerView.convertPoint(CGPointZero, toView: nil)
        
        switch self.cornerForPosition(piece.originalPosition, inRect: pieceContainerView.bounds) {
        case .TopLeft:
            if Random.generate() {
                //Delta by horizontal
                let x = -pieceContainerShiftInWindow.x - Random.within(0...delta) - delta
                let y = Random.within(-pieceContainerShiftInWindow.y...pieceContainerView.frame.height / 2.0)
                return CGPoint(x: x, y: y)
            }
            else {
                //Delta by vertical
                let x = Random.within(-pieceContainerShiftInWindow.x...pieceContainerView.frame.width / 2.0)
                let y = -pieceContainerShiftInWindow.y - Random.within(0...delta) - delta
                return CGPoint(x: x, y: y)
            }
        case .TopRight:
            if Random.generate() {
                //Delta by horizontal
                let x = (screenSize.width - pieceContainerShiftInWindow.x) + Random.within(0...delta) + delta
                let y = Random.within(-pieceContainerShiftInWindow.y...pieceContainerView.frame.height / 2.0)
                return CGPoint(x: x, y: y)
            }
            else {
                //Delta by vertical
                let x = Random.within(pieceContainerView.frame.width / 2.0...(screenSize.width - pieceContainerShiftInWindow.x))
                let y = -pieceContainerShiftInWindow.y - Random.within(0...delta) - delta
                return CGPoint(x: x, y: y)
            }
        case .BottomRight:
            if Random.generate() {
                //Delta by horizontal
                let x = (screenSize.width - pieceContainerShiftInWindow.x) + Random.within(0...delta) + delta
                let y = Random.within(pieceContainerView.frame.height / 2.0...(screenSize.height - pieceContainerShiftInWindow.y))
                return CGPoint(x: x, y: y)
            }
            else {
                //Delta by vertical
                let x = Random.within(pieceContainerView.frame.width / 2.0...(screenSize.width - pieceContainerShiftInWindow.x))
                let y = Random.within(0...delta) + (screenSize.height - pieceContainerShiftInWindow.y) + delta
                return CGPoint(x: x, y: y)
            }
        case .BottomLeft:
            if Random.generate() {
                //Delta by horizontal
                let x = -pieceContainerShiftInWindow.x - Random.within(0...delta) - delta
                let y = Random.within(pieceContainerView.frame.height / 2.0...(screenSize.height - pieceContainerShiftInWindow.y))
                return CGPoint(x: x, y: y)
            }
            else {
                //Delta by vertical
                let x = Random.within(-pieceContainerShiftInWindow.x...pieceContainerView.frame.width / 2.0)
                let y = Random.within(0...delta) + (screenSize.height - pieceContainerShiftInWindow.y) + delta
                return CGPoint(x: x, y: y)
            }
        }
    }
}
