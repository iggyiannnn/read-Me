//
//  API.swift
//  HiSilver
//
//  Created by jernkuan on 7/12/15.
//  Copyright © 2015 hisilver. All rights reserved.
//

import Foundation

class APIGoodRead: NSObject, NSURLConnectionDataDelegate {
    
    
    override init()
    {
    }
    
    var data: NSMutableData = NSMutableData()
    var view: TitlesViewController?
    
    var ddcDict: Dictionary<String, String> = [:]
    
    func setUIViewController(inView: TitlesViewController){
            view = inView
    }
    
    func searchDDC(searchTerm: String, ddcTerm:String) {
            
            // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
            var itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
            
            // Now escape anything else that isn't URL-friendly
            var escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            var urlPath = "http://www.jernkuan.com/nlb/a.php?title=\(searchTerm)&ddc=\(ddcTerm)"
            var url: NSURL = NSURL(string: urlPath)!
            var request: NSURLRequest = NSURLRequest(URL: url)
            var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
            
            print("Search DDC API at URL \(url)")
            
            connection.start()
    }
    
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
            print("Connection failed.\(error.localizedDescription)")
    }
    
    func connection(connection: NSURLConnection, didRecieveResponse response: NSURLResponse)  {
            print("Recieved response")
    }
    
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
            // Recieved a new request, clear out the data object
            self.data = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
            // Append the recieved chunk of data to our data object
            self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        // Request complete, self.data should now hold the resulting info
        // Convert it to a string
        var dataAsString: NSString = NSString(data: self.data, encoding: NSUTF8StringEncoding)!
        
        // Convert the retrieved data in to an object through JSON deserialization
        let jsonData = dataAsString.dataUsingEncoding(NSUTF8StringEncoding)!
        do {
            
            let parsed = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments)
            //print(parsed)
            view!.booktitle.removeAll()
            view!.ratings.removeAll()
            view!.url.removeAll()
            if let statusesArray = parsed as? NSArray{
                for row in statusesArray {
                    if let aStatus = row as? NSDictionary{
                        if let title = aStatus["title"] as? String{
                            print(title)
                            view!.booktitle.append(title)
                         
                        }
                        print("isbn"+(aStatus["isbn"] as! String))
                        
                        if let ratings = aStatus["ratings"] as? String{
                            print("ratings "+ratings)
                            //view!.deweyCat.append(ddcDict[ddc]!)
                            view!.ratings.append(ratings)
                        }
                        if let image_url = aStatus["image_url"] as? String{
                            print("image_url "+image_url)
                            //view!.deweyCat.append(ddcDict[ddc]!)
                        }
                        
                        if let url = aStatus["url"] as? String{
                            print("url "+url)
                            view!.url.append(url)
                        }
                    }
                }
            }
            view!.recordTitles.reloadData()
        } catch _{
            
        }
        
    }
    
    
}
