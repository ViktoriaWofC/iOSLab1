//
//  ViewController.h
//  Lab_1
//
//  Created by user on 18.03.17.
//  Copyright © 2017 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
- (IBAction)update:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (copy, nonatomic) NSString *testString;
@property (copy, nonatomic) NSMutableArray *testArray;
@end

