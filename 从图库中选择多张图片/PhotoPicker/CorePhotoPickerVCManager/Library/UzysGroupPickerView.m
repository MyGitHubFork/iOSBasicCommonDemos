//
//  UzysGroupPickerView.m
//  UzysAssetsPickerController
//
//  Created by Uzysjung on 2014. 2. 13..
//  Copyright (c) 2014년 Uzys. All rights reserved.
//

#import "UzysGroupPickerView.h"
#import "UzysGroupViewCell.h"
#import "UzysAssetsPickerController_Configuration.h"

#define BounceAnimationPixel 5
#define NavigationHeight 64

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]



@interface UzysGroupPickerView ()



@property (nonatomic,assign) CGFloat height;


@end


@implementation UzysGroupPickerView

- (id)initWithGroups:(NSMutableArray *)groups
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        self.groups = groups;
        [self setupLayout];
        [self setupTableView];
        self.isOpen=YES;
        self.hidden=NO;
        [self addObserver:self forKeyPath:@"groups" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}
- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"groups"];
}

- (void)setupLayout
{
    //anchorPoint 를 잡는데 화살표 지점으로 잡아야함
    self.frame = CGRectMake(0, - [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.layer.cornerRadius = 4;
    self.clipsToBounds = YES;
    self.backgroundColor=rgba(250, 250, 250,.99f);
    
}
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(1, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    
    self.tableView.rowHeight = kGroupPickerViewCellLength;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.tableView];
    UITableView *tableView=self.tableView;

    tableView.translatesAutoresizingMaskIntoConstraints=NO;

    NSDictionary *views=NSDictionaryOfVariableBindings(tableView);

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-72-[tableView]-0-|" options:0 metrics:nil views:views]];
    
}
- (void)reloadData
{
    [self.tableView reloadData];
}
- (void)show
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hidden=NO;
        self.isOpen = NO;
        CGRect frame=self.frame;
        frame.origin.y=-self.height;
        self.frame=frame;
        frame.origin.y=0;
        [UIView animateWithDuration:.5f animations:^{
            self.frame=frame;
        } completion:^(BOOL finished) {
            self.isOpen = YES;
        }];
    });
}

- (void)dismiss:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hidden=NO;
        self.isOpen = YES;
        CGRect frame=self.frame;
        frame.origin.y=0;
        self.frame=frame;
        frame.origin.y=-self.height;
        [UIView animateWithDuration:.5f animations:^{
            self.frame=frame;
        } completion:^(BOOL finished) {
            self.isOpen = NO;
            self.hidden=YES;
        }];
    });
}

-(void)didMoveToSuperview{
    
    [super didMoveToSuperview];
    
    UIView *superView=self.superview;
    
    if(superView==nil) return;
    
    UzysGroupPickerView *groupView=self;
    
    groupView.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSDictionary *views=NSDictionaryOfVariableBindings(groupView);
    
    NSDictionary *metrics=@{@"height":@(self.height)};
    
    NSArray *constraintsH=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[groupView]-0-|" options:0 metrics:nil views:views];
    NSArray *constraintsV=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[groupView]-0-|" options:0 metrics:metrics views:views];
    
    [superView addConstraints:constraintsH];
    [superView addConstraints:constraintsV];
}






- (void)toggle
{
    if(!self.isOpen)
    {
        [self show];
    }
    else
    {
        [self dismiss:YES];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"kGroupViewCellIdentifier";
    
    UzysGroupViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UzysGroupViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (self.groups.count > 0) {
        [cell applyData:[self.groups objectAtIndex:indexPath.row]];
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kGroupPickerViewCellLength;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss:YES];
    });
    if(self.blockTouchCell)
        self.blockTouchCell(indexPath.row);
}


-(CGFloat)height{
    
    return [[UIApplication sharedApplication].windows.firstObject bounds].size.height;
}



@end
