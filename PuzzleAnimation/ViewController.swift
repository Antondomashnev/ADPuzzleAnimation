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
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: - Actions
    
    @IBAction func startButtonClicked(sender: UIButton) {
        self.animation = PuzzleAnimation(viewToAnimate: self.imageView, inWindow: UIApplication.sharedApplication().keyWindow!, pieceSide: 40)
        self.animation!.start()
    }
}

