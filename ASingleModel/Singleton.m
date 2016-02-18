//
//  Singleton.m
//  ASingleModel
//
//  Created by Fancy on 16/2/17.
//  Copyright © 2016年 Fancy. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

+ (Singleton *)sharedManager
{
    
    static Singleton *_shareManager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager =[[ self alloc ]init];
    
        
    
    });
    return _shareManager;



}


- (NSDictionary *)userInfo:(NSString *)memberNo
                       pwd:   (NSString *)pwd
                    oldpwd:    (NSString *)oldpwd
{
    NSMutableDictionary *parameters = [ NSMutableDictionary dictionary];
    [parameters setValue:@"1" forKey:@"1"];
    [parameters setValue:@"2" forKey:@"2"];
    
    NSError *error;
 NSData *data  =   [NSJSONSerialization dataWithJSONObject:parameters options:kNilOptions error:&error];

    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonStr);
    
    NSDictionary *param = [NSDictionary dictionary];
    
    return param;


}

@end
