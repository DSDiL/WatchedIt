[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/sHz1bMKn)
Please go under edit and edit this file as needed for your project.  There is no seperate documentation needed.

# Project Name - WatchedIt
# Student Id - IT20102678
# Student Name - D. L. B. Weerasekara

#### 01. Brief Description of Project - Lots of people, including myself, like to watch movies. And as we do watch lots of movies, we tend to forget what we have watched, what happened in the movie, and whether we liked it. They can also add a brief description, what type of movie it is, when it was released, and their ratings for the movie. Also it would be lovely to have a wishlist of movies, because sometimes the movies somehow you forgot to watch gets keep forgetting. 

#### 02. Users of the System - People who loves to watch movies
#### 03. What is unique about your solution - its simple, easy to use and helpful to those who needed
#### 04. Differences of Assignment 02 compared to Assignment 01 - In assignment two I have added login function, adding to wishlist, updating wishlist movies to watched movies, things like that. also if the user forgot a movie name they can search the name by adding movie description.
#### 05. Briefly document the functionality of the screens you have (Include screen shots of images)
e.g. The first screen is used to capture a photo and it will be then processed for identifying the landmarks in the photo.
![Screenshot 2023-06-17 002939](https://github.com/SE4020/assignment-02-it20102678/assets/113235487/4058135c-136c-4387-9829-417a1d53e123)
![Screenshot 2023-06-17 002911](https://github.com/SE4020/assignment-02-it20102678/assets/113235487/371438e0-0d04-4704-95ab-d2add8b610b6)
![Screenshot 2023-06-17 002844](https://github.com/SE4020/assignment-02-it20102678/assets/113235487/20f30150-a574-4506-bf41-1a7ec4d7bf6e)
![Screenshot 2023-06-17 002801](https://github.com/SE4020/assignment-02-it20102678/assets/113235487/353e01b4-55fb-4ce7-bcd9-278b103f6835)
![Screenshot 2023-06-17 002705](https://github.com/SE4020/assignment-02-it20102678/assets/113235487/bc2b8c64-55d5-497f-b5b7-2814be82a5c6)
![Screenshot 2023-06-17 002402](https://github.com/SE4020/assignment-02-it20102678/assets/113235487/905ab078-339f-4485-b2a2-875f3f2c869d)

#### 06. Give examples of best practices used when writing code
e.g The code below uses consistant naming conventions for variables, uses structures and constants where ever possible. (Elaborate a bit more on what you did)

```
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
// naming conventions for variables to easiy understand

```

#### 07. UI Components used

NavigationView, ZStack, HStack, VStack, Button, Image, Picker, Slider, DatePicker

#### 08. Testing carried out

#### 09. Documentation 

(a) Design Choices - Used a easy to look at color scheme and went with a minimalize design

(b) Implementation Decisions - had to think about flow of the app

(c) Challenges - Using libraries 

#### 10. Additional iOS Library used

A added a ML library embedd movie descriptions and find similaratize between set of stored movie descriptions and user given movie description. system will analyze both and suggest movie names based on given description. 

#### 11. Reflection of using SwiftUI compared to UIKit

SwiftUI was easier to use than UIkit

#### 12. Reflection General

As my app selection was movies, finding a library from given set of libraries bit of difficult. only usable libraries were ML ones or localizations. that was  bit dificult to choose.
  

