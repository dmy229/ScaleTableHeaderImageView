//
//  ScaleTableHeaderViewController.swift
//  Neighbour
//
//  Created by 明悦 on 15/11/16.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

class ScaleTableHeaderViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var scrollImage: ScaleTableHeaderImageView!
    /**控件声明**/
    var tableView : UITableView!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        scrollImage.initWithTableView(tableView);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
