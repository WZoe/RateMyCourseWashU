import UIKit
import Alamofire
import Foundation

let parameters: [String: String] = [
    "username": "hello",
    "password": "cstrt"
]
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
//AF.request("http://52.170.3.234:3456/professorList",
//           method: .post,
//           parameters: ["keyword":"yeoh"],
//           encoder: JSONParameterEncoder.default).responseJSON { response in
//            debugPrint(response)
//            //            let json = JSON(response.data!)
//            //            var courses: [Course] = []
//            //            for (_, j):(String, JSON) in json{
//            //                let course = Course(id: j["id"].stringValue,
//            //                                    title: j["title"].stringValue,
//            //                                    courseNumber: j["courseNumber"].stringValue,
//            //                                    professor: j["professor"].stringValue,
//            //                                    department: j["department"].stringValue,
//            //                                    rating: j["rating"].doubleValue)
//            //                courses.append(course)
//            //            }
//}
//
//AF.request("http://52.170.3.234:3456/submitProfessorComment",
//           method: .post,
//           parameters: ["userID":"1", "proID":"1", "comment":"great work", "rating":"10"],
//           encoder: JSONParameterEncoder.default).responseJSON { response in
//            debugPrint(response)
//            //            let json = JSON(response.data!)
//            //            var courses: [Course] = []
//            //            for (_, j):(String, JSON) in json{
//            //                let course = Course(id: j["id"].stringValue,
//            //                                    title: j["title"].stringValue,
//            //                                    courseNumber: j["courseNumber"].stringValue,
//            //                                    professor: j["professor"].stringValue,
//            //                                    department: j["department"].stringValue,
//            //                                    rating: j["rating"].doubleValue)
//            //                courses.append(course)
//            //            }
//}
//AF.request("http://52.170.3.234:3456/searchProfessor",
//           method: .post,
//           parameters: ["keyword":"yeoh"],
//           encoder: JSONParameterEncoder.default).responseJSON { response in
//            debugPrint(response)
//}
AF.request("http://52.170.3.234:3456/courseList",
           method: .post,
           parameters: parameters,
           encoder: JSONParameterEncoder.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.data!)
            var courses: [Course] = []
            for (_, j):(String, JSON) in json{
                let p = Professor(id: j["proID"].stringValue,
                                        name: j["proName"].stringValue,
                                        rating: j["rating"].doubleValue / 10,
                                        department:j["department"].stringValue)
                let course = Course(id: j["courseID"].stringValue,
                                    title: j["title"].stringValue,
                                    courseNumber: j["courseNumber"].stringValue,
                                    professor:p,
                                    department: j["department"].stringValue,
                                    overallRating: j["rating"].doubleValue / 10)
                courses.append(course)
            }
    }

