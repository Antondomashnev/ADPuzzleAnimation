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
    
    private var animation: PuzzleAnimation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Actions
    
    @IBAction func startForwardAnimationButtonClicked(sender: UIButton) {
        self.animation = ForwardPuzzleAnimation(viewToAnimate: self.imageView, inWindow: UIApplication.sharedApplication().keyWindow!, pieceSide: 40)
        self.animation!.start()
    }
    
    @IBAction func startBackwardAnimationButtonClicked(sender: UIButton) {
        self.animation = BackwardPuzzleAnimation(viewToAnimate: self.imageView, inWindow: UIApplication.sharedApplication().keyWindow!, pieceSide: 40)
        self.animation?.animationVelocity = 10
        self.animation!.start()
    }
}

