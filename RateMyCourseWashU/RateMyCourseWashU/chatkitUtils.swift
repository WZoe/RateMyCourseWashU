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

// avatar urls:
// 0: <img src="https://img.icons8.com/emoji/96/000000/man-student.png">
// 1:<img src="https://img.icons8.com/emoji/96/000000/man-facepalming.png">
// 2:<img src="https://img.icons8.com/emoji/96/000000/raccoon.png">
// 3:<img src="https://img.icons8.com/emoji/96/000000/tropical-fish.png">
// 4:<img src="https://img.icons8.com/emoji/96/000000/turtle-emoji.png">
// 5:<img src="https://img.icons8.com/emoji/48/000000/cherry-blossom.png">
// 6:<img src="https://img.icons8.com/emoji/96/000000/woman-student.png">
// 7:<img src="https://img.icons8.com/emoji/96/000000/woman-facepalming.png">
// 8:<img src="https://img.icons8.com/emoji/96/000000/sparkling-heart.png">

