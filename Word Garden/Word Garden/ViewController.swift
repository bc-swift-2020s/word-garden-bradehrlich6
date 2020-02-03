//
//  ViewController.swift
//  Word Garden
//
//  Created by Brad Ehrlich on 2/3/20.
//  Copyright © 2020 Brad Ehrlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessedLetterField: UITextField!
    var WordtoGuess = "Swift"
    var lettersGuessed = ""
    let MaxNumberofWrongGuesses = 8
    var  WrongGuessesRemaining = 8
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }
    func updateUIAfterGuessed(){
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    func formatUserGuessLabel(){
    var revealedWord = ""
    lettersGuessed += guessedLetterField.text!
    
    for letter in WordtoGuess{
        if lettersGuessed.contains(letter){
            revealedWord = revealedWord + " \(letter)"
        } else {
            revealedWord += " _"
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    }
    
    
    func guessALetter(){
        formatUserGuessLabel()
        guessCount += 1
        let currentLetterGuessed = guessedLetterField.text!
        if !WordtoGuess.contains(currentLetterGuessed){
            WrongGuessesRemaining = WrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(WrongGuessesRemaining)")
        }
        
        let revealWord = userGuessLabel.text!
        if WrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
        } else if !revealWord.contains("_") {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
        }else {
            guessCountLabel.text = "You've made \(guessCount) guesses"
        }
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        WrongGuessesRemaining = MaxNumberofWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuessed()
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuessed()
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        } else {
            guessLetterButton.isEnabled = false
        }
    }
    

    
}

