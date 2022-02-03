//
//  SettingsViewController.swift
//  InstaCloneFirebase
//
//  Created by Murat Sağlam on 26.01.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    @IBAction func logoutClicked(_ sender: Any)
//    {
//        performSegue(withIdentifier: "ToViewController", sender: nil)
//
//    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        
//       Removing the User from the Server
        do
        {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
            
        }
        catch
        {
            print("error")
            
        }
        
    }
    
  
   

}
