//
//  ViewController.swift
//  RetroCalc
//
//  Created by Jibran Syed on 10/30/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import AVFoundation

class CalculatorViewController: UIViewController 
{
    enum CalcOperator: String
    {
        case divide = "/"
        case multiply = "*"
        case subtract = "-"
        case add = "+"
        case empty = "Empty"
    }
    
    
    
    @IBOutlet weak var lblCalcResults: UILabel!
    
    
    
    var audioPlayer: AVAudioPlayer!
    var runningNumber = ""
    var currentOperator = CalcOperator.empty
    var leftOperandValue = ""
    var rightOperandValue = ""
    var resultValue = ""
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.lblCalcResults.text = "0"
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let fileURL = URL(fileURLWithPath: path!)
        
        do
        {
            try audioPlayer = AVAudioPlayer(contentsOf: fileURL)
            audioPlayer.prepareToPlay() // Load for playing
        }
        catch
        {
            print("Sound loading error!")
            debugPrint(error)
        }
        
    }
    
    
    @IBAction func numberBtnPressed(sender: UIButton)
    {
        self.playSound()
        
        // String concat!
        self.runningNumber += "\(sender.tag)"    // Add typed button to the running number string
        self.lblCalcResults.text = self.runningNumber
    }
    
    
    @IBAction func onDividePressed(sender: Any)
    {
        self.processOperation(withOperator: .divide)
    }
    
    @IBAction func onMultiplyPressed(sender: Any)
    {
        self.processOperation(withOperator: .multiply)
    }
    
    @IBAction func onSubractPressed(sender: Any)
    {
        self.processOperation(withOperator: .subtract)
    }
    
    @IBAction func onAddPressed(sender: Any)
    {
        self.processOperation(withOperator: .add)
    }
    
    @IBAction func onEqualPressed(sender: Any)
    {
        self.processOperation(withOperator: self.currentOperator)
    }
    
    @IBAction func onClearPressed(sender: Any)
    {
        self.playSound()
        self.runningNumber = ""
        self.resultValue = ""
        self.leftOperandValue = ""
        self.rightOperandValue = ""
        self.lblCalcResults.text = "0"
        self.currentOperator = .empty
    }
    
    
    
    
    
    func playSound()
    {
        // Don't allow multi-plays
        if self.audioPlayer.isPlaying
        {
            self.audioPlayer.stop()
        }
        
        self.audioPlayer.play()
    }
    
    
    
    
    
    func processOperation(withOperator calcOperator: CalcOperator)
    {
        self.playSound()
        
        // If there currently is an operator in progress
        if self.currentOperator != .empty
        {
            // A user did type a number
            if self.runningNumber != ""
            {
                rightOperandValue = runningNumber
                runningNumber = ""
                
                if currentOperator == .multiply
                {
                    resultValue = "\(Double(leftOperandValue)! * Double(rightOperandValue)!)"
                }
                else if currentOperator == .divide
                {
                    resultValue = "\(Double(leftOperandValue)! / Double(rightOperandValue)!)"
                }
                else if currentOperator == .subtract
                {
                    resultValue = "\(Double(leftOperandValue)! - Double(rightOperandValue)!)"
                }
                else if currentOperator == .add
                {
                    resultValue = "\(Double(leftOperandValue)! + Double(rightOperandValue)!)"
                }
                
                leftOperandValue = resultValue
                self.lblCalcResults.text = resultValue
            }
            else    // A user didn't type numbers between operations
            {
                if currentOperator == .multiply
                {
                    resultValue = "\(Double(leftOperandValue)! * Double(rightOperandValue)!)"
                }
                else if currentOperator == .divide
                {
                    resultValue = "\(Double(leftOperandValue)! / Double(rightOperandValue)!)"
                }
                else if currentOperator == .subtract
                {
                    resultValue = "\(Double(leftOperandValue)! - Double(rightOperandValue)!)"
                }
                else if currentOperator == .add
                {
                    resultValue = "\(Double(leftOperandValue)! + Double(rightOperandValue)!)"
                }
                
                leftOperandValue = resultValue
                self.lblCalcResults.text = resultValue
            }
            
            self.currentOperator = calcOperator
        }
        else    // No operator in progress
        {
            // This is the first time an operator has been pressed
            leftOperandValue = runningNumber
            runningNumber = ""
            currentOperator = calcOperator
        }
    }
    
    
    
}
