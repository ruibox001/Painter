//
//  TouchDrawView.m
//  CaplessCoderPaint
//
//  Created by crossmo/yangcun on 14/10/29.
//  Copyright (c) 2014年 yangcun. All rights reserved.
//

#import "TouchDrawView.h"

@implementation TouchDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.linesCompleted = [[NSMutableArray alloc] init];
        self.drawColor = [UIColor blackColor];
        [self becomeFirstResponder];
        
        self.droneIcon=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [self.droneIcon setImage:[UIImage imageNamed:@"droneicon"]];
        [self addSubview:self.droneIcon];
        [self.droneIcon setHidden:YES];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    for (Line *line in self.linesCompleted) {
        [[line color] set];
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }
    [self moveDrone];
}

- (void)undo
{
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
    self.pointMoveCount = self.linesCompleted.count;
}

- (void)redo
{
    if ([self.undoManager canRedo]) {
        [self.undoManager redo];
    }
    self.pointMoveCount = self.linesCompleted.count;
}

- (void)addLine:(Line*)line
{
    [[self.undoManager prepareWithInvocationTarget:self] removeLine:line];
    [self.linesCompleted addObject:line];
    [self setNeedsDisplay];
}

- (void)removeLine:(Line*)line
{
    if ([self.linesCompleted containsObject:line]) {
        [[self.undoManager prepareWithInvocationTarget:self] addLine:line];
        [self.linesCompleted removeObject:line];
        [self setNeedsDisplay];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.undoManager beginUndoGrouping];
    for (UITouch *t in touches) {

        CGPoint loc = [t locationInView:self];
        Line *newLine = [[Line alloc] init];
        [newLine setBegin:loc];
        [newLine setEnd:loc];
        [newLine setColor:self.drawColor];
        self.currentLine = newLine;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        [self.currentLine setColor:self.drawColor];
        CGPoint loc = [t locationInView:self];
        [self.currentLine setEnd:loc];
        
        [self addLine:self.currentLine];
        
        Line *newLine = [[Line alloc] init];
        [newLine setBegin:loc];
        [newLine setEnd:loc];
        [newLine setColor:self.drawColor];
        self.currentLine = newLine;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
    [self.undoManager endUndoGrouping];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
}

-(void)moveDrone
{
    if (self.moving) {
        return;
    }
    self.moving = YES;
    [self droneMoving];
}

-(void)droneMoving
{
    
    if (self.linesCompleted.count == 0 || self.pointMoveCount >= (self.linesCompleted.count - 1))
    {
        [self clear];
        return;
    }
    
    Line *l = self.linesCompleted[self.pointMoveCount];
    [self.droneIcon setHidden:NO];
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        _droneIcon.center = l.end;
    }completion:^(BOOL finished)
     {
         if (finished) {
             self.pointMoveCount++;
             [self droneMoving];
         }
     }];
    
}

-(void)clear
{
    self.moving = NO;
    [self.droneIcon setHidden:YES];
    NSLog(@"clear: %ld -> %ld",self.pointMoveCount,self.linesCompleted.count);
}

@end
