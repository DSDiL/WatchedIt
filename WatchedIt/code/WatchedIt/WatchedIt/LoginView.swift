//
//  ContentView.swift
//  WatchedIt
//
//  Created by Dilanka Weerasekara on 6/13/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var email = ""
    @State private var password = ""
    @State private var errorMsg = ""
    @State private var navigation = false
    @State private var loggedIn = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.opacity(0.7).ignoresSafeArea()
                Circle().scale(1.4).foregroundColor(.white.opacity(0.5))
                
                VStack {
                    NavigationLink(destination: HomeView(), isActive: $loggedIn) {
                        EmptyView()
                    }
                    .hidden()
                    
                    HStack {
                        Text("Welcome!")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                            .foregroundColor(.black.opacity(0.9))
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        TextField("Email Address", text: $email)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(15)
                            .autocapitalization(.none)
                            .onTapGesture {
                                errorMsg = ""
                            }
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        SecureField("Password", text: $password)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(15)
                            .autocapitalization(.none)
                            .onTapGesture {
                                errorMsg = ""
                            }
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        Button("Login") {
                            userLogin()
                        }
                        .foregroundColor(.white.opacity(0.9))
                        .frame(width: 200, height: 50)
                        .bold()
                        .font(.title2)
                        .background(.blue)
                        .cornerRadius(15)
                    }
                    .padding(.bottom, 10)
                    
                    if errorMsg != "" {
                        HStack {
                            Text (errorMsg)
                                .font(.footnote)
                                .foregroundColor(.red)
                        }
                        .padding()
                    }
                    
                    HStack {
                        Button (action: {
                            navigation = true
                        }) {
                            Text ("Doesn't have an account? Signup")
                                .bold()
                                .foregroundColor(.black.opacity(0.9))
                        }
                    }
                    .padding()
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarHidden(true)
    }
    
    func userLogin() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMsg = "User login failed: \(error.localizedDescription)"
                print(errorMsg)
            } else {
                print("User login successful")
                errorMsg = ""
                loggedIn = true
                dataManager.email = email
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(DataManager())
    }
}
