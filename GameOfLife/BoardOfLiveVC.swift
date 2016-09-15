//
//  BoardOfLiveVC.swift
//  GameOfLife
//
//  Created by Yoanna Mareva on 9/15/16.
//  Copyright © 2016 Yoanna Mareva. All rights reserved.
//

import UIKit

class BoardOfLiveVC: UIViewController {

    var gameBoard = BoardOfLife()
    var timer = Timer()
    
    @IBOutlet weak var boardView: BoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func restartBtnPressed(_ sender: AnyObject) {
        restartGame()
    }
    
    @IBAction func playBtnPressed(_ sender: AnyObject) {
        startGame()
    }

    @IBAction func pauseBtnPressed(_ sender: AnyObject) {
        pauseGame()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            gameBoard.initializeCell(location: location)
            boardView.setNeedsDisplay()
        }
    }
    
    func startGame() {
        if !timer.isValid {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("redraw"), userInfo: nil, repeats: true)
        }
    }
    
    func pauseGame() {
        if(timer.isValid) {
            timer.invalidate()
        }
    }
    
    func restartGame() {
        if(timer.isValid) {
            timer.invalidate()
        }
        BoardOfLife.cells = [Cell]()
        boardView.setNeedsDisplay()
    }
    
    func redraw() {
     
        boardView.setNeedsDisplay()
    }
}
