//
//  SufferViewController.m
//  
//
//  Created by lanou3g on 15/10/8.
//
//

#import "SufferViewController.h"
#import "SufferTableViewCell.h"
#import "SufferModel.h"
#import "SufferHelper.h"
#import "SufferTableViewController.h"
#import "ViewController.h"

@interface SufferViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *Search;
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UITableView *Table;
@property (nonatomic ,strong)UIView  *tableFooterView;
@property (nonatomic ,strong)NSMutableArray  *dataArray;
@property (nonatomic ,strong)NSMutableArray  *Listdata;

@property (nonatomic ,assign)NSInteger  page;



@end

@implementation SufferViewController



- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.Table.delegate = self;
    self.Table.dataSource = self;
    
   
    
    [self.Table registerClass:[SufferTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.Table setScrollEnabled:NO];
    [self addFooterButton];
    [[SufferHelper sharedSuffer]requestAllSufferWith:1 Finish:^{
        [self.Table reloadData];
    }];
  
    self.Search.delegate = self;
    
    
    _Search.showsSearchResultsButton = YES;
 
    //键盘样式
   
    
      // search的样式风格
    _Search.barStyle = UIBarStyleBlackTranslucent;
    _Search.keyboardType = UIKeyboardTypeDefault;
    
    [self.view addSubview:_Search];
 
}

   //点击searchbar的时候键盘自动加载到界面
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    return YES;
    
}

  //编辑search的text时调用此函数
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}


- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
 
    return YES;
    
}


//编辑完成后调用的函数
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}


//当textView的文字改变或者清除的时候调用此方法,搜索栏目前正在编辑,在编辑文本字段的当前文本
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}


   //点击search的时候调用
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
  
    
}





- (void)addFooterButton
{
    UILabel *label = [[UILabel alloc]init];
    
    label.frame = CGRectMake(5, 10, self.view.frame.size.width - 10, 30);
    label.text = @"用药经验";
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:19];
    [self.BackView addSubview:label];
    
    
         //初始化button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //设置文字和文字颜色
    [button setTitle:@"<<了解更多" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    //设置圆角
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    
    [button addTarget:self action:@selector(JumpMore) forControlEvents:UIControlEventTouchUpInside];
    
    
    //设置大小
    button.frame = CGRectMake(0, self.view.frame.size.width/2.7,self.view.frame.size.width - 10, 30);

    self.Table.tableFooterView = button;
  
    
}


//tableFooterView的button事件
- (void)JumpMore
{
    SufferTableViewController *suff = [[SufferTableViewController alloc]init];
 
    [self.navigationController pushViewController:suff animated:YES];
  
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //返回四个cell
    return [SufferHelper sharedSuffer].Allarray.count-17;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SufferModel *model = [[SufferHelper sharedSuffer]itemWithIndex:indexPath.row];
    
    SufferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.data = model;
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return self.Table.frame.size.height/3 - 10;
    
}


//页面跳转

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController *suffer = [[ViewController alloc]init];
    
    //找到当前点击的这个row
    SufferModel *model = [[SufferHelper sharedSuffer]itemWithIndex:indexPath.row];
    suffer.str = model.url;
    
    [self.navigationController pushViewController:suffer animated:YES];
    
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_Search resignFirstResponder];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
