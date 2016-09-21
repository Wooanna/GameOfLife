//
//  Maths.swift
//  GameOfLife
//
//  Created by Yoanna Mareva on 9/21/16.
//  Copyright © 2016 Yoanna Mareva. All rights reserved.
//

import Foundation

class Maths {
    static func roundToTens(n : Double) -> Int {
        return Int(floor(n / 10.0)) * 10
    }
}
