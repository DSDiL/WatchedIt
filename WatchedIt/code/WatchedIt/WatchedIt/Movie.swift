//
//  Movies.swift
//  WatchedIt
//
//  Created by Dilanka Weerasekara on 6/14/23.
//

import SwiftUI

struct Movie: Identifiable {
    var id: String
    var movieName: String
    var description: String
    var catogery: String
    var watchedDate: String
    var rating: Double
    var email: String
    var wishlist: Bool
}
