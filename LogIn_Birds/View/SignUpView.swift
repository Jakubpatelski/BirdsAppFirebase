//
//  SignUpView.swift
//  LogIn_Birds
//
//  Created by Jakub Patelski on 13/03/2023.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @Binding var currrentShowingView: String
    @AppStorage("uid") var userID: String = ""
    @AppStorage("email") var userEmail: String = ""


    @State private var email: String = ""
    @State private var password: String = ""
    
    private func isValidPassword(_ password: String) -> Bool {
        // minimum 6 characters long
        // 1 uppercase character
        // 1 special char
        
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{3,}$")
        
        return passwordRegex.evaluate(with: password)
    }
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 30){
                Spacer()
                HStack{
                    Text("Create an Account!")
                        .foregroundColor(Color(.systemCyan))
                        .font(.largeTitle)
                        .bold()
                    
                }
                .padding()
                .padding(.top)
                
                
                HStack{
                    Image(systemName: "mail")
                    TextField("Email", text: $email)
                    
                    Spacer()
                    
                    if(email.count != 0) {
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(email.isValidEmail() ? .green : .red)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                 Color(.systemPurple),
                                 Color(.systemTeal)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 2
                        )
                )
                
                HStack{
                    Image(systemName: "lock")
                    SecureField("Password", text: $password)
                    
                    Spacer()
                    
                    if(password.count != 0){
                        
                        
                        Image(systemName: isValidPassword(password) ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(isValidPassword(password) ? .green : .red)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                 Color(.systemPurple),
                                 Color(.systemTeal)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 2
                        )
                )
                
                Button(action: {
                    withAnimation {
                        self.currrentShowingView = "login"
                    }
                }) {
                    Text("Alrady have an account?")
                        .font(.title3)
                }
                
                Spacer()
                
                
                Button("Create new Account"){
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        if let authResult = authResult {
//                            print(authResult.user.uid)
                            print(authResult.user.email!)

                            userID = authResult.user.uid
                            userEmail = authResult.user.email!
                            
                            withAnimation {
                                self.currrentShowingView = "login"
                            }
                        }
                     
                    }
                }
                .foregroundColor(.white)
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                           LinearGradient(gradient: Gradient(colors: [Color(.systemTeal), Color(.systemPurple)]),
                                       startPoint: .leading,
                                       endPoint: .trailing
                                   )
                               )

                    )

                .padding(.horizontal)
                
                
            }
            .padding()
            
            
        }
        .background(
            LinearGradient(colors: [Color.cyan.opacity(0.7), Color.purple.opacity(0.3)], startPoint: .bottomTrailing, endPoint: .topLeading)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

