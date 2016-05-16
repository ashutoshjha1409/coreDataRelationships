//
//  ProfileViewController.swift
//  CoreDataBG
//
//  Created by Ashutosh Kumar Jha on 5/13/16.
//  Copyright © 2016 Ashutosh Kumar Jha. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var profile: Person?

    override func viewDidLoad(){
        super.viewDidLoad()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        print("Comes to this view controller")
        //print("\(profile?.valueForKey("name") as? String)")
        
        let addressRln = profile!.addresses
        let address = addressRln?.allObjects.first as! Address
        
        nameLabel?.text = profile?.name!
        ageLabel?.text = "\(profile!.age!)"
        
        cityLabel.text = "\(address.city!)"
    }
}
