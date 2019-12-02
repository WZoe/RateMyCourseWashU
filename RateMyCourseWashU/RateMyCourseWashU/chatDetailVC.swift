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
    
    var currentContact: Contact?
    var currentChat:PCRoom?
    private var chatManager: ChatManager?
    private var currentUser: PCCurrentUser?
    private var messages = [PCMultipartMessage]()
    
    override func viewDidAppear(_ animated: Bool) {
//        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "Chat with \(currentContact!.name)"
        
        //tableview：
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
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
            
            //  set current chatroom：
            let rooms = currentUser?.rooms
            for room in rooms!{
                if room.id == String(self.currentContact!.roomId) {
                    self.currentChat = room
                    print("this is conv in room \(room.id)")
                }
            }
            
            
            // subscribe to currentcChat
            currentUser!.subscribeToRoomMultipart(room: self.currentChat!, roomDelegate: self, completionHandler: { (error) in
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
            roomID: currentContact!.roomId,
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
    
    @IBAction func sendMsg(_ sender: UITextField) {
        if let msg = sender.text {
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
        
        if sender.id == currentUser!.id {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.5198733211, green: 0.6998378634, blue: 0.6403132677, alpha: 0.2985873288)
            cell.textLabel?.backgroundColor = .clear
            cell.detailTextLabel?.backgroundColor = .clear
        }
        else {
            cell.contentView.backgroundColor = .white
        }
        cell.textLabel?.text = sender.displayName
        cell.detailTextLabel?.text = messageText
        if(sender.avatarURL != nil){
            cell.setImageFromUrl(ImageURL: sender.avatarURL!, tableview: tableView)
        }
        cell.transform = CGAffineTransform(scaleX: 1, y: -1);

        return cell
    }

}

// handle incoming msgs
extension chatDetailVC: UITableViewDelegate {}
extension chatDetailVC: PCRoomDelegate {
    func onMultipartMessage(_ message: PCMultipartMessage) {
        print("Message received!")
        DispatchQueue.main.async {
            self.messages.reverse()
            self.messages.append(message)
            self.messages.reverse()
            self.tableView.reloadData()
        }
    }
//    func onUsersUpdated() {
//        chatManager!.connect(delegate: MyChatManagerDelegate()) { (currentUser, error) in
//            guard(error == nil) else {
//                print("Error connecting: \(error!.localizedDescription)")
//                return
//            }
//            self.currentUser = currentUser
//        }
//    }
}


