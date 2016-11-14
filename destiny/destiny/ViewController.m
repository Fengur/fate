//
//  ViewController.m
//  destiny
//
//  Created by Fengur on 2016/11/4.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *ma1 = [[NSMutableArray alloc] init];
    [ma1 addObject:@"2"];
    [ma1 addObject:@"1"];
    [ma1 addObject:@"3"];
    
    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    NSArray *arr1 = [ma1 sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
    
    for (NSString *str in arr1) {
        NSLog(@"%@", str);
    }
    
    NSMutableArray *ma2 = [[NSMutableArray alloc] init];
    [ma2 addObject:@"b"];
    [ma2 addObject:@"c"];
    [ma2 addObject:@"a"];
    
    NSSortDescriptor *sd2 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    NSArray *arr2 = [ma2 sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd2, nil]];
    
    for (NSString *str in arr2) {
        NSLog(@"%@", str);
    }
    
    NSMutableArray *ma3 = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *md1 = [[NSMutableDictionary alloc] init];
    [md1 setObject:@"e" forKey:@"name"];
    
    NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
    [md2 setObject:@"d" forKey:@"name"];
    
    NSMutableDictionary *md3 = [[NSMutableDictionary alloc] init];
    [md3 setObject:@"f" forKey:@"name"];
    
    [ma3 addObject:md1];
    [ma3 addObject:md2];
    [ma3 addObject:md3];
    
    
    
    NSSortDescriptor *sd3 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *arr3 = [ma3 sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd3, nil]];
    
    for (NSMutableDictionary *md in arr3) {
        NSLog(@"%@", [md objectForKey:@"name"]);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
