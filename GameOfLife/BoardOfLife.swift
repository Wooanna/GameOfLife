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
    
    static var cells = Set<Cell>()

    mutating func initializeCell(location: CGPoint) {
        let coords = cellCoordinatesOn(location: location)
        let cell = Cell(coordinates: coords)
        BoardOfLife.cells.insert(cell)
    }
    
    func update() {
        let liveCells = Array(BoardOfLife.cells)
        newLife(liveCells: liveCells)
        dyingCells(liveCells: liveCells)
    }
    
    func newLife(liveCells: [Cell]) {
        let possibleNeighboursCoords = [(x: -10, y: -10),
                                        (x: 0, y: -10),
                                        (x: 10, y: -10),
                                        (x: 10, y: 0),
                                        (x: 10, y: 10),
                                        (x: 0, y: 10),
                                        (x: -10, y: 10),
                                        (x: -10, y: 0)]

        for cell in liveCells {
            cell.possibleNewLife.removeAll()
            for i in 0...7 {
                let coordinates = Coordinates(x: cell.coordinates.x + possibleNeighboursCoords[i].x, y: cell.coordinates.y + possibleNeighboursCoords[i].y)
                cell.possibleNewLife.append(Cell(coordinates: coordinates))
            }
            
            for pnl in cell.possibleNewLife {
                if neighbours(for: pnl, cells: liveCells) == 3 {
                    BoardOfLife.cells.insert(pnl)
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
                    BoardOfLife.cells.remove(at: i)
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
        let x = Maths.roundToTens(n: Double(location.x))
        let y = Maths.roundToTens(n: Double(location.y))

        return Coordinates(x: x, y: y)
    }
    
    
}
