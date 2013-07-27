//
//  ViewController.m
//  AppNET
//
//  Created by Umut Kanbak on 7/26/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *appNetArray;
    NSDictionary *appNetDictionary;
    __weak IBOutlet UITableView *tableViewOutlet;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    NSURL *url=[NSURL URLWithString:@"https://alpha-api.app.net/stream/0/posts/stream/global"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.navigationItem.title=@"App.Net Reader";
    [super viewDidLoad];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         appNetDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
         appNetArray=[appNetDictionary objectForKey:@"data"];
         [tableViewOutlet reloadData];
         
     }];
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [appNetArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *appNetDictionary2 = (NSDictionary *)[appNetArray objectAtIndex:indexPath.row];
    NSDictionary *appNetDictionary3 = [appNetDictionary2 objectForKey:@"user"];
    NSString *post=[appNetDictionary2 objectForKey:@"text"];
    NSString *userName=[appNetDictionary3 objectForKey:@"username"];
    NSDictionary *appNetDictionary4=[appNetDictionary3 objectForKey:@"avatar_image"];
    UIImage *image;
    NSURL *url =[NSURL URLWithString:[appNetDictionary4 objectForKey:@"url"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    image= [UIImage imageWithData:data];
    
    cell.textLabel.text=post;
    cell.detailTextLabel.text=userName;
    cell.imageView.image=image;
    if (cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];}
    
    NSLog(@"%@",appNetDictionary3);
    return cell;
}

@end
