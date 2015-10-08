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
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UITableView *Table;
@property (nonatomic ,strong)UIView  *tableFooterView;
@property (strong, nonatomic) IBOutletCollection(UISearchBar) NSArray *Search;

@end

@implementation SufferViewController



- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.Table.delegate = self;
    self.Table.dataSource = self;
    
   
    
    [self.Table registerClass:[SufferTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.Table setScrollEnabled:NO];
    [self addFooterButton];
    [[SufferHelper sharedSuffer]requestAllSufferWithFinish:^{
        [self.Table reloadData];
    }];
    
//    self.Table.separatorColor = [UIColor blueColor];

    
}

- (void)Dispage
{

    
    
}




- (void)addFooterButton
{
    UILabel *label = [[UILabel alloc]init];
    
    label.frame = CGRectMake(5, 10, self.view.frame.size.width - 10, 30);
    label.text = @"用药经验";
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:20];
 
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
    return [SufferHelper sharedSuffer].Allarray.count-16;

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
    
        return self.Table.frame.size.height/4 - 10;
    
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
