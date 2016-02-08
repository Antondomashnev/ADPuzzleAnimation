//
//  ViewController.swift
//  ADPuzzleLoader
//
//  Created by Anton Domashnev on 1/2/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var imageView: UIImageView!
    
    private var forwardAnimation: PuzzleAnimation?
    private var backwardAnimation: PuzzleAnimation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Actions
    
    @IBAction func startForwardAnimationButtonClicked(sender: UIButton) {
        var forwardConfiguration = PuzzleAnimationConfiguration()
        forwardConfiguration.animationVelocity = 20
        forwardConfiguration.pieceAnimationDelay = PuzzleAnimationDelay(minimumDelay: 0.15, maximumDelay: 0.5)
        forwardConfiguration.pieceGroupAnimationDelay = PuzzleAnimationDelay(minimumDelay: 0.25, maximumDelay: 0.5)
        self.forwardAnimation = ForwardPuzzleAnimation(viewToAnimate: self.imageView)
        self.forwardAnimation!.start()
    }
    
    @IBAction func startBackwardAnimationButtonClicked(sender: UIButton) {
        var backwardConfiguration = PuzzleAnimationConfiguration()
        backwardConfiguration.animationVelocity = 10
        backwardConfiguration.pieceAnimationDelay = defaultBackwardPieceAnimationDelay
        backwardConfiguration.pieceGroupAnimationDelay = defaultBackwardPieceGroupAnimationDelay
        self.backwardAnimation = BackwardPuzzleAnimation(viewToAnimate: self.imageView, configuration: backwardConfiguration)
        self.backwardAnimation!.start()
    }
    
    @IBAction func startBothAnimationsButtonClicked(sender: UIButton) {
        var forwardConfiguration = PuzzleAnimationConfiguration()
        forwardConfiguration.animationVelocity = 20
        forwardConfiguration.pieceAnimationDelay = PuzzleAnimationDelay(minimumDelay: 0.15, maximumDelay: 0.5)
        forwardConfiguration.pieceGroupAnimationDelay = PuzzleAnimationDelay(minimumDelay: 0.25, maximumDelay: 0.5)
        self.forwardAnimation = ForwardPuzzleAnimation(viewToAnimate: self.imageView, configuration: forwardConfiguration)
        
        var backwardConfiguration = PuzzleAnimationConfiguration()
        backwardConfiguration.animationVelocity = 10
        backwardConfiguration.pieceAnimationDelay = defaultBackwardPieceAnimationDelay
        backwardConfiguration.pieceGroupAnimationDelay = defaultBackwardPieceGroupAnimationDelay
        self.backwardAnimation = BackwardPuzzleAnimation(viewToAnimate: self.imageView, configuration: backwardConfiguration)

        self.forwardAnimation?.animationCompletion = { [weak self] (animation, finished) in
            if finished {
                let seconds = 0.5
                let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(dispatchTime, dispatch_get_main_queue(), { [weak self] in
                    self?.backwardAnimation!.start()
                })
            }
        }
        
        self.backwardAnimation?.animationCompletion = { [weak self] (animation, finished) in
            if finished {
                self?.imageView.hidden = true
            }
        }
        
        self.forwardAnimation!.start()
    }
}

