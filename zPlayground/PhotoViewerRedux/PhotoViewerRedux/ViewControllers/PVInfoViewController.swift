//
//  PVInfoViewController.swift
//  PhotoViewerRedux
//
//  Created by Kevin Chan on 31/03/2015.
//  Copyright (c) 2015 Kevin Chan. All rights reserved.
//

import UIKit

class PVInfoViewController: UIViewController {
    
    var currentContent: ContentDetails?

    @IBOutlet weak var currentImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var thisImage = UIImage(named: currentContent!.itemFilename)
        currentImage.image = thisImage

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
