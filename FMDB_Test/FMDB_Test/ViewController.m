//
//  ViewController.m
//  FMDB_Test
//
//  Created by 韩扬 on 2017/4/24.
//  Copyright © 2017年 HanYang. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()

@property (nonatomic, strong) FMDatabase * database;
@property (nonatomic, strong) NSMutableArray * dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString * filePath = [path stringByAppendingPathComponent:@"MYTEST.db"];
    _database= [FMDatabase databaseWithPath:filePath];
    [self createTable];
    _dataArr = [NSMutableArray array];
    
    
}



- (BOOL)createTable {
    [_database open];
    NSString *sqlStr = @"create table mytable(corp_id integer,name varchar(50),primary  key(corp_id));";
    BOOL res = [_database executeUpdate:sqlStr];
    if (!res) {
        NSLog(@"error when creating database table");
        [_database close];
    }
    return res;
}



- (IBAction)saveDataAction:(id)sender {
    [_database open];
    BOOL res = [_database executeUpdateWithFormat:@"insert into mytable(corp_id,name) values(%d,%@);",012312312312,@"天津"];
    if (!res) {
        NSLog(@"error when insert data");
        [_database close];
    }
}
- (IBAction)getDataAction:(UIButton *)sender {
    FMResultSet *result = [_database executeQuery:@"select * from mytable"];
    
    //获取查询结果的下一个记录
    while ([result next]) {
        //根据字段名，获取记录的值，存储到字典中
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        int corp_id  = [result intForColumn:@"corp_id"];
        NSString *name = [result stringForColumn:@"name"];
        dict[@"corp_id"] = @(corp_id);
        dict[@"name"] = name;
        //把字典添加进数组中
        [_dataArr addObject:dict];
    }

}



@end
