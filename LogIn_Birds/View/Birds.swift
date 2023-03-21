//
//  Birds.swift
//  LogIn_Birds
//
//  Created by Jakub Patelski on 13/03/2023.
//

import SwiftUI
import FirebaseAuth
import SwiftUI

struct BirdsView: View {
    @AppStorage("uid") var userID: String = ""
    @AppStorage("email") var userEmail: String = ""


    @ObservedObject var birdData = BirdData()
    var body: some View {
        NavigationView {
            List(birdData.birds) { bird in
                NavigationLink(destination: BirdDetailView(bird: bird)) {
                    HStack{
                        BirdRow(bird: bird)

                    }
                }
            }
            .navigationBarTitle("Birds")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let firebaseAuth = Auth.auth()
                        do {
                            try firebaseAuth.signOut()
                            withAnimation {
                                userID = ""
                                userEmail = ""
                            }
                            
                        } catch let signOutError as NSError {
                            print("Error signing out: %@", signOutError)
                        }
                    }, label: {
                        Text("Sign out")
                            .foregroundColor(Color.blue)
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("\(userEmail)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}


struct BirdRow: View {
    let bird: Bird
    
    var body: some View {
        HStack {
            
            AsyncImage(url: bird.imageUrl) { image in
                image
                    .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90, alignment: .center)
                        .cornerRadius(10)

            } placeholder: {
                ProgressView()

            }
            
            Text(bird.name)
                .font(.system(size: 18, weight: .semibold, design: .serif))
                .padding(.leading, 5)
                
            
        }
       
    }
       
}

struct BirdDetailView: View {
    let bird: Bird
    
    var body: some View {
        VStack {
            AsyncImage(url: bird.imageUrl){ image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical, 25)
                
            } placeholder: {
                ProgressView("Loading")
            }

            
            Text(bird.description)
                .font(.system(size:20, design: .serif))
                .lineLimit(7)
            
            Spacer()

            Link(destination: URL(string: bird.wikipediaUrl)!, label: {
                Image("wikipedia")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                
            })
            
        }
        .padding()
        .navigationBarTitle(bird.name)
//        .background(
//            LinearGradient(colors: [Color.cyan.opacity(0.7), Color.purple.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
//                .edgesIgnoringSafeArea(.all)
//        )
    }
}


