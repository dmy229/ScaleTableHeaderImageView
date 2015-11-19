//
//  MainViewController.swift
//  Neighbour
//  首页
//  Created by ray on 15/10/26.
//  Copyright © 2015年 ray. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    /** 标题栏左侧按钮 */
    var leftButton:UIButton!;
    /** 标题栏右侧按钮 */
    var rightButton:UIButton!;
    
    @IBOutlet weak var tableView: UITableView!
     /** 用来保存首页展示的产品数据集合 */
    var projuctArray:NSMutableArray = NSMutableArray();
    
    var scaleHeaderView:ScaleTableHeaderView!;
    var scaleTableHeaderViewController:ScaleTableHeaderViewController!;
    var navigationBarAnimat:NavigationBarAnimat!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.hidesBottomBarWhenPushed = true;
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 25 / 255, green: 175 / 255, blue: 255 / 255, alpha: 1);
        
        leftButton = UIButton(frame: CGRectMake(0, 0, 60, 40));
        leftButton.titleLabel?.font = UIFont(name: "Arial", size: 12.0);
        leftButton.setImage(UIImage(named: "top_selsect_normal"), forState: UIControlState.Normal);
        leftButton.titleLabel?.textAlignment = NSTextAlignment.Center;
        leftButton.addTarget(self, action: "show:", forControlEvents: UIControlEvents.TouchUpInside);
        setCityName("青岛");
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton);
        
        let searchWidth:CGFloat = self.view.frame.size.width - 60*3;
        let searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0,searchWidth, 30.0));
        self.navigationItem.titleView = searchBar;
        
        rightButton = UIButton(frame: CGRectMake(0, 0, 60, 40));
        rightButton.titleLabel?.font = UIFont(name: "Arial", size: 12.0);
        rightButton.titleLabel?.textAlignment = NSTextAlignment.Center;
        rightButton.setTitle("消息", forState: UIControlState.Normal);
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton);
        
//        navigationBarAnimat = NavigationBarAnimat();
//        navigationBarAnimat.viewController = self;
//        
//        navigationBarAnimat.setScrollView(self, scrollView: tableView);
        
//        scaleHeaderView = ScaleTableHeaderView();
//        scaleHeaderView.initWithTableViewWithHeaderImage(self.tableView, image: UIImage(named: "image.png")!, headerHeight: 200);
        
        scaleTableHeaderViewController = ScaleTableHeaderViewController(nibName:"ScaleTableHeaderViewController",bundle:nil);
        scaleTableHeaderViewController.tableView = self.tableView;
        self.tableView.tableHeaderView = scaleTableHeaderViewController.view;
        setData();
        
    }
    
    func show(button:UIButton){
          }
    
    /** 添加默认数据用于测试*/
    private func setData()
    {
        let product = Product(id: "1", name: "测试产品", date: NSDate(), price: "12.3", user: User());
        let product1 = Product(id: "1", name: "测试产品1", date: NSDate(), price: "12.3", user: User());
        let product2 = Product(id: "1", name: "测试产品", date: NSDate(), price: "12.3", user: User());
        let product3 = Product(id: "1", name: "测试产品1", date: NSDate(), price: "12.3", user: User());
        self.projuctArray.addObject(product)
        self.projuctArray.addObject(product1)
        self.projuctArray.addObject(product2)
        self.projuctArray.addObject(product3)
    }
    
    /** 设置城市名称*/
    private func setCityName(name:String)
    {
        leftButton.setTitle(name, forState: UIControlState.Normal);
        let width = leftButton.imageView!.image!.size.width;
        let titleWidth = leftButton.titleLabel!.bounds.width;
        leftButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -width, bottom: 0, right: width);
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleWidth, bottom: 0, right: -titleWidth);
    }
    
    /********   UITableViewDataSource   ******/
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return projuctArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell{
        let nib:UINib = UINib(nibName: "MainTableViewCell", bundle: NSBundle.mainBundle());
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell");
        let cell:MainTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MainTableViewCell;
        cell.bindData(projuctArray.objectAtIndex(indexPath.row) as! Product);
        return cell;
    }
   
    
}
