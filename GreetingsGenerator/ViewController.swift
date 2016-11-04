//
//  ViewController.swift
//  GreetingsGenerator
//
//  Created by Jake Zeal on 03/11/16.
//  Copyright © 2016 Jake. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Enums
    enum Button: String {
        case hello = "Hello"
        case hi = "Hi"
        case hey = "Hey"
        case whaddup = "Whaddup"
    }
    
    enum State: Int {
        case custom
        case button
    }
    
    // MARK: - Properties
    var state: State = .button {
        didSet {
            switch state {
            case .button:
                setPredefinedStateInView()
            case .custom:
                setCustomStateInView()
            }
        }
    }
    
    var greetingText: String?
    var nameText: String?
    
    var lastGreetingsButtonText: String?
    
    // MARK: - IBOutlets
    @IBOutlet weak var stateSegmentedControl: UISegmentedControl!
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var greetingsTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var greetingButtons: [UIButton]!
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setPredefinedStateInView()
        prepareGreetingsLabel()
        prepareGreetingsTextFieldTargetAction()
        prepareNameTextFieldTargetAction()
    }
    
    // MARK: - Preparations
    func prepareGreetingsLabel() {
        greetingText = Button.hello.rawValue
        nameText = nameTextField.text ?? ""
        setGreetingsLabelText()
    }
    
    func prepareGreetingsTextFieldTargetAction() {
        greetingsTextField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
    }
    
    func prepareNameTextFieldTargetAction() {
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
    }
    
    // MARK: - IBActions
    @IBAction func stateChanged(_ sender: UISegmentedControl) {
        
        switch stateSegmentedControl.selectedSegmentIndex {
        case 0:
            greetingText = lastGreetingsButtonText
            state = .button
            setGreetingsLabelText()
        case 1:
            state = .custom
        default:
            print("Default")
            break
        }
    
    }
    
    @IBAction func greetingsButtonPressed(_ sender: UIButton) {
        lastGreetingsButtonText = sender.titleLabel?.text
        greetingText = lastGreetingsButtonText
        setGreetingsLabelText()
    }
    
    // MARK: - Helper Methods
    func textFieldDidChange(_ sender: UITextField) {
        if sender == greetingsTextField {
            greetingText = greetingsTextField.text
        } else if sender  == nameTextField {
            nameText = nameTextField.text
        }
        setGreetingsLabelText()
    }
    
    func setGreetingsLabelText() {
        greetingsLabel.text = (greetingText ?? "") + " " + (nameText ?? "")
    }
    
    func setPredefinedStateInView() {
        for button in greetingButtons {
            button.isEnabled = true
        }
        
        greetingsTextField.isEnabled = false
    }
    
    func setCustomStateInView() {
        for button in greetingButtons {
            button.isEnabled = false
        }
        
        greetingsTextField.isEnabled = true
        
    }
    
}


