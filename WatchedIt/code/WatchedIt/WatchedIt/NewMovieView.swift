//
//  NewMovieView.swift
//  WatchedIt
//
//  Created by Dilanka Weerasekara on 6/14/23.
//

import SwiftUI

struct NewMovieView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var movieName = ""
    @State private var description = ""
    @State private var catogery = ""
    @State private var watchedDate = Date()
    @State private var rating = 0.0
    @State private var selectedOption = "Watched"
    @State private var errorMsg = ""
    @State private var sucessMsg = ""
    @State private var saveClicked = false
    @State private var isTicked = false
    @State private var isShowingPopup = false
    @State private var popupDesc = ""

    let catogeries = ["", "Action", "Comedy", "Documentary", "Drama", "Fantasy", "Horror", "Musical", "Mystery", "Romance", "Science Fiction", "Thriller", "Western"]
    
    let options = ["Watched", "Wishlist"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.opacity(0.7).ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.5))
                
                NavigationLink(destination: HomeView(), isActive: $saveClicked) {
                    EmptyView()
                }
                .hidden()
                
                VStack {
                    HStack {
                        Text("Add New Movie")
                            .font(.title)
                            .bold()
                            .padding()
                            .foregroundColor(.black.opacity(0.9))
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        TextField("Movie Name", text: $movieName)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .padding()
                            .frame(width: 320, height: 50)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(15)
                            .onTapGesture {
                                errorMsg = ""
                                sucessMsg = ""
                            }
                    }
                    .padding(.bottom, 20)
                    
                    HStack {
                        TextEditor(text: $description)
                            .padding()
                            .frame(width: 320, height: 100)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(15)
                            .onTapGesture {
                                errorMsg = ""
                                sucessMsg = ""
                            }
                    }
                    .padding(.bottom, 20)
                    
                    HStack {
                        RadioButtonGroup(selectedOption: $selectedOption)
                    }
                    .padding(.bottom, 20)
                    .frame(width: 300, height: 50)
                    
                    if selectedOption == "Watched" {
                        HStack {
                            Text("Catogery")
                                .frame(width: 100, alignment: .leading)
                            Picker("Movie Catogery", selection: $catogery) {
                                ForEach(catogeries, id: \.self) { type in
                                    Text(type)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 200)
                            .onTapGesture {
                                errorMsg = ""
                                sucessMsg = ""
                            }
                        }
                        .frame(width: 300, height: 50)
                        .padding(.bottom, 20)
                        
                        HStack {
                            Text("Rating")
                                .frame(width: 100, alignment: .leading)
                            Slider(value: $rating, in: 0...10)
                                .frame(width: 200)
                                .onTapGesture {
                                    errorMsg = ""
                                    sucessMsg = ""
                                }
                        }
                        .padding(.bottom, 20)
                        .frame(width: 300, height: 50)
                        
                        HStack {
                            DatePicker("Watched Date", selection: $watchedDate, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                                .frame(width: 300, alignment: .leading)
                                .onTapGesture {
                                    errorMsg = ""
                                    sucessMsg = ""
                                }
                        }
                        .padding(.bottom, 20)
                        .frame(width: 300, height: 50)
                    }
                    
                    HStack {
                        Button("Save") {
                            if selectedOption == "Watched" {
                                if movieName != "" && description != "" && catogery != "" && formattedDate(date: watchedDate) != "" && rating != 0.0 {
                                    dataManager.addMovies(movieName: movieName, description: description, catogery: catogery, watchedDate: formattedDate(date: watchedDate), rating: rating, wishlist: false)
                                    sucessMsg = "Movie Added Successfully"
                                    movieName = ""
                                    description = ""
                                    rating = 0.0
                                    watchedDate = Date()
                                    errorMsg = ""
                                    catogery = ""
                                    saveClicked = true
                                }
                                else {
                                    errorMsg = "Please Fill All Data"
                                    sucessMsg = ""
                                }
                            }
                            else {
                                if movieName != "" && description != "" {
                                    dataManager.addMovies(movieName: movieName, description: description, catogery: "", watchedDate: "", rating: 0, wishlist: true)
                                    sucessMsg = "Movie Added Successfully"
                                    movieName = ""
                                    description = ""
                                    rating = 0.0
                                    watchedDate = Date()
                                    errorMsg = ""
                                    catogery = ""
                                    saveClicked = true
                                }
                                else {
                                    errorMsg = "Please Fill All Data"
                                    sucessMsg = ""
                                }
                            }
                        }
                        .foregroundColor(.white.opacity(0.9))
                        .frame(width: 200, height: 50)
                        .bold()
                        .font(.title2)
                        .background(.blue)
                        .cornerRadius(15)
                    }
                    
                    if errorMsg != "" {
                        HStack {
                            Text (errorMsg)
                                .font(.footnote)
                                .foregroundColor(.red)
                        }
                        .padding()
                    }
                    
                    if sucessMsg != "" {
                        HStack {
                            Text (sucessMsg)
                                .font(.footnote)
                                .foregroundColor(.green)
                        }
                        .padding()
                    }
                    
                    HStack {
                        Button (action: {
                            isShowingPopup = true
                        }) {
                            Text ("Need a help remembering the movie name?")
                                .bold()
                                .foregroundColor(.black.opacity(0.9))
                        }
                    }
                    .padding()
                    .popover(isPresented: $isShowingPopup, content: {
                        VStack {
                            HStack {
                                Text("Search Movie by Description")
                                    .font(.title)
                                    .bold()
                                    .padding()
                                    .foregroundColor(.black.opacity(0.9))
                            }
                            .padding(.bottom, 10)
                            
                            HStack {
                                TextEditor(text: $popupDesc)
                                    .padding()
                                    .frame(width: 320, height: 100)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(15)
                                    .onChange(of: popupDesc) { newValue in
                                        dataManager.serchMovie(desc: newValue)
                                    }
                            }
                            .padding(.bottom, 20)
                            
                            List(dataManager.results) { movie in
                                Text(movie.movie)
                             }
                        }
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    })
                }
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}


struct RadioButtonGroup: View {
    @Binding var selectedOption: String

    var body: some View {
        Group {
            RadioButton(selectedOption: $selectedOption, option: "Wishlist")
            RadioButton(selectedOption: $selectedOption, option: "Watched")
        }
        .padding()
        .cornerRadius(15)
    }
}

struct RadioButton: View {
    @Binding var selectedOption: String
    let option: String

    var body: some View {
        HStack {
            Image(systemName: selectedOption == option ? "largecircle.fill.circle" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(selectedOption == option ? .blue : .gray)

            Text(option)
                .padding(.leading, 5)

            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedOption = option
        }
    }
}

struct NewMovieView_Previews: PreviewProvider {
    static var previews: some View {
        NewMovieView()
    }
}
