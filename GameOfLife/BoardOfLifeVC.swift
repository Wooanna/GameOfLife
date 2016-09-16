//
//  BoardOfLiveVC.swift
//  GameOfLife
//
//  Created by Yoanna Mareva on 9/15/16.
//  Copyright © 2016 Yoanna Mareva. All rights reserved.
//

import UIKit

enum GameState {
    case new, running, paused
}

class BoardOfLifeVC: UIViewController {
    var state = GameState.new
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
        if (self.state == .new) {
            if let touch = touches.first {
                let location = touch.location(in: self.view)
                gameBoard.initializeCell(location: location)
                boardView.setNeedsDisplay()
            }
        }
    }
    
    func startGame() {
        if (self.state == .new || self.state == .paused) {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BoardOfLifeVC.update), userInfo: nil, repeats: true)
            self.state = .running
        }
    }
    
    func pauseGame() {
        if(self.state == .running) {
            timer.invalidate()
            self.state = .paused
        }
    }
    
    func restartGame() {
        if(self.state == .running || self.state == .paused) {
            timer.invalidate()
            self.state = .new
        }
        
        BoardOfLife.cells.forEach { $0.state = .dead }
        boardView.setNeedsDisplay()
    }
    
    func update() {
        gameBoard.update()
        boardView.setNeedsDisplay()
    }
}
