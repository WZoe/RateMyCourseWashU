import UIKit
import Alamofire
import Foundation

let parameters: [String: String] = [
    "username": "hello",
    "password": "cstrt"
]
struct Course :Decodable{
    let id:String
    let title: String
    let courseNumber: String
    let professor: String
    let department: String
    let rating: Double
    //let comments: [String]
}
AF.request("http://52.170.3.234:3456/searchCourse",
           method: .post,
           parameters: ["keyword":"artificial"],
           encoder: JSONParameterEncoder.default).responseJSON { response in
            // debugPrint(response)
            let json = JSON(response.data!)
            var courses: [Course] = []
            for (_, j):(String, JSON) in json{
                let course = Course(id: j["id"].stringValue,
                                    title: j["title"].stringValue,
                                    courseNumber: j["courseNumber"].stringValue,
                                    professor: j["professor"].stringValue,
                                    department: j["department"].stringValue,
                                    rating: j["rating"].doubleValue)
                courses.append(course)
            }
}
//AF.request("http://52.170.3.234:3456/courseList",
//           method: .post,
//           parameters: parameters,
//           encoder: JSONParameterEncoder.default).responseJSON { response in
//           // debugPrint(response)
//            let json = JSON(response.data!)
//            var courses: [Course] = []
//            for (_, j):(String, JSON) in json{
//                let course = Course(id: j["id"].stringValue,
//                                    title: j["title"].stringValue,
//                                    courseNumber: j["courseNumber"].stringValue,
//                                    professor: j["professor"].stringValue,
//                                    department: j["department"].stringValue,
//                                    rating: j["rating"].doubleValue)
//                courses.append(course)
//            }
//    }

