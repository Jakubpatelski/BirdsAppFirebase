//
//  AuthView.swift
//  LogIn_Birds
//
//  Created by Jakub Patelski on 13/03/2023.
//

import SwiftUI

struct AuthView: View {
    @State private var currentViewShowing: String = "login"//login or signup
    
    var body: some View {
        if(currentViewShowing == "login"){
            LoginView(currrentShowingView: $currentViewShowing)
        } else {
            SignUpView(currrentShowingView: $currentViewShowing)
                .transition(.move(edge: .bottom))
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
