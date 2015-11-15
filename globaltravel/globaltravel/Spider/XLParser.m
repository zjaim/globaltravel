//
//  XLParser.m
//  globaltravel
//
//  Created by xinglei on 11/15/15.
//  Copyright © 2015 xinglei. All rights reserved.
//

#import "XLParser.h"

@implementation XLParser

DEFINE_SINGLETON_FOR_CLASS(XLParser)

- (void)parseNewsData:(NSData *)data success:(void (^)(NSArray *netNewses))success failed:(void (^)(void))failed {
    
}

- (void)parseHomeData:(NSData *)data success:(void (^)(NSArray *netActivities, NSArray *netMarkets))success failed:(void (^)(void))failed {
    
}

- (void)parseTravelData:(NSData *)data success:(void (^)(NSArray *netTravels))success failed:(void (^)(void))failed {
    
}

@end
