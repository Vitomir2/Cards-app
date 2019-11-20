//
//  LogItemTableViewCell.m
//  Exam2
//
//  Created by Vitomir on 2/18/17.
//  Copyright © 2017 Vitomir. All rights reserved.
//

#import "LogItemTableViewCell.h"

@implementation LogItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setupCellWithInfo: (NSString *) info {
    self.textLabel.text = info;
}

@end
