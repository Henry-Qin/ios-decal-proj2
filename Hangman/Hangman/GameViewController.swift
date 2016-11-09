
//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

        
    @IBOutlet weak var _Label: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var incorrectGuessesLabel: UILabel!
    
    @IBOutlet weak var hangmanImageView: UIImageView!
    var answer: String = ""
    var mutatedStringPhrase: String = ""
    var incorrectGuesses: String = "Incorrect Guesses: "
    var incorrectGuessesArray: [String] = []
    var charactersNotGuessed: String = ""
    
    @IBAction func startOverButton(_ sender: AnyObject) {
        answer = ""
        mutatedStringPhrase = ""
        incorrectGuesses = "Incorrect Guesses: "
        incorrectGuessesArray = []
        charactersNotGuessed = ""
        self.viewDidLoad()
    }
    
    @IBAction func guessButton(_ sender: AnyObject) {
        if var guessText = guessTextField.text {
            if guessText.characters.count == 1 && Int(guessText) == nil{
                guessText = guessText.uppercased()
                guessTextField.text = ""
                if (answer.characters.index(of: Character(guessText)) == nil) {
                    incorrectGuessesArray.append(guessText)
                    hangmanImageView.image = UIImage(named: "hangman" + String(incorrectGuessesArray.count + 1) + ".gif")
                    incorrectGuesses = incorrectGuesses + " " + guessText
                    incorrectGuessesLabel.text = incorrectGuesses
                    print(mutatedStringPhrase)
                } else {
                    charactersNotGuessed = charactersNotGuessed.replacingOccurrences(of: guessText, with: "")
                    mutatedStringPhrase = answer
                    for char in charactersNotGuessed.characters {
                        mutatedStringPhrase = mutatedStringPhrase.replacingOccurrences(of: String(char), with: "_")
                    }
                    _Label.text = mutatedStringPhrase
                }
                if incorrectGuessesArray.count == 6 {
                    let lossAlertController = UIAlertController(title: "Game Over", message: "You made too many incorrect guesses!", preferredStyle: UIAlertControllerStyle.alert)
                    lossAlertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                    self.present(lossAlertController, animated: true, completion:nil)
                    answer = ""
                    mutatedStringPhrase = ""
                    incorrectGuesses = "Incorrect Guesses: "
                    incorrectGuessesArray = []
                    charactersNotGuessed = ""
                    self.viewDidLoad()
                }
                if mutatedStringPhrase == answer {
                    let lossAlertController = UIAlertController(title: "Congratulations!", message: "You Won!", preferredStyle: UIAlertControllerStyle.alert)
                    lossAlertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                    self.present(lossAlertController, animated: true, completion:nil)
                    answer = ""
                    mutatedStringPhrase = ""
                    incorrectGuesses = "Incorrect Guesses: "
                    incorrectGuessesArray = []
                    charactersNotGuessed = ""
                    self.viewDidLoad()
                }
            } else {
                let badGuessAlertController = UIAlertController(title: "Ill-Formed Guess", message: "Guess a single letter!", preferredStyle: UIAlertControllerStyle.alert)
                badGuessAlertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(badGuessAlertController, animated: true, completion:nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        
        print(phrase)
        answer = phrase!
        mutatedStringPhrase = phrase!
        charactersNotGuessed = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for char in charactersNotGuessed.characters{
           mutatedStringPhrase = mutatedStringPhrase.replacingOccurrences(of: String(char), with: "_")
        }
        print(mutatedStringPhrase)
        guessTextField.text = ""
        _Label.text = mutatedStringPhrase
        incorrectGuessesLabel.text = incorrectGuesses
        hangmanImageView.image = UIImage(named: "hangman1.gif")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
