//
//  ViewController.m
//  ASingleModel
//
//  Created by Fancy on 16/2/17.
//  Copyright © 2016年 Fancy. All rights reserved.
//
#import "Singleton.h"
#import "ViewController.h"
#define  DBNAME @"/note.sqlite3"
#import <sqlite3.h>
#import "People.h"
@interface ViewController ()


@property (weak, nonatomic) IBOutlet UILabel *PeopleLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextFiled;



@property NSMutableArray *arr;//可变数组，用来存储People对象；
@property NSMutableString *string;//可变字符串，用来存储对象中的信息；

@end

@implementation ViewController

{

    sqlite3 *sqlite;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arr = [[NSMutableArray alloc] init];//初始化可变数组
    _string = [[NSMutableString alloc] init];//初始化可变字符串
    NSLog(@"%@",[self dataFilePath]);
    int result = sqlite3_open([[self dataFilePath]UTF8String],&sqlite);
    if (result != SQLITE_OK) {
        sqlite3_close(sqlite);
        //[self alert:@"数据库打开失败"];
        
        NSLog(@"数据库打开失败");
        
    }
    
    //[self alert:@"数据库打开成功"];
    NSLog(@"数据库打开成功");
    NSString *createsql = @"CREATE TABLE IF NOT EXISTS 'Note'(id INTEGER PRIMARYKEY , content TEXT NOT NULL)";
    char *error;
    if (sqlite3_exec(sqlite, [createsql UTF8String], NULL, NULL, &error) != SQLITE_OK) {
        
        NSLog(@"Note表失败");
        
    }
    
    
    NSLog(@"Note表成功");

    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS PEOPLE (ID INTEGER PRIMARYKEY , NAME TEXT NOT NULL)";
    

    
    if (sqlite3_exec(sqlite, [sql UTF8String], NULL, NULL, &error) != SQLITE_OK) {
        
    
        NSLog(@"PEOPLE表失败");
        
    
    
    
    }
    NSLog(@"PEOPLE表成功");
    
    
    NSString *UserSql = @"CREATE TABLE IF NOT EXISTS User(username TEXT NOT NULL , pwd TEXT NOT NULL)";
    
    
    
    if (sqlite3_exec(sqlite, [UserSql UTF8String], NULL, NULL, &error)) {
        NSLog(@"User表失败");
    }
    NSLog(@"User表成功");

    
   
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)register:(id)sender {
    
    
    
    
    if([_nameTextFiled.text isEqualToString:@""] == YES)
    {
    
    
    
        UIAlertView *view=[[UIAlertView alloc] initWithTitle:@"警告" message:@"姓名不能为空" delegate:self cancelButtonTitle:@" 确定" otherButtonTitles:nil, nil];
        
        [view show];
        
        
    
    }
    else{
    
    int result = sqlite3_open([[self dataFilePath]UTF8String],&sqlite);
    if (result != SQLITE_OK) {
        sqlite3_close(sqlite);
        
        NSLog(@"数据库打开失败");
        
    }
    else
    {
    
        NSLog(@"数据库打开成功");
    
    }
    NSString *insertSql=@"INSERT OR REPLACE INTO User(username,pwd)VALUES(?,?)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sqlite, [insertSql UTF8String], -1, &statement,NULL) == SQLITE_OK) {
        
        sqlite3_bind_text(statement, 1, [_nameTextFiled.text UTF8String ], -1, NULL);
        sqlite3_bind_text(statement, 2, [_pwdTextFiled.text  UTF8String ], -1, NULL);
        
        if (sqlite3_step(statement) !=SQLITE_DONE) {
            
            
            NSLog(@"插入数据失败");
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"警告" message:@"插入数据失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [view show];
        }
        
        else{
            
            NSLog(@"插入数据成功");
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"插入数据成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [view show];
        
        }
        sqlite3_finalize(statement);
        sqlite3_close(sqlite);
        
        
    }
    
    
    }
    
    _nameTextFiled.text = nil;
    _pwdTextFiled.text =  nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSString *)dataFilePath
{

    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath = [arr objectAtIndex:0];
    
    
    return [filepath stringByAppendingString:DBNAME];
    



}


- (void)alert:(NSString *)msg
{


    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *defaul = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancel];
    [alert addAction:defaul];
    [self presentViewController:alert animated:YES completion:nil];
    


}
- (IBAction)deleteUserData:(id)sender {
    
    
    
    if ([_nameTextFiled.text isEqualToString:@""] == YES) {
        UIAlertView *view =  [[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入要删除的用户名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
        
        
    }
    else
    {
    if (sqlite3_open([[self dataFilePath] UTF8String], &sqlite) !=SQLITE_OK) {
        
        NSLog(@"打开数据库失败");
        
        sqlite3_close(sqlite);
        
        
    }
    
    else
    {
        NSLog(@"打开数据库成功");
        
        NSString *sql = @"DELETE FROM User WHERE username =?";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &statement, NULL) ==SQLITE_OK) {
            
          char *cname = (char *) [_nameTextFiled.text UTF8String];
            sqlite3_bind_text(statement, 1, cname, -1, NULL);
            
            
        }
    
        
        if (sqlite3_step(statement) ==SQLITE_DONE) {
            
            NSLog(@"删除数据成功");
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"删除数据成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [view show];
        }
        
        else{
        
            NSLog(@"删除数据失败");
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"警告" message:@"删除数据失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [view show];
        }
    
    }
    
    _nameTextFiled.text = nil;
    _pwdTextFiled.text =  nil;

    }
    
}

- (IBAction)viewUserData:(id)sender {
    
    
    People *people=nil;

    

    

    if (sqlite3_open([[self dataFilePath]UTF8String], &sqlite) !=SQLITE_OK) {
        
        NSLog(@"数据库打开失败");
        sqlite3_close(sqlite);
        
    }
    else
    {
    
        NSLog(@"数据库打开成功");
    }
    
    
    NSString *sql=@"SELECT * FROM User";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        
        
        while(sqlite3_step(statement) == SQLITE_ROW) {
        char *username =  (char *) sqlite3_column_text(statement, 0);
        NSString *strusername = [[NSString alloc]initWithUTF8String:username];
        
        char *pwd = (char *) sqlite3_column_text(statement, 1);
        NSString *strpwd = [[NSString alloc]initWithUTF8String:pwd];
        people = [[People alloc]initWithName:strusername Pwd:strpwd];
        
        [_arr addObject:people];
        
        NSLog(@"查询数据成功");
            
            
        
    }
        NSLog(@"%lui",(unsigned long)[_arr count]);
        
        
        for (People *people in _arr) {
        
            [_string appendString:@"username:"];
            [_string appendString:people.username];
            [_string appendString:@"  "];
            [_string appendString:@"pwd:"];
            [_string appendString:people.pwd];
            [_string appendString:@"  "];
        }
        _PeopleLabel.text = _string;
        

      
    }
    else
    {
        
        
        NSLog(@"查询数据失败");
    }
    sqlite3_finalize(statement);
    sqlite3_close(sqlite);
    
    
}




@end
