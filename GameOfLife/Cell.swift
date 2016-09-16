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

class Cell: Equatable {
    var state : State
    var coordinates: Coordinates
    var size : Int
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
        self.state = .dead
        self.size = 9
    }
    
    static func == (left: Cell, right: Cell) -> Bool {
        return left.coordinates.x == right.coordinates.x && left.coordinates.y == right.coordinates.y && left.state == right.state
    }
}
