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
        case predefined
    }
    
    // MARK: - Properties
    var state: State = .predefined {
        didSet {
            switch state {
            case .predefined:
                setPredefinedStateInView()
            case .custom:
                setCustomStateInView()
            }
        }
    }
    
    var greetingText: String? {
        didSet {
            updateGreetingsLabelText()
        }
    }
    
    var nameText: String? {
        didSet {
            updateGreetingsLabelText()
        }
    }
    
    var lastGreetingsButtonString: String?
    var lastCustomGreeting: String?
    
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
        prepareInitialGreeting()
        prepareGreetingsTextFieldTargetAction()
        prepareNameTextFieldTargetAction()
    }
    
    // MARK: - Preparations
    func prepareInitialGreeting() {
        prepareLastGreetingsStrings()
        prepareGreetingLabels()
    }
    
    func prepareLastGreetingsStrings() {
        lastGreetingsButtonString = Button.hello.rawValue
        lastCustomGreeting = greetingsTextField.text
    }
    
    func prepareGreetingLabels() {
        greetingText = lastGreetingsButtonString
        nameText = nameTextField.text
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
            state = .predefined
            greetingText = lastGreetingsButtonString
        case 1:
            state = .custom
            greetingText = lastCustomGreeting
        default:
            print("Default")
            break
        }
    
    }
    
    @IBAction func greetingsButtonPressed(_ sender: UIButton) {
        lastGreetingsButtonString = sender.titleLabel?.text
        greetingText = lastGreetingsButtonString
    }
    
    // MARK: - Helper Methods
    func textFieldDidChange(_ sender: UITextField) {
        if sender == greetingsTextField {
            greetingText = greetingsTextField.text
            lastCustomGreeting = greetingText
        } else if sender  == nameTextField {
            nameText = nameTextField.text
        }
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
    
    func updateGreetingsLabelText() {
        greetingsLabel.text = (greetingText ?? "") + " " + (nameText ?? "")
    }
}


