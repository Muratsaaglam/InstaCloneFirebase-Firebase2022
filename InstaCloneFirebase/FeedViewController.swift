//
//  FeedViewController.swift
//  InstaCloneFirebase
//
//  Created by Murat Sağlam on 26.01.2022.
//

import UIKit
import Firebase
//İmage SD İmport
import SDWebImage

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var userlikeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        getDataFromFirestore()

    }
    
    
//   Data 
    
    func getDataFromFirestore()
    {
        let fireStoreDeatabase = Firestore.firestore()
        
        fireStoreDeatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil
            {
                
                
                
            }
            else
            {
                if snapshot?.isEmpty != true && snapshot != nil
                {
                    
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.userlikeArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents
                    {
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)
                        
                        if let postedBy = document.get("postedBy") as? String
                        {
                            self.userEmailArray.append(postedBy)

                        }
                        if let postComment = document.get("postComment") as? String
                        {
                            self.userCommentArray.append(postComment)
                            
                        }
                        
                        if let likes = document.get("likes") as? Int
                        {
                            self.userlikeArray.append(likes)
                            
                        }
                        
                        if let imageUrl = document.get("imageUrl") as? String
                        {
                            self.userImageArray.append(imageUrl)
                            
                        }
                        
                            
                            
                            
                        
                    }
                    
                    self.tableView.reloadData()

                }
                
                
            }
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FeedCell
        cell?.userEmailLabel.text = userEmailArray[indexPath.row]
        cell?.likeLabel.text = String(userlikeArray[indexPath.row])
        cell?.commentLabel.text = userCommentArray[indexPath.row]
        cell?.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell?.documentIdLabel.text = documentIdArray[indexPath.row]
        return cell!


    }

}
