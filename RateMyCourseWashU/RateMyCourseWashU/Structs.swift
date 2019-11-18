//
//  Structs.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/17/19.
//  Copyright © 2019 438group. All rights reserved.
//

import Foundation

// Do any modifications you feel like to these structs below if needed:

struct Course {
    let id:String
    let title: String
    let courseNumber: String
    let professor: String
    let department: String
    let rating: Double
    let comments: [String]
}

struct Professor {
    let id:String
    let name: String
    let rating: Double
    let comments: [String]
    let department: Int
}

struct User {
    let userID: Int
    let username: String
    let password: String
}
