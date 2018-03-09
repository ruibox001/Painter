
//
//  ColorPicker.m
//  CaplessCoderPaint
//
//  Created by crossmo/yangcun on 14/10/29.
//  Copyright (c) 2014年 yangcun. All rights reserved.
//

#import "ColorPicker.h"

@implementation ColorPicker

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(aColorPickerIsSelected:)]) {
        [self.delegate aColorPickerIsSelected:[self backgroundColor]];
    }
    self.layer.borderWidth = 1.5f;
    self.layer.borderColor = [[UIColor orangeColor] CGColor];
}

@end
