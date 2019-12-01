//
//  contactsVC.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/30/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import PusherChatkit
import Alamofire

class contactsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    

    var contacts:[Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //tableview：
        tableView.delegate = self
        tableView.dataSource = self
        // get contacts
        getUserRooms()
        
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getUserRooms(){
        let url = URL(string: "\(ep)/users/\(chatkitInfo!.userId)/rooms")
        var results:[(String, String)] = []
        var token = ""
        
        AF.request(chatkitInfo!.tokenProviderEndpoint,
                   method: .post,
                   parameters: ["grant_type":"client_credentials", "user_id":chatkitInfo!.userId],
                   encoder: JSONParameterEncoder.default).responseJSON { response in
                    debugPrint(response)
                    let json = JSON(response.data!)
                    token = json["access_token"].stringValue
//                    print(token)
                    
                    //fetch rooms
                    AF.request(url!, headers: ["authorization":"Bearer \(token)"]).responseJSON { response in
                        let json = JSON(response.data!)
                        for (_, j):(String, JSON) in json{
                            
                            let members = j["member_user_ids"]
                            var friend = ""
                            if members[0].stringValue == chatkitInfo?.userId {
                                friend = members[1].stringValue
                            }
                            else {
                                friend = members[0].stringValue
                            }
                            results.append((j["id"].stringValue, friend))
                            
                        }
                        
                        print(results)
                        var flag = false
                        for item in results {
                            let userurl = URL(string: "\(ep)/users/\(item.1)")
                            AF.request(userurl!, headers: ["authorization":"Bearer \(token)"]).responseJSON { response in
//                                debugPrint(response)
                                let json = JSON(response.data!)
                                
                                let user = Contact(id: json["id"].stringValue, name: json["name"].stringValue, avatar_url: json["avatar_url"].stringValue, roomId: item.0)
                                for contact in self.contacts {
                                    if contact.id == user.id {
                                        flag = true
                                        break
                                    }
                                }
                                if flag == false {
                                    self.contacts.append(user)
                                    print("appending\(user.roomId)")
                                    self.tableView.reloadData()
                                }
                                
                            }
                        }
                    }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = contact.name
        // get avatar
        if(contact.avatar_url != ""){
            cell.setImageFromUrl(ImageURL: contact.avatar_url , tableview: tableView)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatDetail = self.storyboard?.instantiateViewController(withIdentifier: "chatDetail") as! chatDetailVC
        chatDetail.currentContact = contacts[indexPath.row]
        navigationController?.pushViewController(chatDetail, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getUserRooms()
    }
}
