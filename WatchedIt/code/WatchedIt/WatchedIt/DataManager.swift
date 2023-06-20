//
//  DataManager.swift
//  WatchedIt
//
//  Created by Dilanka Weerasekara on 6/14/23.
//

import SwiftUI
import Firebase
import NaturalLanguage
import CoreML

class DataManager: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var descriptions: [Description] = []
    @Published var embeddedDesc: [MovieDB] = []
    @Published var results: [MovieDB] = []
    @Published var embeddedValues: [Double] = []
    
    @Published var email: String = "" {
        didSet {
            fetchMovies()
        }
    }
    @Published var selectedOption: String = "" {
        didSet {
            fetchMovies()
        }
    }
    
    init() {
        fetchDescriptions()
    }
    
    func fetchMovies() {
        movies.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Movies")
        
        var query: Query
        
        if selectedOption == "Watched" {
            query = ref.whereField("email", isEqualTo: self.email).whereField("wishlist", isEqualTo: false)
        }
        else if selectedOption == "Wishlist" {
            query = ref.whereField("email", isEqualTo: self.email).whereField("wishlist", isEqualTo: true)
        }
        else {
            query = ref.whereField("email", isEqualTo: self.email)
        }
        
        query.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let movieName = data["movieName"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let catogery = data["catogery"] as? String ?? ""
                    let watchedDate = data["watchedDate"] as? String ?? ""
                    let rating = data["rating"] as? Double ?? 0
                    let email = data["email"] as? String ?? ""
                    let wishlist = data["wishlist"] as? Bool ?? false
                    
                    let movie = Movie(id: id, movieName: movieName, description: description, catogery: catogery, watchedDate: watchedDate, rating: rating, email: email, wishlist: wishlist)
                    self.movies.append(movie)
                }
            }
        }
    }
    
    func addMovies(movieName: String, description: String, catogery: String, watchedDate: String, rating: Double, wishlist: Bool) {
        let id = NSUUID().uuidString
        let db = Firestore.firestore()
        let ref = db.collection("Movies").document(id)
        ref.setData(["id": id, "movieName": movieName, "description": description, "catogery": catogery, "watchedDate": watchedDate, "rating": rating, "email": self.email, "wishlist": wishlist]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteMovie(id: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Movies")
        ref.document(id).delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Document deleted successfully.")
            }
        }
    }
    
    func updateMovies(id: String, catogery: String, watchedDate: String, rating: Double, wishlist: Bool) {
        let db = Firestore.firestore()
        let ref = db.collection("Movies")
        ref.document(id).updateData(["catogery": catogery, "watchedDate": watchedDate, "rating": rating, "wishlist": false]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Document updated successfully.")
            }
        }
    }
    
    func fetchDescriptions() {
        descriptions.removeAll()
        embeddedDesc.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Descritions")
        
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let movie = data["movie"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    
                    let desc = Description(id: id, movie: movie, description: description)
                    self.descriptions.append(desc)
                }
                
                for desc in self.descriptions {
                    if let embedding = NLEmbedding.sentenceEmbedding(for: .english) {
                        if let vector = embedding.vector(for: desc.description) {
                            let embeddedDesc = MovieDB(id: desc.id, movie: desc.movie, description: vector)
                            self.embeddedDesc.append(embeddedDesc)
                            print("f\(vector)")
                        }
                    }
                }
            }
        }
    }
    
    func serchMovie(desc: String) {
        if let embedding = NLEmbedding.sentenceEmbedding(for: .english) {
            if let vector = embedding.vector(for: desc.description) {
                embeddedValues.append(contentsOf: vector)
                print(vector)
            }
        }
        
        for movie in embeddedDesc {
            let similarity = calcSimilarity(embedding1: embeddedValues, embedding2: movie.description)
            if similarity > 0.5 {
                results.append(movie)
            }
        }
    }
                
    func calcSimilarity(embedding1: [Double], embedding2: [Double]) -> Double {
        var dotProduct = 0.0
        
        for i in 0..<embedding1.count {
            dotProduct += embedding1[i] * embedding2[i]
        }
        
        let magnitude1 = sqrt(embedding1.reduce(0, { $0 + $1 * $1 }))
        let magnitude2 = sqrt(embedding2.reduce(0, { $0 + $1 * $1 }))
        
        let similarity = dotProduct / (magnitude1 * magnitude2)

        return similarity
    }
}
              
