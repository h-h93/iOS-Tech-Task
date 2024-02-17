//
//  Operations.swift
//  MoneyBox
//
//  Created by hanif hussain on 17/02/2024.
//

import Foundation
import Networking

class Operations {
    let dataProvider = DataProvider()
    
    // log the user into their account
    func loginUser(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        //email: "test+ios2@moneyboxapp.com", password: "P455word12"
        let request = Networking.LoginRequest(email: email, password: password)
        dataProvider.login(request: request) { result in
            switch result {
            case .success(let loginResponse):
                // get and store bearer token
                Networking.Authentication.token = loginResponse.session.bearerToken
                completion(true, nil)
            case .failure(let error):
                // let's show the error to the user and return false as not able to login
                completion(false, error)
            }
        }
    }
    
    // grab the users account data to display
    func getAccountData(completion: @escaping (AccountResponse?, Error?) -> (Void)){
        dataProvider.fetchProducts { response in
            switch response {
            case .success(let success):
                completion(success, nil)
            case .failure(let error):
               completion(nil, error)
            }
        }
    }
}
