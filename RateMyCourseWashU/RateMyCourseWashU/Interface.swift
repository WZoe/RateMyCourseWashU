//
//  Interface.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 11/9/19.
//  Copyright © 2019 438group. All rights reserved.
//

import Foundation
import Alamofire

func login(userName: String!, password: String!) ->Bool{
    let parameters: [String: String] = [
        "username": userName,
        "password": password
    ]
    var ret:Bool = false
    AF.request("http://52.170.3.234:3456/login",
               method: .post,
               parameters: parameters,
               encoder: JSONParameterEncoder.default).validate().responseJSON { response in
                debugPrint(response)
                var json = JSON(response.data!)
                if json["Success"].boolValue == true {
                    ret = true
                }else{
                    ret = false
                }
    }
    return ret
}

func signup(userName: String!, password: String!)->String{
    let parameters: [String: String] = [
        "user": userName,
        "password": password
    ]
    var ret:String = "hello"
    AF.request("http://52.170.3.234:3456/signup",
               method: .post,
               parameters: parameters,
               encoder: JSONParameterEncoder.default).validate().responseJSON { response in
                debugPrint(response)
                var json = JSON(response.data!)
                if json["Success"].boolValue == true {
                    ret = "Sign up successfully"
                }else if json["Message"].intValue == 1 {
                    ret = "Please try another userName"
                }
    }
    return ret
    //return "Sign up successfully" if given valid userName and password
    //return "Please try another userName" if the userName has been registered
    //return "Please enter a valid password" if the password is too simple (please set some rules for password)
    
}

//func fetchCourseList(order: Int) -> [Course] {
//    //sortBy: 0 - any order, 1: by rating high to low, 2: by department
//    // by department可以先不实现，没想好怎么弄
//}
//
//func fetchProfessorList() -> [Professor] {
//
//}
//
//func courseSearchResult(keyword: String) -> [Course] {
//
//}
//
//func professorSearchResult(keyword: String) -> [Professor] {
//
//}
//
//func submitRating2Course(user: User, rating: Double, comment:String, course: Course) -> Bool{
//
//}
//
//func submitRating2Prof(user: User, rating: Double, comment:String, professor: Professor) -> Bool{
//
//}
//
//func fetchPreviousStudents(course: Course) -> [User]{
//    // return a random list of students who have taken a course
//    // 可以把数量限制一下，比如只返回20个就够了
//}
//
//func courseRecommendation(course:Course) -> [Course] {
//    // return recommendations of courses
//    // 可以根据previous students的taken course list来推荐，可以限制数量在比如5个左右
//}
//
//func add2Fav(course: Course, user: User) -> Bool {
//    // 用户把一门课程加入到favorite list
//}
//
//func add2Taken(course: Course, user: User) -> Bool {
//
//}
//
//func followProf(prof:Professor, user:User) -> Bool {
//
//}
