//
//  ViewController.swift
//  HiSilver
//
//  Created by jernkuan on 7/12/15.
//  Copyright © 2015 hisilver. All rights reserved.
//

import UIKit
import Parse



class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var searchFieldLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultCategoriesLabel: UILabel!
    @IBOutlet weak var resultCategories: UITableView!
    
    var category: String = ""
    var searchString: String = ""
    let api = API()
    var deweyCat = [String]()
    var deweyCatCount = [String]()
    var deweyCatID = [String]()
    
    override func viewDidLoad() {
        resultCategories.delegate = self
        resultCategories.dataSource = self
        self.searchTextField.delegate = self;
        searchFieldLabel.text = "Search for"
        resultCategoriesLabel.text = "Choose Category"
        api.setUIViewController(self)
        
        
        
        
        //let testObject = PFObject(className: "TestObject")
        //testObject["foo"] = "foo"
        //testObject.saveInBackground()
        //let object = PFObject(className: "TestObject")
        //object["foo"] = "bar"
        //object.saveInBackground()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        searchString = saveSearch()
        api.searchDDC(searchString)
        print(searchString)
        return false
    }
    
    func saveSearch() -> String{
        return searchTextField.text!
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deweyCat.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DeweyCategoryCell", forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = deweyCat[row] + " (" + deweyCatCount[row] + " results)"
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.textLabel?.numberOfLines = 0
        
        if ( indexPath.row % 2 == 0 )
        {
            cell.backgroundColor = lighterColorForColor(UIColor.lightGrayColor())
        }
        else
        {
            cell.backgroundColor = lighterColorForColor(UIColor.grayColor())
        }
        
        return cell
        
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        print(deweyCatID[row]+"!")
        category = deweyCatID[row]
        print("category " + category)
        print("category is " + self.category)
        self.performSegueWithIdentifier("selectedCategory", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segue fired")
        if segue.identifier == "selectedCategory"{
            print("Segue here")
            var dest = (segue.destinationViewController as! UINavigationController).topViewController as! TitlesViewController
            print(category)
            dest.category = category
            dest.searchString = searchString
            print("Segue worked")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

