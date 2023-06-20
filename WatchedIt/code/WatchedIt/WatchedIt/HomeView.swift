//
//  HomeView.swift
//  WatchedIt
//
//  Created by Dilanka Weerasekara on 6/14/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedMovie: Movie? = nil
    @State private var addclicked = false
    @State private var selectedOption = ""

    let options = ["", "Watched", "Wishlist"]

    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.opacity(0.7).ignoresSafeArea()
                Circle().scale(1.9).foregroundColor(.white.opacity(0.5))
                
                NavigationLink(destination: NewMovieView(), isActive: $addclicked) {
                    EmptyView()
                }
                .hidden()
                
                VStack {
                    Text("Movies")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(.black.opacity(0.9))
                    
                    Picker("", selection: $dataManager.selectedOption) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 300)
                    .padding(.bottom, 20)
    
                    List(dataManager.movies, id: \.id) { movie in
                        HStack {
                            Text(movie.movieName)
                        }
                        .onTapGesture {
                            selectedMovie = movie
                        }
                    }
                    .cornerRadius(15)
                    .sheet(item: $selectedMovie) { movie in
                        MovieDetailsView(movie: movie)
                    }
                }
                .padding()
                .cornerRadius(15)
                .frame(alignment: .top)
                
                VStack {
                    Spacer()
                    
                    Button (action: {
                        addclicked = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 56, height: 56)
                            .foregroundColor(.blue)
                            .padding()
                    }
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(DataManager())
    }
}
