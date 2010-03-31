//
//  PhoneNumberCellController.m
//  PhoneNumbers
//
//  Created by Matt Gallagher on 27/12/08.
//  Copyright 2008 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "PhoneNumberCellController.h"


@implementation PhoneNumberCellController

//
// init
//
// Init method for the object.
//
- (id)initWithPhoneNumberData:(NSDictionary *)newData
{
	self = [super init];
	if (self != nil)
	{
		phoneNumberData = [newData retain];
	}
	return self;
}

//
// dealloc
//
// Releases instance memory.
//
- (void)dealloc
{
	[phoneNumberData release];
	[super dealloc];
}

//
// tableView:cellForRowAtIndexPath:
//
// Returns the cell for a given indexPath.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"PhoneNumberDataCell";
	const int FRONT_LABEL_TAG = 12001;
	const int VALUE_LABEL_TAG = 12002;
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UILabel *frontLabel = nil;
	UILabel *valueLabel = nil;
	if (cell == nil)
	{
		CGFloat fontSize = [UIFont labelFontSize] - 4;
		CGFloat topMargin = floor(0.5 * (tableView.rowHeight - fontSize)) - 2;
		
        cell =
			[[[UITableViewCell alloc]
				initWithFrame:CGRectMake(0, 0, 320, tableView.rowHeight)
				reuseIdentifier:cellIdentifier]
			autorelease];
		
		frontLabel = [[[UILabel alloc]initWithFrame:CGRectMake(10.0, topMargin, 180.0, fontSize + 4)] autorelease];
		frontLabel.tag = FRONT_LABEL_TAG;
		frontLabel.font = [UIFont boldSystemFontOfSize:fontSize];
		frontLabel.textAlignment = UITextAlignmentLeft;
		frontLabel.textColor = [UIColor blackColor];
		[cell.contentView addSubview:frontLabel];
		
		valueLabel = [[[UILabel alloc]initWithFrame:CGRectMake(200.0, topMargin, 100.0, fontSize + 4)] autorelease];
		valueLabel.tag = VALUE_LABEL_TAG;
		valueLabel.font = [UIFont boldSystemFontOfSize:fontSize];
		valueLabel.textAlignment = UITextAlignmentLeft;
		valueLabel.textColor = [UIColor grayColor];
		[cell.contentView addSubview:valueLabel];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
    }
	else
	{
		frontLabel = (UILabel *)[cell.contentView viewWithTag:FRONT_LABEL_TAG];
		valueLabel = (UILabel *)[cell.contentView viewWithTag:VALUE_LABEL_TAG];
	}
	
    // Configure the cell
	frontLabel.text = [phoneNumberData objectForKey:@"name"];
	valueLabel.text = [phoneNumberData objectForKey:@"number"];
	
    return cell;
}

@end
