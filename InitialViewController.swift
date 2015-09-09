//
//  InitialViewController.swift
//  HiSilver
//
//  Created by jernkuan on 7/12/15.
//  Copyright © 2015 hisilver. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet var imageView: UIImageView!
    var bgImage: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var image: UIImage = UIImage(named: "splash")!
        bgImage = UIImageView(image: image)
        bgImage!.frame = CGRectMake(0,0,320,1136/2)
        self.view.addSubview(bgImage!)
    }
    
  
}
