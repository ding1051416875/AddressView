//
//  CityModel.m
//  DXLAddressView
//
//  Created by ding on 2017/12/29.
//  Copyright © 2017年 ding. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
+ (instancetype)showCityDataWith:(NSDictionary *)dict{
    CityModel *model = [[CityModel alloc] init];
    model.name = dict[@"name"];
    model.code = dict[@"code"];
    NSArray *arrayT = [dict objectForKey:@"areaList"];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    [arrayT enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AreaModel *teanModels = [AreaModel showAreaDataWith:obj];
        [data addObject:teanModels];
    }];
    model.area = data;
    return model;
}
@end
