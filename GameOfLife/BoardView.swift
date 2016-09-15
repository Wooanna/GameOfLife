//
//  BoardView.swift
//  GameOfLife
//
//  Created by Yoanna Mareva on 9/15/16.
//  Copyright © 2016 Yoanna Mareva. All rights reserved.
//

import UIKit
import CoreGraphics
class BoardView: UIView {

    var rects = [CGRect]()
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            
        context.setStrokeColor(UIColor.darkGray.cgColor)
            for cell in BoardOfLife.cells {
                let cell = CGRect(x: cell.coordinates.x, y: cell.coordinates.y, width: cell.size, height: cell.size)
                rects.append(cell)
            }
            
        context.fill(rects)
        }
    }
}
