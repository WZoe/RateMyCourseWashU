//
//  chatkitUtils.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/30/19.
//  Copyright © 2019 438group. All rights reserved.
//

import Foundation
import PusherChatkit

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
