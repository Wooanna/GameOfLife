//
//  Cell.swift
//  GameOfLife
//
//  Created by Yoanna Mareva on 9/15/16.
//  Copyright © 2016 Yoanna Mareva. All rights reserved.
//

import Foundation

struct Coordinates {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

class Cell: Equatable, Hashable {
    
    var coordinates: Coordinates
    var size : Int
    var possibleNewLife : [Cell]
    
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
        self.size = 9
        self.possibleNewLife = [Cell]()
    }
    
    var hashValue: Int {
        return self.coordinates.x.hashValue ^ self.coordinates.y.hashValue
    }
    
    static func == (left: Cell, right: Cell) -> Bool {
        return left.coordinates.x == right.coordinates.x && left.coordinates.y == right.coordinates.y
    }
}
