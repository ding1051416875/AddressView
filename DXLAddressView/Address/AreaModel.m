//
//  AreaModel.m
//  DXLAddressView
//
//  Created by ding on 2017/12/29.
//  Copyright © 2017年 ding. All rights reserved.
//

#import "AreaModel.h"

@implementation AreaModel
+ (instancetype)showAreaDataWith:(NSDictionary *)dict
{
    AreaModel *model = [[AreaModel alloc] init];
    model.name = dict[@"name"];
    model.code = dict[@"code"];
    model.postCode = dict[@"postCode"];
    
    return model;
}
@end
