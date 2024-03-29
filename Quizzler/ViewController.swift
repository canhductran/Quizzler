//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber: Int = 0
    var score: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstQuestion = allQuestions.list[0];
        questionLabel.text = firstQuestion.questionText
        
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber = questionNumber + 1
        
        nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber)/13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber)
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        }
        else {
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        let firstQuestion = allQuestions.list[questionNumber]
        let correctAnswer = firstQuestion.answer
    
        if correctAnswer == pickedAnswer {
            print("You got it")
            score = score + 1
        }
        else {
            print ("You're wrong")
        }
    }
    
    
    func startOver() {
        questionNumber = 0;
        
        updateUI()
        
        nextQuestion()
    }
}
