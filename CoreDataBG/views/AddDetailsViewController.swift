//
//  AddDetailsViewController.swift
//  CoreDataBG
//
//  Created by Ashutosh Kumar Jha on 5/18/16.
//  Copyright © 2016 Ashutosh Kumar Jha. All rights reserved.
//

import UIKit
import CoreData

class AddDetailsViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var picker:UIImagePickerController? = UIImagePickerController()
    
    @IBAction func saveButton(sender: AnyObject) {
        let managedContext = (UIApplication.sharedApplication().delegate as? AppDelegate)!.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        let addEntity = NSEntityDescription.entityForName("Address", inManagedObjectContext: managedContext)
        
        let person = Person(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        let address = Address(entity: addEntity!, insertIntoManagedObjectContext: managedContext)
        
        let ageAsInt = Int(age.text!)
        if name.text != "" && age.text != "" {
            person.name = name.text
            person.age = ageAsInt
            address.city = city.text
            address.country = country.text
            
            person.addresses = NSSet(object: address)
            
            do {
                try person.managedObjectContext?.save()
                //people.append(person)
            } catch let error as NSError {
                print("Could not save \(error)")
            }
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddDetailsViewController.tapGesture(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.userInteractionEnabled = true
        
        picker?.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapGesture(gesture: UIGestureRecognizer) {
        let alert:UIAlertController = UIAlertController(title: "Profile Picture Options", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let gallaryAction = UIAlertAction(title: "Open Gallary", style: UIAlertActionStyle.Default) {
            UIAlertAction in self.openGallary()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in self.cancel()
        }
        
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    func openGallary() {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(picker!, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cancel(){
        print("Cancel Clicked")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
