//
//  Structs.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/17/19.
//  Copyright © 2019 438group. All rights reserved.
//

import Foundation

// Do any modifications you feel like to these structs below if needed:

struct Course{
    let id:String
    let title: String
    let courseNumber: String
    let professor: Professor
    let department: String
    let overallRating: Double
    //let comments: [String]
}

struct Professor {
    let id:String
    let name: String
    let rating: Double
//    let comments: [String]
    let department: String
}

struct User {
    let userID: String
    let username: String
    let password: String
//    let favList: [Course]
//    let takenList: [Course]
//    let following: [Professor]
}

struct Rating {
    let user: User
    let rating: Double
    let comment: String
//    let course: Course // course和professor只有一个field是有效的
//    let professor: Professor
}
