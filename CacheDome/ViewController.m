//
//  ViewController.m
//  CacheDome
//
//  Created by shenzhenshihua on 2017/5/8.
//  Copyright © 2017年 shenzhenshihua. All rights reserved.
//

#import "ViewController.h"
#import "HttpRequest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HttpRequest * request = [HttpRequest shareHttpResquest];
//    http://jumpapi.mingpao.com/asp/WS2/Service.svc/rest/Search_CourseDetail_ByJson?CaseVal=0&Uid=1846
    
    NSDictionary * dcit = @{@"Uid":@"1846"};
    
    [request GET:@"http://jumpapi.mingpao.com/asp/WS2/Service.svc/rest/Search_CourseDetail_ByJson?CaseVal=0" parameters:dcit cache:YES success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    NSLog(@"%@", request);
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
