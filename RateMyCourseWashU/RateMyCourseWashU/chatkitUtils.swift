//
//  chatkitUtils.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/30/19.
//  Copyright © 2019 438group. All rights reserved.
//

import Foundation
import PusherChatkit
import Alamofire

func getChatkit(bundle: Bundle) -> (
    instanceLocator: String,
    tokenProviderEndpoint: String,
    userId: String)? {
        guard
            let path = bundle.path(forResource: "Chatkit", ofType: "plist"),
            let values = NSDictionary(contentsOfFile: path) as? [String: Any]
            else {
                print("Missing Chatkit.plist file with 'ChatkitInstanceLocator', 'ChatkitTokenProviderEndpoint', 'ChatkitUserId', and 'ChatkitRoomId' entries in main bundle!")
                return nil
        }
        
        guard
            let instanceLocator = values["ChatkitInstanceLocator"] as? String,
            let tokenProviderEndpoint = values["ChatkitTokenProviderEndpoint"] as? String,
            let userId = cache.object(forKey: "userid") as? String
            else {
                print("Chatkit.plist file at \(path) is missing 'ChatkitInstanceLocator', 'ChatkitTokenProviderEndpoint', 'ChatkitUserId', and/or 'ChatkitRoomId' entries!")
                print("File currently has the following entries: \(values)")
                return nil
        }
        return (instanceLocator: instanceLocator, tokenProviderEndpoint: tokenProviderEndpoint, userId: userId)
}

class MyChatManagerDelegate: PCChatManagerDelegate {
    func onError(error: Error) {
        print("Error in Chat manager delegate! \(error.localizedDescription)")
    }
}

//Cited: Extension for loading an image into an UIImageView from a URL string
//Inspired by tutorialspoint https://www.tutorialspoint.com/lazy-loading-of-images-in-table-view-using-swift
extension UITableViewCell {
    func setImageFromUrl(ImageURL: String, tableview: UITableView) {
        self.forceSize()
        
        URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    self.imageView?.image = UIImage(data: data)
                }
            }
        }).resume()
    }
    
    private func forceSize(){
        let itemSize = CGSize.init(width: 50, height: 50)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale);
        let imageRect = CGRect.init(origin: CGPoint.zero, size: itemSize)
        self.imageView?.image!.draw(in: imageRect)
        self.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
    }
}


// APIs:
let chatkitInfo = getChatkit(bundle: Bundle.main)
let ep = "https://us1.pusherplatform.io/services/chatkit/v6/42106c7e-a9e7-4375-b4cc-77e586b4bd58"

func generateToken() -> String {
    var result = ""
    AF.request(chatkitInfo!.tokenProviderEndpoint,
                          method: .post,
                          parameters: ["grant_type":"client_credentials", "user_id":chatkitInfo!.userId],
               encoder: JSONParameterEncoder.default).responseJSON { response in
                            let json = JSON(response.data!)
                result = json["access_token"].stringValue
    }
    return result
}

//func getUserRooms(tableView: UITableView) -> [(Int, String)] {
//    let url = URL(string: "\(ep)/users/\(chatkitInfo!.userId)/rooms")
//    var results:[(Int, String)] = []
//    var token = ""
//
//    AF.request(chatkitInfo!.tokenProviderEndpoint,
//               method: .post,
//               parameters: ["grant_type":"client_credentials", "user_id":chatkitInfo!.userId],
//               encoder: JSONParameterEncoder.default).responseJSON { response in
//                let json = JSON(response.data!)
//                token = json["access_token"].stringValue
//
//                //fetch rooms
//                AF.request(url!, headers: ["authorization":"Bearer \(token)"]).responseJSON { response in
//                    debugPrint(response)
//                    let json = JSON(response.data!)
//                    for (_, j):(String, JSON) in json{
//
//                        let members = j["member_user_ids"]
//                        var friend = ""
//                        if members[0].stringValue == chatkitInfo?.userId {
//                            friend = members[1].stringValue
//                        }
//                        else {
//                            friend = members[0].stringValue
//                        }
//                        results.append((j["id"].intValue, friend))
//                    }
//                    print("result:\(results)")
//                    tableView.reloadData()
//                }
//    }
//    return results
//}
