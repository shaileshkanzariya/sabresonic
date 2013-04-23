//
//  CustomTableViewCell.h
//  sabresonic
//
//  Created by SabreSonic Web on 4/18/13.
//  Copyright (c) 2013 Ramon Resma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kal.h"

@interface CustomTableViewCell : UITableViewCell <UITableViewDelegate>
{
    KalViewController *kalVC;
}
@property(nonatomic, strong)KalViewController *kalVC;

@end
