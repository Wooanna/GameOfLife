//
//  RoundedButton.swift
//  GameOfLife
//
//  Created by Yoanna Mareva on 9/15/16.
//  Copyright © 2016 Yoanna Mareva. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
       required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 25
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
