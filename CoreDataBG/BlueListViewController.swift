//
//  BlueListViewController.swift
//  CoreDataBG
//
//  Created by Ashutosh Kumar Jha on 5/10/16.
//  Copyright © 2016 Ashutosh Kumar Jha. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class BlueListViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addMember(sender: AnyObject) {
        
        var name: UITextField?
        var age: UITextField?
        var city: UITextField?
        
        let alert = UIAlertController(title: "Add Name", message: "Add a new member's Name", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (action:UIAlertAction) -> Void in
                                        
            name = alert.textFields![0] as UITextField
            age = alert.textFields![1] as UITextField
            city = alert.textFields![2] as UITextField
            
            self.saveName(name!.text!, age: age!.text!, city: city!.text!)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: { (action:UIAlertAction) -> Void in
        })
        
        alert.addTextFieldWithConfigurationHandler {(textField: UITextField) -> Void in
            name = textField
            name?.delegate = self
            name?.placeholder = "Enter name"
        }
        
        alert.addTextFieldWithConfigurationHandler {(textField: UITextField) -> Void in
            age = textField
            age?.delegate = self
            age?.placeholder = "Enter age"
            age?.keyboardType = UIKeyboardType.NumberPad
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            age = textField
            age?.delegate = self
            age?.placeholder = "Enter City"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    var people = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setup()
    }
    
    func setup() {
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        let managedContext = appDelegate?.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        do {
            let results = try managedContext?.executeFetchRequest(fetchRequest)
            people = results as! [NSManagedObject]
            
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("personCell", forIndexPath: indexPath) as! PersonCell
        
        let person = people[indexPath.row]
    
        let addressRln = person.valueForKey("addresses")
        let  address = addressRln?.allObjects.first as! Address

        cell.nameLabel.text = person.valueForKey("name") as? String
        cell.ageLabel.text = "\(person.valueForKey("age") as! Int)"
        cell.city.text = address.city!
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
       
        if editingStyle == .Delete {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let moc = appDelegate.managedObjectContext

            moc.deleteObject(people[indexPath.row])
            appDelegate.saveContext()

            people.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    func saveName(name: String, age: String, city: String) {
        let managedContext = (UIApplication.sharedApplication().delegate as? AppDelegate)!.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        let addEntity = NSEntityDescription.entityForName("Address", inManagedObjectContext: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        let address = NSManagedObject(entity: addEntity!, insertIntoManagedObjectContext: managedContext)
        
        let ageAsInt = Int(age)!
        
        person.setValue(name, forKey: "name")
        person.setValue(ageAsInt, forKey: "age")
        
        address.setValue(city, forKey: "city")
    
        person.setValue(NSSet(object: address), forKey: "addresses")
        
        do {
            try person.managedObjectContext?.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
}