//
// Created by Igor Vasilenko on 02/07/16.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@protocol FeedService <NSObject>

- (RACSignal *)rac_requestRssFeed;

@end
