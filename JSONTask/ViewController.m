//
//  ViewController.m
//  JSONTask
//
//  Created by mac_admin on 09/10/18.
//  Copyright © 2018 mac_admin. All rights reserved.
//

#import "ViewController.h"
#import "MyCustomCell.h"


NSMutableArray *dataArr;
@interface ViewController ()

@end

UIRefreshControl *refreshControl;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor clearColor];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self
                       action:@selector(getLatestData)
             forControlEvents:UIControlEventValueChanged];
    
    [tableview addSubview:refreshControl];
    
    
    
    
    
    //json Data
    [self getJsonData];
    


}
-(void)getLatestData
{
    // here add your reload method
    
    //change the order of array contents
    NSUInteger count = [dataArr count];
    if (count <= 1) return;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [dataArr exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    NSLog(@"Shuffled Array : %@",dataArr);
    //[tableview reloadData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if(refreshControl.isRefreshing )
        [self refresh];
}


- (void)refresh
{
    [refreshControl endRefreshing];
    
    // TODO: Update here your items
    
    [tableview reloadData];
}



-(void)getJsonData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"File" ofType:@"json"];
    [self readJsonFile:path];
    
}
-(void)readJsonFile:(NSString *)filePath{
    NSLog(@"Parsing %@", filePath);
    
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    
    NSDictionary *dic = [myJSON JSONValue];
    NSMutableArray *people = [dic valueForKey:@"people"];
    NSLog(@"All Names : %@",people);
    dataArr = people;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat result;
    result = 110.0f;
    return result;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 10;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *v = [UIView new];
//    [v setBackgroundColor:[UIColor clearColor]];
//    return v;
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [dataArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"MyCustomCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    }
    
    NSMutableDictionary *dict = [dataArr objectAtIndex:indexPath.row];
    cell.middleLabel.text = [dict valueForKey:@"name"];
    cell.rightLabel.text = [dict valueForKey:@"designation"];
    NSString *img_name = [dict valueForKey:@"img"];
    [cell.img setImage:[UIImage imageNamed:img_name]];
    
    ///////////////////////////////Layout///////////////////////////
    UIView* shadowView = [[UIView alloc]init];
    [cell setBackgroundView:shadowView];
    // border radius
    [shadowView.layer setCornerRadius:5.0f];
    
    // border
    [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [shadowView.layer setBorderWidth:1.8f];
    
    // drop shadow
    [shadowView.layer setShadowColor:[UIColor blackColor].CGColor];
    [shadowView.layer setShadowOpacity:0.8];
    [shadowView.layer setShadowRadius:5.0];
    //[cell.layer setShadowOffset:CGSizeMake(5.0, 5.0)];
    [tableView setSeparatorInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    [cell setLayoutMargins:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    
    
    return cell;

    
}

@end
