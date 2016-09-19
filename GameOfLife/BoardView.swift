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
    var contentOffsetX = 0 {
        didSet {
            print(contentOffsetX)
        }
    }
    
    var contentOffsetY = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        rects.removeAll()
        if let context = UIGraphicsGetCurrentContext() {
            
        context.setStrokeColor(UIColor.darkGray.cgColor)
            for cell in BoardOfLife.cells {
                let rect = CGRect(x: cell.coordinates.x + contentOffsetX, y: cell.coordinates.y + contentOffsetY, width: cell.size, height: cell.size)
                
                rects.append(rect)
            }            
        context.fill(rects)
        }
    }
}
