//
//  AGViewController.h
//  AGSimpleImageEditorView Demo
//
//  Created by Artur Grigor on 28.02.2012.
//  Copyright (c) 2012 Artur Grigor. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AGSimpleImageEditorView.h"

@protocol AGViewControllerDelegate

- (void)saveImage:(UIImage *)clipImage;

@end

@interface AGViewController : UIViewController
{
    AGSimpleImageEditorView *simpleImageEditorView;
    UISegmentedControl *ratioSegmentedControl;
    UIButton *rotateLeftButton, *rotateRightButton;
    id<AGViewControllerDelegate> delegate;
}

@property(nonatomic, retain) UIImage *image;
@property(nonatomic, retain) id<AGViewControllerDelegate> delegate;
@end

