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
    var nc = NotificationCenter.default
    var contentOffsetX = 0 {
        didSet {
            print(contentOffsetX)
        }
    }
    
    var contentOffsetY = 0{
        didSet {
            print(contentOffsetY)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
         
            nc.post(name: NSNotification.Name(rawValue: "creatingNewCell"), object: nil, userInfo:["location" : location])
        }
        
    }
}
