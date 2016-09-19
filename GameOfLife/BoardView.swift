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
    var background = [CGRect]()
    var nc = NotificationCenter.default
    var isBackgroundInitialized = false
    var contentOffsetX = 0 {
        didSet {
            print("x \(contentOffsetX)")
        }
    }
    
    
    
    var contentOffsetY = 0 {
        didSet {
            print("y \(contentOffsetY)")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        initBackground()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initBackground() {
        for i in 0...Int(self.frame.width/10) {
            for j in 0...Int(self.frame.height/10) {
                let rect = CGRect(x: 10 * i, y: 10 * j, width: 9, height: 9)
                background.append(rect)
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        rects.removeAll()
        if let context = UIGraphicsGetCurrentContext() {
          
            context.setFillColor(UIColor(red: 0.87, green: 0.96, blue: 0.98, alpha: 1.0).cgColor)
            context.fill(background)
           
            for cell in BoardOfLife.cells {
                
                let rect = CGRect(x: cell.coordinates.x + contentOffsetX, y: cell.coordinates.y + contentOffsetY, width: cell.size, height: cell.size)
                rects.append(rect)
            }
            context.setFillColor(UIColor.darkGray.cgColor)
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
