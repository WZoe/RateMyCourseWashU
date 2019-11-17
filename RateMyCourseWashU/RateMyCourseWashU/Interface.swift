//
//  Interface.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 11/9/19.
//  Copyright © 2019 438group. All rights reserved.
//

import Foundation

func login(userName: String!, password: String!) ->Bool{
    return true
}

func signup(userName: String!, password: String!)->String{
    
    //return "Sign up successfully" if given valid userName and password
    //return "Please try another userName" if the userName has been registered
    //return "Please enter a valid password" if the password is too simple (please set some rules for password)
    return "Sign up successfully"
}
//
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
//func submitRating2Course(user: User, rating: Double, comment:String, course: Course) -> bool{
//    
//}
//
//func submitRating2Prof(user: User, rating: Double, comment:String, professor: Professor) -> bool{
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
