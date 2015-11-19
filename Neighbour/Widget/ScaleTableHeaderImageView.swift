//
//  ScaleTableHeaderImageView.swift
//  Neighbour
//
//  Created by 明悦 on 15/11/16.
//  Copyright © 2015年 ray. All rights reserved.
//

import Foundation
import UIKit;

class ScaleTableHeaderImageView : UIImageView, UITableViewDelegate  {
    
    /**变量声明**/
    /**tableHeaderImageView相关**/
    var tableViewHeaderHeight : CGFloat!;
    var tableViewFastHeaderHeight : CGFloat! = 0;
    var tableViewLastHeaderHeight : CGFloat! = 0;
    var tableViewDiffHeaderHeight : CGFloat! = 0;
    var blurImageArray : NSMutableArray!;
    
    /**UIView声明**/
    var tableView : UITableView!;
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!;
        let bounds = UIScreen.mainScreen().bounds;
        self.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: self.frame.size.height);
        
        self.tableViewHeaderHeight = self.frame.size.height;
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);

    }

    
    func initWithTableView(tableView:UITableView){
        self.tableView = tableView;
        self.tableView.delegate = self;
        //添加监听器
        self.tableView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil);
        
        //新线程生成模糊图片
        NSThread.detachNewThreadSelector("prepareForBlurImages", toTarget: self, withObject: nil);
    }

    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if(self.tableView != nil){
            animationForTableView();
        }
    }
    
    func animationForTableView(){
        let offset = self.tableView.contentOffset.y;
        
        var index = 0;
        //高度差>0表示tableView正在回弹，否则表示正在下拉
        if(self.tableViewDiffHeaderHeight > 0){
            
            index =  NSInteger( (0 - (self.self.tableViewFastHeaderHeight - self.frame.size.height )) / 10);
                        print("回弹高度", (0 - (self.self.tableViewFastHeaderHeight - self.frame.size.height )), index);
            
        }
        else{
            index =  NSInteger((self.frame.size.height - self.tableViewFastHeaderHeight ) / 10);
                        print("下拉高度",(self.frame.size.height - self.tableViewFastHeaderHeight), index);
        }
        
        //index不能<0 或 >self.blurImageArray.count - 1
        if(index < 0){
            index = 0;
        }
        else if(index > self.blurImageArray.count - 1){
            index = 0;
        }
        
        //获取当前的模糊图片
        var image : UIImage!;
        if(self.blurImageArray != nil && self.blurImageArray.count > 0){
            image = self.blurImageArray.objectAtIndex(index) as? UIImage;
        }
        
        if(offset > 0){
            
            //TableView向上滑
            if(self.blurImageArray != nil && self.blurImageArray.count > 0){
                
                if(image != nil){
                    self.image = image;
                }
                
            }
            
            self.frame = CGRectMake(0,0, self.frame.size.width, self.tableViewHeaderHeight);
        }
        else{
            
            if(image != nil){
                self.image = image;
            }
            
            //设置当前UIView的Frame
            self.frame = CGRectMake(offset, offset - 0, UIScreen.mainScreen().bounds.size.width + (-offset * 2) , self.tableViewHeaderHeight + (-offset));

        }
    }
    
    /**获取开始拖动时tableHeaderHeight高度**/
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        self.tableViewFastHeaderHeight = self.frame.size.height;//self.tableView.tableHeaderView?.frame.size.height;
        
    }
    
    /**拖动结束时获取高度**/
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        self.tableViewLastHeaderHeight = self.frame.size.height;
        //获取最后下拉的高度和开始滑动时高度差
        self.tableViewDiffHeaderHeight = self.tableViewLastHeaderHeight - self.tableViewFastHeaderHeight;
        
    }
    
    func prepareForBlurImages(){
        
        var factor : CGFloat = 0.1;
        
        if(blurImageArray == nil){
            //动态模糊图片
            blurImageArray = NSMutableArray();
        }
        
        if(blurImageArray.count == 0){
            
            blurImageArray.addObject(self.image!);
            let size = NSInteger(self.tableViewHeaderHeight  / 10);
            
            for(var i = 0; i < size; i++){
                
                self.blurImageArray.addObject((self.image?.boxblurImageWithBlur(factor))!);
                factor += 0.04;
                
            }
        }
        
    }
    
}
