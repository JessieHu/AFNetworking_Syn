//
//  ViewController.m
//  AFNetworking_Syn
//
//  Created by Jessie on 2017/3/31.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import "ViewController.h"

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking_Synchronous/AFHTTPSessionManager+Synchronous.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 天气预报: http://www.sojson.com/open/api/weather/json.shtml?city=%E6%9D%AD%E5%B7%9E
    [self sendSynRequest];
//    [self sendAsynRequest];
}

- (void)sendSynRequest {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.sojson.com/open/api/weather/"]];
    manager.completionQueue = dispatch_queue_create("AFNetworking+Synchronous", NULL);
    
    NSError *error = nil;
    NSData *result = [manager syncGET:@"json.shtml?city=%E6%9D%AD%E5%B7%9E"
                           parameters:nil
                                 task:NULL
                                error:&error];
    NSLog(@"同步: %@", result);
}

- (void)sendAsynRequest {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.sojson.com/open/api/weather/"]];
    manager.completionQueue = dispatch_queue_create("AFNetworking+Synchronous", NULL);
    
    [manager GET:@"json.shtml?city=%E6%9D%AD%E5%B7%9E"
      parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
          //
      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          NSLog(@"异步: %@", responseObject);
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          //
      }];
    
    NSLog(@"我先执行啦~~~~");
}

@end
