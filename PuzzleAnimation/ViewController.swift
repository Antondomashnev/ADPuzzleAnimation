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
        self.forwardAnimation = ForwardPuzzleAnimation(viewToAnimate: self.imageView, inWindow: UIApplication.sharedApplication().keyWindow!, pieceSide: 40)
        self.forwardAnimation?.animationScale = 10
        self.forwardAnimation!.start()
    }
    
    @IBAction func startBackwardAnimationButtonClicked(sender: UIButton) {
        self.backwardAnimation = BackwardPuzzleAnimation(viewToAnimate: self.imageView, inWindow: UIApplication.sharedApplication().keyWindow!, pieceSide: 40)
        self.backwardAnimation?.animationScale = 10
        self.backwardAnimation!.start()
    }
    
    @IBAction func startBothAnimationsButtonClicked(sender: UIButton) {
        self.forwardAnimation = ForwardPuzzleAnimation(viewToAnimate: self.imageView, inWindow: UIApplication.sharedApplication().keyWindow!, pieceSide: 40)
        self.forwardAnimation?.animationScale = 10
        
        self.backwardAnimation = BackwardPuzzleAnimation(viewToAnimate: self.imageView, inWindow: UIApplication.sharedApplication().keyWindow!, pieceSide: 40)
        self.backwardAnimation?.animationScale = 10
        
        self.forwardAnimation?.animationCompletion = { [weak self] (animation, finished) in
            if finished {
                self?.backwardAnimation!.start()
            }
        }
        self.forwardAnimation!.start()
    }
}

