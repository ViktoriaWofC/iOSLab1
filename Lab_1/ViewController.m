//
//  ViewController.m
//  Lab_1
//
//  Created by user on 18.03.17.
//  Copyright © 2017 edu.self. All rights reserved.
//

#import "ViewController.h"
#import "Parser.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation ViewController
@synthesize testString = _testString;
@synthesize testArray = _testArray;
UIActivityIndicatorView *progress;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createProgress];
    // Do any additional setup after loading the view, typically from a nib.
    self.testArray = [[NSMutableArray alloc] init];
    //[self.testArray addObject:[NSString stringWithFormat:@"element #%d",80]];
    //[NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast",  nil];
    
    NSString *fname = [[NSBundle mainBundle] pathForResource:@"Strings" ofType:@"strings"];
    NSDictionary *d = [NSDictionary dictionaryWithContentsOfFile:fname];
    NSString *update = [d objectForKey:@"Update"];
    NSString *bus = [d objectForKey:@"Bus"];
    
    //self.testLabel.text = bus;
    [self.testLabel setText:bus];
    [self.buttonUpdate setTitle:update forState:UIControlStateNormal];
    //[self.buttonUpdate setTitle: strTabSearch];
    //[self.findButton setTitle: loc forState: UIControlStateNormal];
    
    
    //[self sendRequest];
    
}

- (IBAction)update:(id)sender {
    //self.testString = @"32raw4q 535q34";
    //self.testLabel.text = self.testString;
    
    //UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Simple" message:@"Simple alertView demo with Cancel and OK." preferredStyle:UIAlertControllerStyleAlert];
    //UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
     //   NSLog(@"Cancel");
    //}];
    //UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    //    NSLog(@"OK");
    //}];
    
    //[alertController addAction:cancelAction];
    //[alertController addAction:okAction];
    //[self presentViewController:alertController animated: YES completion: nil];

    //[self updateTable];
    
    //[progress startAnimating];
    [self sendRequest];
}

- (void) createProgress {
    progress = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    progress.frame = CGRectMake(0.0, 0.0, 60.0, 60.0);
    progress.center = self.view.center;
    [self.view addSubview:progress];
    [progress bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
}
//123
- (void) sendRequest{
    [progress startAnimating];
    
    
    //NSString *serverAddress = @"https://tosamara.ru/xml_bridge.php";
    //NSURL *url = [NSURL URLWithString:@"https://tosamfdghfdhara.ru/xml_bridge.php"];
    NSURL *url = [NSURL URLWithString:@"https://tosamara.ru/xml_bridge.php"];
    //@"http://kparser.pp.ua/json/search/"
    //https://tosamara.ru/spravka/ostanovki/9
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSString *postString = @"method=getFirstArrivalToStop&KS_ID=9&COUNT=1&version=main&eng=0";
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded " forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:conf delegate:self delegateQueue:nil];
    NSURLSessionDataTask *getJsonTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        NSString *jsonResp =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.json = jsonResp;
        NSLog(@"%@",jsonResp);
        //Parser *parser = [[Parser alloc] init];
        //tableData = [parser getMoviesArray:jsonCiril];
        //tableDataID = [parser getMoviesID:jsonCiril];
        //NSString *servetyutyus = @"https:/fghfgh vki/9";
        
        [self parse];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self updateTable];
            [progress stopAnimating];
            NSLog(@"2: %@", error);
            if(error!=nil){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Внимание" message:@"Ошибка подключения!" delegate:self cancelButtonTitle:@"Попробовать еще раз" otherButtonTitles:@"Отмена", nil];
                [alert show];            }
            else {
            [self updateTable];
            }
        });
        
    }];
    
   /* NSURLSessionDataTask *getJsonTask = [session dataTaskWithURL:[NSURL URLWithString:serverAddress] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        NSString *jsonResp =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.json = jsonResp;
        NSLog(@"%@",data);
        Parser *parser = [[Parser alloc] init];
        //tableData = [parser getMoviesArray:jsonCiril];
        //tableDataID = [parser getMoviesID:jsonCiril];
       NSString *servetyutyus = @"https:/fghfgh vki/9";
    }];*/
    

    [getJsonTask resume];
    
    //id item   =[NSString stringWithFormat:@"element #%d",9];
    //[self.testArray removeAllObjects];
    //[self.testArray addObject:item];
    
    //[self updateTable];

}

-(void) parse{
    
    NSString *pattern =@"\\b(trans-bus)|(trans-trol)\\b([a-z0-9<>])\\b(</td>)\\b";
    NSError *err = NULL;
    
    NSRegularExpressionOptions regularOptions = NSRegularExpressionCaseInsensitive;
    NSRegularExpression *regular  = [NSRegularExpression regularExpressionWithPattern:pattern options:regularOptions error:&err];
    
    if(err){
        NSLog(@"Err");
    }
    
    NSInteger count = [regular numberOfMatchesInString:self.json options:0 range:NSMakeRange(0,[self.json length])];
    NSRange range = [regular rangeOfFirstMatchInString:self.json options:0 range:NSMakeRange(0,[self.json length])];
    if(!NSEqualRanges(range, NSMakeRange(NSNotFound, 0))){
        NSString *str = [self.json substringWithRange:range];
        NSLog(@"%@",str);
    }
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
