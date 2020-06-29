//
//  ViewController.swift
//  Homework_Monday_Lists
//
//  Created by Neil Bergenroth on 6/29/20.
//  Copyright © 2020 Neil Bergenroth. All rights reserved.
//

import UIKit

extension UIViewController
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

class ViewController: UIViewController {
    
    // declare class level properties
    
    var questions: [String] = ["Are you enjoying this course so far?","What is your favorite activity so far?","What are you most looking forward to?"]
    var answers: [String] = []
    var questionIndex: Int = 0
    var stringOfAnswers: String = ""
    
    //IB Outlets
    @IBOutlet weak var textAnswer: UITextField!
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var butStoreAnswer: UIButton!
    
    @IBOutlet weak var txtShowAnswers: UITextField!
    
    // fires when the view first loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // activiates the touch outside of the keyboard to dismiss the keyboard when finished answering
        self.setupToHideKeyboardOnTapOnView()

        // initiatlizes the question level with the first question from the questions array
        lblQuestion.text = questions[0]
    
    }

    // this function fires when the store answer button is clicked by the user
    
    @IBAction func storeAnswer(_ sender: Any) {
        
        if let answer = textAnswer.text {
            
            
            // if the user has recorded a response then we store the value and update the UI
            answers.append(answer)
                        
            // concantanates the values in the answers array together
           let string = answers.joined(separator: " ")
            
            //resets the answer textfield
            textAnswer.text = ""
            
            // clears the show answers field for display of the all of the answers stored so far
            txtShowAnswers.text = ""
            
            // displays the answers so far in the text field at the bottom of the screen
            txtShowAnswers.text = string
            
            // debugging to log the answers string to check it is all working
            print(stringOfAnswers)
            
            // advances the questions array index so that the next index in the quetions array is used to populate the question label at the top of the screen.
            questionIndex+=1
            
            // checks to see if all questions have been asked. If so, displays an alert to notifiy the user that the questionaire has been finished.
            
            // otherwise, displays the next question.
            if questionIndex < 3 {
                
                lblQuestion.text = questions[questionIndex]

            } else {
                
                // displays an alert box at the of the quiz with various options
                let alert = UIAlertController(title: "End Of Questionaire", message: "Thanks for your responses! Do you want to take the quiz again?", preferredStyle: .alert)
                
               alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.resetQuiz()
                }))
                
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

                self.present(alert, animated: true)
            
            }
            
            
        }
        
    
    }
    
    // function to reset the quiz if the user wants to take it agaain. 
    func resetQuiz() {
        
        questionIndex = 0
        txtShowAnswers.text = ""
        lblQuestion.text = questions[questionIndex]
        
    }
    
}

