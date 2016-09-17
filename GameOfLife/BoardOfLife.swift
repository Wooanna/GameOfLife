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
    
    init() {
        for i in 0...25 {
            for j in 0...25 {
                BoardOfLife.cells.append(Cell(coordinates: Coordinates(x: i * 10, y: j * 10)))
            }
        }
    }
    
    mutating func initializeCell(location: CGPoint) {
        let coords = cellCoordinatesOn(location: location)
        let index = BoardOfLife.cells.index(where: { $0.coordinates.x == coords.x && $0.coordinates.y == coords.y })
        if let i = index {
        BoardOfLife.cells[i].state = .live
        }
    }
    
    func update() {
        let liveCells = BoardOfLife.cells.filter { $0.state == .live }
        let deadCells = BoardOfLife.cells.filter { $0.state == .dead }
        newLife(deadCells: deadCells, liveCells: liveCells)
        dyingCells(liveCells: liveCells)
    }
    
    func newLife(deadCells: [Cell], liveCells: [Cell]) {
        
        for deadCell in deadCells {
            
            if neighbours(for: deadCell, cells: liveCells) == 3 {
                let index = BoardOfLife.cells.index(where: { $0 == deadCell })
                if let i = index {
                    BoardOfLife.cells[i].state = .live
                }
            }
        }
    }
    
    func dyingCells(liveCells: [Cell]) {
        for liveCell in liveCells {
            let livingNeighbours = neighbours(for: liveCell, cells: liveCells)
            if(livingNeighbours > 3 || livingNeighbours < 2) {
                let index = BoardOfLife.cells.index(where: { $0 == liveCell })
                if let i = index {
                    BoardOfLife.cells[i].state = .dead
                }
            }
        }
    }
    
    func neighbours(for deadCell: Cell, cells: [Cell]) -> Int {
        var neighbours = 0
        for cell in cells {
            let delta = (abs(deadCell.coordinates.x - cell.coordinates.x), abs(deadCell.coordinates.y - cell.coordinates.y))
            
            switch(delta) {
            case (10,10), (10,0), (0,10):
                neighbours += 1
            default:
                break
            }
        }
        return neighbours
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
