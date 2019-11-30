//
//  chatDetailVC.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/30/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import PusherChatkit

class chatDetailVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textEntry: UITextField!
    
    
    private var chatManager: ChatManager?
    private var currentUser: PCCurrentUser?
    private var messages = [PCMultipartMessage]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //init chatkit
        guard let chatkitInfo = getChatkit(bundle: Bundle.main) else { return }
        self.chatManager = ChatManager(
            instanceLocator: chatkitInfo.instanceLocator,
            tokenProvider: PCTokenProvider(url: chatkitInfo.tokenProviderEndpoint),
            userID: chatkitInfo.userId
        )
        
        //connect to chatkit
        chatManager!.connect(delegate: MyChatManagerDelegate()) { (currentUser, error) in
            guard(error == nil) else {
                print("Error connecting: \(error!.localizedDescription)")
                return
            }
            self.currentUser = currentUser
            
            // TODO: set current chatroom：
            var currentChat = currentUser!.rooms.first!
            
            // subscribe to currentcChat
            currentUser!.subscribeToRoomMultipart(room: currentChat, roomDelegate: self, completionHandler: { (error) in
                guard error == nil else {
                    print("Error subscribing to room: \(error!.localizedDescription)")
                    return
                }
                print("Successfully subscribed to the room! 👋")
            })
        }
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func sendMessage(_ message: String) {
        self.currentUser!.sendSimpleMessage(
            roomID: self.currentUser!.rooms.first!.id,
            text: message,
            completionHandler: { (messageID, error) in
                guard error == nil else {
                    print("Error sending message: \(error!.localizedDescription)")
                    return
                }
                DispatchQueue.main.async {
                    self.textEntry.text = ""
                }
        }
        )
    }
    
    
    @IBAction func sendMsgButton(_ sender: UIButton) {
        if let msg = textEntry.text {
            sendMessage(msg)
        }
    }
}

// render msgs
extension chatDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        
        let message = messages[indexPath.row]
        let sender = message.sender
        var messageText = ""
        
        switch message.parts.first!.payload {
        case .inline(let payload):
            messageText = payload.content
        default:
            print("Message doesn't have the right payload!")
        }
        
        cell.textLabel?.text = sender.displayName
        cell.detailTextLabel?.text = messageText
        if(sender.avatarURL != nil){
            cell.setImageFromUrl(ImageURL: sender.avatarURL!, tableview: tableView)
        }
        return cell
    }
}

// handle incoming msgs
extension chatDetailVC: PCRoomDelegate {
    func onMultipartMessage(_ message: PCMultipartMessage) {
        print("Message received!")
        DispatchQueue.main.async {
            self.messages.append(message)
            self.tableView.reloadData()
        }
    }
}


