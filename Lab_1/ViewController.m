//
//  ViewController.m
//  Lab_1
//
//  Created by user on 18.03.17.
//  Copyright © 2017 edu.self. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation ViewController
@synthesize testString = _testString;
@synthesize testArray = _testArray;
UIActivityIndicatorView *indicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.testArray = [[NSMutableArray alloc] init];
    //[self.testArray addObject:[NSString stringWithFormat:@"element #%d",80]];
    //[NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast",  nil];
}

- (IBAction)update:(id)sender {
    self.testString = @"32raw4q 535q34";
    self.testLabel.text = self.testString;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Simple" message:@"Simple alertView demo with Cancel and OK." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        NSLog(@"Cancel");
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"OK");
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated: YES completion: nil];

    //[self updateTable];
    [self sendRequest];
}

- (void) sendRequest{
    //[indicator startAnimating];
    
    NSString *serverAddress = @"http://kparser.pp.ua/json/search/";
    //serverAddress = [NSString stringWithFormat:@"http://kparser.pp.ua/json/search/%@", parametr];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *getJsonTask = [session dataTaskWithURL:[NSURL URLWithString:serverAddress] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        NSString *jsonCiril =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.json = jsonCiril;
        
        //MyJsonParser *parser = [[MyJsonParser alloc] init];
        //tableData = [parser getMoviesArray:jsonCiril];
        //tableDataID = [parser getMoviesID:jsonCiril];
        
        //dispatch_async(dispatch_get_main_queue(), ^{
        //    [self.tableView reloadData];
        //    [indicator stopAnimating];
        //});
        
    }];
    
    id item   =[NSString stringWithFormat:@"element #%d",9];
    [self.testArray removeAllObjects];
    [self.testArray addObject:item];
    
    [self updateTable];
    //if ([Reachability connected]) {
    //    [getJsonTask resume];
    //}
}

- (void) updateTable{
    //[self.testArray removeAllObjects];
    id item;
    
    //NSString *str = @"!!!";
    //self.testArray = [NSMutableArray arrayWithObjects:str, @"1", @"2",  nil];
    for (int i = 0 ; i < 5; i++)
    {
        item =[NSString stringWithFormat:@"element #%d",i];
        [self.testArray addObject:item];
    }
    [self.table reloadData];}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.testArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier =
    @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [self.testArray objectAtIndex:indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
