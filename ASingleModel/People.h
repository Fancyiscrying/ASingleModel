//
//  People.h
//  ASingleModel
//
//  Created by Fancy on 16/2/18.
//  Copyright © 2016年 Fancy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject
{
    NSString *_username;
    NSString *_pwd;
}

@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *pwd;


- (id)initWithName: (NSString *)username Pwd:(NSString *)pwd;

@end
