//
//  ContentView.swift
//  WatchedIt
//
//  Created by Dilanka Weerasekara on 6/13/23.
//

import SwiftUI
import Firebase

struct SignupView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMsg = ""
    @State private var navigation = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.opacity(0.7).ignoresSafeArea()
                Circle().scale(1.4).foregroundColor(.white.opacity(0.5))
                
                VStack {
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
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(15)
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
                            .onTapGesture {
                                errorMsg = ""
                            }
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        Button("Sign Up") {
                            userRegistration()
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
                            Text ("Already have an account? Login")
                                .bold()
                                .foregroundColor(.black.opacity(0.9))
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    func userRegistration() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMsg = "User registration failed: \(error.localizedDescription)"
                print(errorMsg)
            } else {
                print("User registration successful")
                errorMsg = ""
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
