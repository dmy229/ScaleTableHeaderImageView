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
super.viewDidLoad();
scaleTableHeaderViewController = ScaleTableHeaderViewController(nibName:"ScaleTableHeaderViewController",bundle:nil);
scaleTableHeaderViewController.tableView = self.tableView;
self.tableView.tableHeaderView = scaleTableHeaderViewController.view;
}
}

```


