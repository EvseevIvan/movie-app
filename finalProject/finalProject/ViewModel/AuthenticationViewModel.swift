//
//  AuthenticationViewModel.swift
//  finalProject
//
//  Created by Иван Евсеев on 04.01.2023.
//

import Foundation
import UIKit


class AuthenticationViewModel {
    
    public func makeSession(username: String, password: String, complition: @escaping (Bool) -> Void) {
        NetworkManager().getToken { token in
            NetworkManager().doTokenValidate(username: username, password: password, token: token) { token in
                let success = token.success
                complition(success)
                if token.success == false {
                } else {
                    NetworkManager().createSession(requestToken: token.requestToken ?? "") { sessionid in
                        sessionID = sessionid.sessionID ?? ""
                        if sessionid.failure == nil {
                            NetworkManager().getDetails(sessionID: sessionid.sessionID ?? "") { id in
                                accounID = id
                            }
                        } else {

                        }

                    }
                }

            }
        }

    }
    
}
