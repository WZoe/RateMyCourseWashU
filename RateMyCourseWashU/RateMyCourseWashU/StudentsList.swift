//
//  StudentsList.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/25/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import Alamofire
import PusherChatkit

class StudentsList: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var currentCourse: Course? = nil
    var studentList: [User] = []
    var recommendationList: [Course] = []
    
    private var chatManager: ChatManager?
    private var currentUser: PCCurrentUser?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTableView()
        initStudentList()
        setCollectionView()
        initRecommendation()
        
        //init chatkit
        guard let chatkitInfo = getChatkit(bundle: Bundle.main) else { return }
        self.chatManager = ChatManager(
            instanceLocator: chatkitInfo.instanceLocator,
            tokenProvider: PCTokenProvider(url: chatkitInfo.tokenProviderEndpoint),
            userID: chatkitInfo.userId
        )
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "student")
        
        cell.textLabel?.text = studentList[indexPath.row].username
        
        return cell
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "student")
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
    }
    
    // TODO: fetch random maximum 15(or any number) of students who have marked this course as taken
    func initStudentList() {
        AF.request("http://52.170.3.234:3456/getStudentsGivenCourseID",
                   method: .post,
                   //done by zoe: update courseID here
            parameters: ["courseID": currentCourse?.id],
            encoder: JSONParameterEncoder.default).responseJSON { response in
                debugPrint(response)
                let json = JSON(response.data!)
                for (_, j):(String, JSON) in json{
                    let stu = User(userID: j["userID"].stringValue, username: j["username"].stringValue, password: "don't need", userPic: j["userPic"].intValue)
                    self.studentList.append(stu)
                }
                self.tableView.reloadData()
                
        }
    }
    
    // TODO: when click on a student, start a conversation with him
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //connect to chatkit
        chatManager!.connect(delegate: MyChatManagerDelegate()) { (currentUser, error) in
            guard(error == nil) else {
                print("Error connecting: \(error!.localizedDescription)")
                return
            }
            self.currentUser = currentUser
            
            let userId = currentUser?.id
            let objId = self.studentList[indexPath.row].userID
            var roomName = ""
            
            if Int(userId!)! < Int(objId)! {
                roomName = "\(String(describing: userId))_\(objId)"
            }
            else {
                roomName = "\(objId)_\(userId!)"
            }
            
            // 是否存在？
            let rooms = currentUser?.rooms
            var objRoom:PCRoom?
            for room in rooms! {
                if room.name == roomName {
                    objRoom = room
//                    self.performSegue(withIdentifier: "messages", sender: self)
                }
            }
            if objRoom == nil {
                // create new one
                currentUser!.createRoom(name: roomName, addUserIDs: [objId]) { room, error in
                    guard error == nil else {
                        print("Failed.")
                        return
                    }
                    print("Created public room called \(room!.name)")
                    objRoom = room
                    
                    // 跳转
                    // TODO： 映射avatar_url和userPic数字的关系
//                    self.tabBarController?.performSegue(withIdentifier: "messages", sender: self)
                }
            }
        }
        
        
    }
    
    // CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true

        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: view.frame.width, height: 35)
//            flow.scrollDirection = .horizontal
        }
        collectionView.register(RecCell.self, forCellWithReuseIdentifier: "recCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hoc = CGFloat(35)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recCell", for: indexPath) as! RecCell
        
        cell.backgroundColor = #colorLiteral(red: 0, green: 0.4509990811, blue: 0.3774749637, alpha: 1)
        
        cell.title = UILabel(frame: CGRect(x: 10, y: 0, width: view.frame.width - 20, height: hoc))
        cell.title!.font = UIFont.systemFont(ofSize: 17)
        cell.title!.text = recommendationList[indexPath.row].title
        cell.title?.textColor = UIColor.white
        cell.title?.textAlignment = .center

        
        cell.addSubview(cell.title!)
        
        return cell as UICollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: "detailvc") as! CourseDetailVC
        detailvc.currentCourse = recommendationList[indexPath.row]
        navigationController?.pushViewController(detailvc, animated: true)
    }
    
    // TODO: fetch recommendations based on the students' course lists
    func initRecommendation() {
//        let p = Professor(id: "1", name: "Todd Sproull", rating: 7.7, department: "CSE")
//        let c1 = Course(id: "1", title: "mobile application development", courseNumber: "438S", professor: p, department: "CSE", overallRating: 9.5)
//        let c2 = Course(id: "1", title: "mobile application development", courseNumber: "438S", professor: p, department: "CSE", overallRating: 9.5)
//        let c3 = Course(id: "1", title: "mobile aplication development", courseNumber: "438S", professor: p, department: "CSE", overallRating: 9.5)
//        let c4 = Course(id: "1", title: "mobile application development", courseNumber: "438S", professor: p, department: "CSE", overallRating: 9.5)
//
//        recommendationList = [c1, c2, c3, c4]
        AF.request("http://52.170.3.234:3456/getRecommandation",
                   method: .post,
            parameters: ["":""],
            encoder: JSONParameterEncoder.default).responseJSON { response in
                debugPrint(response)
                let json = JSON(response.data!)
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
                    self.recommendationList.append(course)
                }
                self.collectionView.reloadData()
        }
    }
}
