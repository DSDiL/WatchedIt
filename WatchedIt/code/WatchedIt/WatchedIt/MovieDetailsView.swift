//
//  MovieDetailsView.swift
//  WatchedIt
//
//  Created by Dilanka Weerasekara on 6/14/23.
//

import SwiftUI

struct MovieDetailsView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var deleteClicked = false
    @State private var updateClicked = false
    @State private var catogery = ""
    @State private var watchedDate = Date()
    @State private var rating = 0.0
    @State private var selectedOption = "Watched"
    @State private var errorMsg = ""
    @State private var sucessMsg = ""
    @State private var saveClicked = false

    let catogeries = ["", "Action", "Comedy", "Documentary", "Drama", "Fantasy", "Horror", "Musical", "Mystery", "Romance", "Science Fiction", "Thriller", "Western"]

    let movie: Movie
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.7).ignoresSafeArea()
            Circle().scale(1.7).foregroundColor(.white.opacity(0.5))
            
            VStack {
                if deleteClicked == false {
                    HStack {
                        Text("Movie Details")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                            .foregroundColor(.black.opacity(0.9))
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        Text("Movie Name")
                            .frame(width: 150, alignment: .leading)
                            .font(.title2)
                        Text(movie.movieName)
                            .frame(width: 150, alignment: .leading)
                            .font(.title3)
                    }
                    .padding(.bottom, 10)

                    HStack {
                        Text("Desciption")
                            .frame(width: 150, alignment: .leading)
                            .font(.title2)
                        Text(movie.description)
                            .frame(width: 150, alignment: .leading)
                            .font(.title3)
                    }
                    .padding(.bottom, 20)

                    if movie.wishlist == false {
                        HStack {
                            Text("Catogery")
                                .frame(width: 150, alignment: .leading)
                                .font(.title2)
                            Text(movie.catogery)
                                .frame(width: 150, alignment: .leading)
                                .font(.title3)
                        }
                        .padding(.bottom, 10)

                        HStack {
                            Text("Rating")
                                .frame(width: 150, alignment: .leading)
                                .font(.title2)
                            Text(String(movie.rating))
                                .frame(width: 150, alignment: .leading)
                                .font(.title3)
                        }
                        .padding(.bottom, 10)
                        
                        HStack {
                            Text("Watched Date")
                                .frame(width: 150, alignment: .leading)
                                .font(.title2)
                            Text(movie.watchedDate)
                                .frame(width: 150, alignment: .leading)
                                .font(.title3)
                        }
                        .padding(.bottom, 20)
                    }
                    else {
                        HStack {
                            Button (action: {
                                updateClicked = true
                            }) {
                                Text("Watched this? Update then")
                                    .bold()
                                    .foregroundColor(.black.opacity(0.9))
                                    .frame(alignment: .leading)
                            }
                            .frame(alignment: .leading)
                        }
                        .padding(.bottom, 20)
                        
                        if updateClicked == true {
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
                            
                            HStack {
                                Button("Save") {
                                    if catogery != "" && formattedDate(date: watchedDate) != "" && rating != 0.0 {
                                        dataManager.updateMovies(id: movie.id, catogery: catogery, watchedDate: formattedDate(date: watchedDate), rating: rating, wishlist: false)
                                        sucessMsg = "Movie Updated Successfully"
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
                        }
                    }
                }
                else {
                    Text("Delete Successful")
                        .frame(width: 150, alignment: .leading)
                        .font(.title2)
                        .foregroundColor(.green)
                }
                
                HStack {
                    Button("Delete") {
                        dataManager.deleteMovie(id: movie.id)
                        deleteClicked = true
                    }
                    .foregroundColor(.white.opacity(0.9))
                    .frame(width: 200, height: 50)
                    .bold()
                    .font(.title2)
                    .background(.red)
                    .cornerRadius(15)
                }
            }
            .frame(width: 300, height: 50)
            .padding(.bottom, 20)
        }
    }
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie(id: "1", movieName: "Example Movie", description: "Example description", catogery: "Example category", watchedDate: "2023-06-14", rating: 4.5, email: "example@gmail.com", wishlist: true)
        return MovieDetailsView(movie: movie)
    }
}
