//
//  chatkitStructs.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/30/19.
//  Copyright © 2019 438group. All rights reserved.
//

import Foundation

struct RoomResult:Decodable {
    let rooms: [Room]
}

struct Room:Decodable {
    let id: Int
    let member_user_ids: [String]
}

struct tokenRequest:Decodable {
    let access_token:String
}
