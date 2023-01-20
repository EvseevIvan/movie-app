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
    
    var backImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "backImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    @IBOutlet weak var shadowOnImageView: UIView!
    var loginField: UITextField = {
        let field = UITextField()
        field.textFieldStyle(plaseHolderText: "Your username")
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var successLoginLabel: UILabel!
    let viewModel = AuthenticationViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
        loginButton.tintColor = .red
        showPasswordButton.tintColor = UIColor(red: 0.231, green: 0.38, blue: 1, alpha: 1)
        
        passwordField.textFieldStyle(plaseHolderText: "KLFJDKFJ")

        
        loginButton.layer.backgroundColor = UIColor(red: 0.231, green: 0.38, blue: 1, alpha: 1).cgColor
        loginButton.layer.cornerRadius = 9
        
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    
    }
    
    func setupConstraints() {
        
        view.addSubview(backImage)
        view.addSubview(loginField)
        
        NSLayoutConstraint.activate([
            backImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -5), // прибить к верху
            backImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -5), // прибить влево
            backImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5), // прибить вниз
            backImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5), // прибить вправо
            
//            backImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            loginField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginField.widthAnchor.constraint(equalToConstant: view.frame.width - 70),
            loginField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            loginField.heightAnchor.constraint(equalToConstant: 30)
            
            
            
            
            
        ])
        
    }
    

    @IBAction func showPasswordPressed(_ sender: Any) {
        if passwordField.isSecureTextEntry == true {
            passwordField.isSecureTextEntry = false
        } else {
            passwordField.isSecureTextEntry = true
        }
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


extension UITextField {
    func textFieldStyle(plaseHolderText: String) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0,
                                  y: self.frame.height - 2,
                                  width: self.frame.width,
                                  height: 2)
        bottomLine.backgroundColor = UIColor(red: 0.231, green: 0.38, blue: 1, alpha: 1).cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
        UITextField.appearance().tintColor = .white
        self.textColor = .white
        let redPlaceholderText = NSAttributedString(string: "\(plaseHolderText)",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                
        self.attributedPlaceholder = redPlaceholderText
        
    }
}


