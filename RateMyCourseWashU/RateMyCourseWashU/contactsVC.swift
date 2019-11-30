//
//  contactsVC.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/30/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import PusherChatkit

class contactsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var chatManager: ChatManager?
    private var currentUser: PCCurrentUser?
    var token = ""
    var contacts:[(Int, String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //tableview：
        tableView.delegate = self
        tableView.dataSource = self
        
        //gen token
        
        
        //init chatkit
        guard let chatkitInfo = getChatkit(bundle: Bundle.main) else { return }
//        token = generateToken()
        print("token:\(token)")
        
        self.chatManager = ChatManager(
            instanceLocator: chatkitInfo.instanceLocator,
            tokenProvider: PCTokenProvider(url: chatkitInfo.tokenProviderEndpoint),
            userID: chatkitInfo.userId
        )
        
        // get contacts
//        contacts = getUserRooms(token: token)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = contact.1
        // get avatar
//        if(sender.avatarURL != nil){
//            cell.setImageFromUrl(ImageURL: sender.avatarURL!, tableview: tableView)
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatDetail = self.storyboard?.instantiateViewController(withIdentifier: "chatDetail") as! chatDetailVC
       chatDetail.roomId = contacts[indexPath.row].0
        navigationController?.pushViewController(chatDetail, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
