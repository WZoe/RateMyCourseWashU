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
struct User {
    let userID: String
    let username: String
    let password: String
    let userPic: Int
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

//AF.request("http://52.170.3.234:3456/searchProfessor",
//           method: .post,
//           parameters: ["keyword":"yeoh"],
//           encoder: JSONParameterEncoder.default).responseJSON { response in
//            debugPrint(response)
//}
AF.request("http://52.170.3.234:3456/getProfessorCommentList",
           method: .post,
           parameters: ["proID":"1"],
           encoder: JSONParameterEncoder.default).responseJSON { response in
            debugPrint(response)
            let json = JSON(response.data!)
            var ratings: [Rating] = []
            for (_, j):(String, JSON) in json{
                let rating = Rating(user: User(userID: j["userID"].stringValue, username: j["userName"].stringValue, password: "why we need this", userPic: j["userPic"].intValue),
                                    rating: j["rating"].doubleValue / 10,
                                    comment: j["comment"].stringValue)
                ratings.append(rating)
            }
}

