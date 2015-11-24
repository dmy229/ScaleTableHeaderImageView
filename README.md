# ScaleTableHeaderImageView
设置UITableView的HeaderView视图为固定样式，并实现下拉模糊图片效果

![image](https://github.com/dmy229/ScaleTableHeaderImageView/blob/master/jietu.gif)

在UIViewController设计tableHeaderView的布局
```swift
class ScaleTableHeaderViewController: UIViewController {

@IBOutlet weak var scrollImage: ScaleTableHeaderImageView!
/**控件声明**/
var tableView : UITableView!;

override func viewDidLoad() {
super.viewDidLoad();
scrollImage.initWithTableView(tableView);
}
}

```
给UITableView设置tableHeaderView视图
```swift
class MainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

/**控件声明**/
@IBOutlet weak var tableView: UITableView!
var scaleTableHeaderViewController:ScaleTableHeaderViewController!;

override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的"
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor();
        
        self.scaleTableHeaderView = ScaleTableHeaderViewController(nibName:"ScaleTableHeaderViewController", bundle: nil);
        self.scaleTableHeaderView.tableView = tableView;
        
    }


func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        
        let nib:UINib = UINib(nibName: "MyTableViewCell", bundle: NSBundle.mainBundle());
        tableView.registerNib(nib, forCellReuseIdentifier: "MyTableViewCell");
        let cell = tableView.dequeueReusableCellWithIdentifier("MyTableViewCell", forIndexPath: indexPath) as! MyTableViewCell;
        var menuName = self.menuTable.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row).objectAtIndex(1) as! Data;
        cell.menuName.text = menuName.value;
        //print(cell.frame);
        return cell;
    }
    
func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 200;
        }
        return 1;
    }

```


