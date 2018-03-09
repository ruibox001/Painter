//
//  ViewController.m
//  Painter
//
//  Created by wsy on 2018/3/8.
//  Copyright © 2018年 wangshengyuan. All rights reserved.
//

#import "ViewController.h"
#import "ColorPicker.h"
#import "TouchDrawView.h"

@interface ViewController ()<ColorPickerDelegate>

@property (strong, nonatomic) ColorPicker *selector1;
@property (strong, nonatomic) ColorPicker *selector2;
@property (strong, nonatomic) ColorPicker *selector3;

@property (strong, nonatomic) TouchDrawView *drewArea;

@property (strong, nonatomic) UIButton *undoButton;
@property (strong, nonatomic) UIButton *redoButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat margen = 10;
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat Vw = (w - margen * 6)/5;
    CGFloat Vh = 40;
    
    self.selector1 = [[ColorPicker alloc] initWithFrame:CGRectMake(margen, h - margen - Vh, Vw, Vh)];
    self.selector1.backgroundColor = [UIColor blackColor];
    self.selector1.delegate = self;
    [self.view addSubview:self.selector1];
    
    self.selector2 = [[ColorPicker alloc] initWithFrame:CGRectMake(margen+CGRectGetMaxX(self.selector1.frame), CGRectGetMinY(self.selector1.frame), Vw, Vh)];
    self.selector2.backgroundColor = [UIColor blueColor];
    self.selector2.delegate = self;
    [self.view addSubview:self.selector2];
    
    self.selector3 = [[ColorPicker alloc] initWithFrame:CGRectMake(margen+CGRectGetMaxX(self.selector2.frame), CGRectGetMinY(self.selector1.frame), Vw, Vh)];
    self.selector3.backgroundColor = [UIColor redColor];
    self.selector3.delegate = self;
    [self.view addSubview:self.selector3];
    
    self.undoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.undoButton.frame = CGRectMake(margen+CGRectGetMaxX(self.selector3.frame), CGRectGetMinY(self.selector1.frame), Vw, Vh);
    [self.view addSubview:self.undoButton];
    [self.undoButton setTitle:@"后退" forState:UIControlStateNormal];
    [self.undoButton addTarget:self action:@selector(undo:) forControlEvents:UIControlEventTouchUpInside];
    [self.undoButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.undoButton.layer setMasksToBounds:YES];
    [self.undoButton.layer setCornerRadius:6];
    [self.undoButton.layer setBorderWidth:1];
    [self.undoButton.layer setBorderColor:[UIColor orangeColor].CGColor];
    
    self.redoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.redoButton.frame = CGRectMake(margen+CGRectGetMaxX(self.undoButton.frame), CGRectGetMinY(self.selector1.frame), Vw, Vh);
    [self.view addSubview:self.redoButton];
    [self.redoButton setTitle:@"前进" forState:UIControlStateNormal];
    [self.redoButton addTarget:self action:@selector(redo:) forControlEvents:UIControlEventTouchUpInside];
    [self.redoButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.redoButton.layer setMasksToBounds:YES];
    [self.redoButton.layer setCornerRadius:6];
    [self.redoButton.layer setBorderWidth:1];
    [self.redoButton.layer setBorderColor:[UIColor orangeColor].CGColor];
    
    self.drewArea = [[TouchDrawView alloc] initWithFrame:CGRectMake(0, 0, w, h-margen*2-Vh)];
    [self.view addSubview:self.drewArea];
    self.drewArea.backgroundColor = [UIColor grayColor];
}

- (void)aColorPickerIsSelected:(UIColor *)color
{
    [self.drewArea setDrawColor:color];
    self.selector1.layer.borderWidth = 0.0f;
    self.selector2.layer.borderWidth = 0.0f;
    self.selector3.layer.borderWidth = 0.0f;
}

- (void)undo:(id)sender
{
    [self.drewArea undo];
}

- (void)redo:(id)sender {
    [self.drewArea redo];
}

@end
