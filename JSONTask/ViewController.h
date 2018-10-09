//
//  ViewController.h
//  JSONTask
//
//  Created by mac_admin on 09/10/18.
//  Copyright © 2018 mac_admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+SBJson.h"

@interface ViewController : UIViewController<UITabBarDelegate,UITableViewDataSource>
{
    __weak IBOutlet UITableView *tableview;
    
}

@end

