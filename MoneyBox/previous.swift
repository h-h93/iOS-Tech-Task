//
//  previous.swift
//  MoneyBox
//
//  Created by hanif hussain on 17/02/2024.
//

import Foundation
/*
 
 // log the user into their account
 func loginUser() {
     guard let email = loginView.emailTextField.text else { displayErrorToUser("Email not valid")
         return }
     guard let password = loginView.passwordTextField.text else { displayErrorToUser("Password not valid")
         return }
     //email: "test+ios2@moneyboxapp.com", password: "P455word12"
     let request = Networking.LoginRequest(email: email, password: password)
     dataProvider.login(request: request) { result in
         switch result {
         case .success(let loginResponse):
             // get and store bearer token
             Networking.Authentication.token = loginResponse.session.bearerToken
             self.displayAccountView()
         case .failure(let error):
             // let's show the error to the user
             self.displayErrorToUser(error.localizedDescription)
         }
     }
 }
 
 
 // grab the users account data to display
 func getAccountData() {
     dataProvider.fetchProducts { response in
         switch response {
         case .success(let success):
             // push to main to create seamless experience
             DispatchQueue.main.async {
                 // i am force unwrapping here as we've succeeded in grabbing the users account data
                 // feed data into collection view
                 self.collectionView.account = success.accounts!
                 self.collectionView.productResponse = success.productResponses!
                 self.collectionView.collectionView.reloadData()
                 
                 // feed accounts into pie chart
                 self.pieChart.account = success.accounts!
                 // the user may not have contributed money to the account so we will apply nil coalescing
                 self.pieChart.accountTotal = success.totalPlanValue ?? 0
                 self.pieChart.setupPieChart()
             }
         case .failure(let error):
             print("failure \(error.localizedDescription)")
         }
     }
 }
 
 */
