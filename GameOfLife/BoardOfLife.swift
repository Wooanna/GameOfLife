//
//  BoardOfLife.swift
//  GameOfLife
//
//  Created by Yoanna Mareva on 9/15/16.
//  Copyright © 2016 Yoanna Mareva. All rights reserved.
//

import Foundation
import UIKit

struct BoardOfLife {
    
    static var cells = [Cell]()
    var isZoomedIn = false
    var isZoomedOut = false
    
    mutating func initializeCell(location: CGPoint) {
        let coords = cellCoordinatesOn(location: location)
        let cell = Cell(coordinates: coords)
        BoardOfLife.cells.append(cell)
    }
    
    func cellCoordinatesOn(location: CGPoint) -> Coordinates {
        let x = roundToTens(n: Double(location.x))
        let y = roundToTens(n: Double(location.y))

        return Coordinates(x: x, y: y)
    }
    
    func roundToTens(n : Double) -> Int {
        return Int(floor(n / 10.0)) * 10
    }
}
