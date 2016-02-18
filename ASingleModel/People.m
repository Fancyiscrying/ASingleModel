//
//  People.m
//  ASingleModel
//
//  Created by Fancy on 16/2/18.
//  Copyright © 2016年 Fancy. All rights reserved.
//

#import "People.h"

@implementation People


@synthesize username = _username;
@synthesize pwd = _pwd;

- (id)initWithName:(NSString *)username Pwd:(NSString *)pwd
{
    self =[super init];
    
    if (self) {
        self.username = username;
        self.pwd = pwd;
        
    }

    return self;

}
@end
