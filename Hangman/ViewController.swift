//
//  ViewController.swift
//  Hangman
//
//  Created by Cal on 9/17/14.
//  Copyright (c) 2014 Cal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    final var wordList: [String] = ["hello", "juice", "family", "computer", "windows", "macaroni", "hennessy", "control", "power", "visibly", "victory", "follower", "leader", "superfluous", "hangman", "intersting", "dictionary", "sugar", "atom", "page", "swift", "objective", "success", "zoo", "swimmer", "finale", "season", "summer", "winter", "sprint", "jog"]
    
    var word : String = ""
    var guessedLetters: [String] = []
    var incorrectGuesses = 0
    var correctGuesses = 0
    var gameInProgress = true
    @IBOutlet weak var wordView: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var hangmanView: UIView!
    @IBOutlet weak var winText: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        word = wordList[Int(arc4random_uniform(31))]
        updateWordView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func lose(){
        winText.text = "You lose! The word was \"\(word)\"."
        winText.hidden = false
        playAgainButton.hidden = false
        gameInProgress = false
    }
    
    func win(){
        winText.text = "You win! You saved Nixon!"
        winText.hidden = false
        playAgainButton.hidden = false
        gameInProgress = false
        image.image = UIImage(named:"win.png")
    }

    @IBAction func reset(sender: AnyObject) {
        word = wordList[Int(arc4random_uniform(31))]
        guessedLetters = []
        updateWordView()
        image.image = UIImage(named:"0.png")
        gameInProgress = true
        incorrectGuesses = 0
        correctGuesses = 0
        for element in hangmanView.subviews{
            if let button = element as? UIButton{
                button.enabled = true
                button.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            }
        }
        winText.hidden = true
        playAgainButton.hidden = true
    }
    
    @IBAction func letterPress(sender: UIButton) {
        if(!gameInProgress){
            return
        }
        var letter = sender.titleLabel!.text!.lowercaseString
        guessedLetters.append(letter)
        updateWordView()
        sender.enabled = false
        sender.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        
        var chars = Array(word)
        var contains = false
        for x in 0...(chars.count - 1){
            if(String(chars[x]) == letter){
                contains = true
                break;
            }
        }
        
        if(!contains){
            incorrectGuesses++
            if(incorrectGuesses >= 10){
                lose()
            }
            image.image = UIImage(named:"\(String(incorrectGuesses)).png")
        }
        
    }
    
    func updateWordView(){
        var output = ""
        var chars = Array(word)
        var underscores = 0
        for x in 0...(chars.count - 1){
            if(contains(guessedLetters, String(chars[x]))){
                output += String(chars[x]) + " "
            }else{
                output += "_ "
                underscores++
            }
        }
        wordView.text = output
        if(underscores == 0){
            win()
        }
    }
    
}

