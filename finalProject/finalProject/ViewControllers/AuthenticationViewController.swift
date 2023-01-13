//
//  AuthenticationViewController.swift
//  finalProject
//
//  Created by Иван Евсеев on 04.12.2022.
//

import UIKit
import Alamofire

var isItGuestSession: Bool = false

class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var shadowOnImageView: UIView!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var successLoginLabel: UILabel!
    let viewModel = AuthenticationViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
        loginButton.tintColor = .red
        textFieldStyle(textField: loginField, plaseHolderText: "Your username")
        textFieldStyle(textField: passwordField, plaseHolderText: "Your password")
        showPasswordButton.tintColor = UIColor(red: 0.231, green: 0.38, blue: 1, alpha: 1)
        
        

        
        loginButton.layer.backgroundColor = UIColor(red: 0.231, green: 0.38, blue: 1, alpha: 1).cgColor
        loginButton.layer.cornerRadius = 9
        
        

    }
    

    @IBAction func showPasswordPressed(_ sender: Any) {
        if passwordField.isSecureTextEntry == true {
            passwordField.isSecureTextEntry = false
        } else {
            passwordField.isSecureTextEntry = true
        }
    }
    
    func textFieldStyle(textField: UITextField, plaseHolderText: String) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0,
                                  y: textField.frame.height - 2,
                                  width: textField.frame.width,
                                  height: 2)
        bottomLine.backgroundColor = UIColor(red: 0.231, green: 0.38, blue: 1, alpha: 1).cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        UITextField.appearance().tintColor = .white
        textField.textColor = .white
        let redPlaceholderText = NSAttributedString(string: "\(plaseHolderText)",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                
        textField.attributedPlaceholder = redPlaceholderText
        
    }

    
    
    @IBAction func guestSessionPressed(_ sender: Any) {
        NetworkManager().guestSession() { success in
            if success {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let nextController = storyboard.instantiateViewController(withIdentifier: "TapBar")
                nextController.modalPresentationStyle = .fullScreen
                self.dismiss(animated: true)
                self.present(nextController, animated: false)
                isItGuestSession = true
            } else {
                print("lala")
            }
        }
    }
    
    
    @IBAction func pressedLogin(_ sender: Any) {
        viewModel.makeSession(username: loginField.text ?? "" , password: passwordField.text ?? "") { success in
            if success {
                userName = self.loginField.text ?? ""
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let nextController = storyboard.instantiateViewController(withIdentifier: "TapBar")
                nextController.modalPresentationStyle = .fullScreen
                self.dismiss(animated: true)
                self.present(nextController, animated: false)
            } else if success == false {
                self.successLoginLabel.text = "Login failed."
            }
        }
        


    }
    
    
}



