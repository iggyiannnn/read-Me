//
//  TitlesViewController.swift
//  HiSilver
//
//  Created by jernkuan on 7/12/15.
//  Copyright © 2015 hisilver. All rights reserved.
//

import Foundation
import UIKit

extension String {
    /// Truncates the string to length number of characters and
    /// appends optional trailing string if longer
    func truncate(length: Int, trailing: String? = nil) -> String {
        if self.characters.count > length {
            return self.substringToIndex(advance(self.startIndex, length)) + (trailing ?? "")
        } else {
            return self
        }
    }
}

func lighterColorForColor(color: UIColor) -> UIColor {
    
    var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
    
    if color.getRed(&r, green: &g, blue: &b, alpha: &a){
        return UIColor(red: min(r + 0.2, 1.0), green: min(g + 0.2, 1.0), blue: min(b + 0.2, 1.0), alpha: a)
    }
    
    return UIColor()
}

class TitlesViewController : UITableViewController {

    var api = APIGoodRead()
    var category: String = ""
    var searchString: String = ""
    var booktitle=[String]()
    var ratings=[String]()
    var url=[String]()
    var targetUrl:String=""
    
    @IBOutlet var recordTitles: UITableView!
    @IBAction func back(sender: AnyObject){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            print("Segue fired")
        if segue.identifier == "selectedCategory"{
            print("Segue here")
            let view = segue.sourceViewController as! ViewController
            let category = view.category
            let searchString = view.searchString
            api.setUIViewController(self)
            api.searchDDC(searchString, ddcTerm: category)
            print("Segue worked")
        }
    }*/
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booktitle.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        if (ratings[row] == "" || ratings[row] == "0.0")
        {
            cell.textLabel?.text = booktitle[row]
        }
        else
        {
            cell.textLabel?.text = booktitle[row].truncate(60, trailing:"...") + " (rating: " + ratings[row] + ")"
        }
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
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        /*
        let cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath) as UITableViewCell
        //var article = articles.objectAtIndex(indexPath.row) as NewsArticle
        
        var attributes: NSDictionary = NSDictionary(objectsAndKeys: theme.newsHomeArticleTitleFont, NSFontAttributeName)
        
        var titleText = cell.textLabel as NSString
        
        var titleRect = titleText.boundingRectWithSize(CGSizeMake(self.view.frame.size.width - 64, 128), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return titleRect.height + 52.0

*/
        
        return 60;
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        //print(deweyCatID[row]+"!")
        targetUrl = url[row]
        print("category " + targetUrl)
        print("category is " + self.targetUrl)
        self.performSegueWithIdentifier("selectedTitle", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segue fired")
        if segue.identifier == "selectedTitle"{
            print("Segue here")
            var dest = (segue.destinationViewController as! UINavigationController).topViewController as! WebBrowser
            dest.targetUrl = targetUrl
            
            print("Segue worked")
        }
    }
    
    override func viewWillAppear(animated: Bool){
        var api2 = API()
        print(searchString)
        //category = api2.ddcDict2[searchString]!
        print(category)
        navigationItem.title = "Titles"
        api.setUIViewController(self)
        api.searchDDC(searchString, ddcTerm: category)
    }
    
    
}
