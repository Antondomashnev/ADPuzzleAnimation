//
//  CollectionShuffle.swift
//  PuzzleLoader
//
//  Created by Anton Domashnev on 1/3/16.
//  Copyright © 2016 Anton Domashnev. All rights reserved.
//  Thanks http://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift

import UIKit

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
