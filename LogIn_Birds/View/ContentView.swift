//
//  ContentView.swift
//  LogIn_Birds
//
//  Created by Jakub Patelski on 13/03/2023.
//

import SwiftUI
import FirebaseAuth
struct ContentView: View {
    
    @AppStorage("uid") var userID: String = ""

    var body: some View {
        
        if userID == ""{
            AuthView()
        } else{
          BirdsView()
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
