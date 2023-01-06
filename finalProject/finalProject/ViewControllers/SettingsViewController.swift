//
//  SettingsViewController.swift
//  finalProject
//
//  Created by Иван Евсеев on 21.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var userInformationBackView: UIView!
    @IBOutlet weak var accountID: UILabel!
    @IBOutlet weak var username: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        userInformationBackView.layer.cornerRadius = 10
        if isItGuestSession {
            username.text = "Guest"
        } else {
            username.text = userName
        }
        accountID.text = String(accounID)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextController = storyboard.instantiateViewController(withIdentifier: "AuthenticationViewController")
        nextController.modalPresentationStyle = .fullScreen
        self.dismiss(animated: true)
        self.present(nextController, animated: false)
        accounID = 0
        isItGuestSession = false
        userName = ""
        
    }
    

}
