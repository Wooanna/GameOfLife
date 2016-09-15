//
//  Cell.swift
//  GameOfLife
//
//  Created by Yoanna Mareva on 9/15/16.
//  Copyright © 2016 Yoanna Mareva. All rights reserved.
//

import Foundation
enum State {
    case live, dead
}

struct Coordinates {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

struct Cell {
    var state : State
    var coordinates: Coordinates
    var size : Int
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
        self.state = .live
        self.size = 9
    }
}
