//
//  IIModuleInvocation.h
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/8.
//  Copyright © 2018年 Inspur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IIModuleInvocation : NSObject


/// invoke more than one param & non-nsobject method
- (id)invokingMethod:(NSObject *)mateClass selector: (SEL)realSelector params:(NSMutableDictionary *)paramsDic;


@end
