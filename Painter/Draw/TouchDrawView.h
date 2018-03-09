//
//  TouchDrawView.h
//  CaplessCoderPaint
//
//  Created by crossmo/yangcun on 14/10/29.
//  Copyright (c) 2014年 yangcun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"

@interface TouchDrawView : UIView

@property (nonatomic,strong) Line *currentLine;
@property (nonatomic,strong) NSMutableArray *linesCompleted;
@property (nonatomic,strong) UIColor *drawColor;

@property (nonatomic, strong) UIImageView *droneIcon;
@property (nonatomic, assign) NSInteger pointMoveCount;
@property (nonatomic, assign) BOOL moving;

- (void)undo;
- (void)redo;

@end
