//
//  PhoneNumbersViewController.m
//  PhoneNumbers
//
//  Created by Matt Gallagher on 27/12/08.
//  Copyright Matt Gallagher 2008. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "PhoneNumbersViewController.h"
#import "PhoneNumberCellController.h"
#import "AddressBookDataSource.h"
#import "PlainViewController.h"
#import "LinkRowCellController.h"

@implementation PhoneNumbersViewController

//
// constructTableGroups
//
// Creates cell data.
//
- (void)constructTableGroups
{
	NSMutableArray *linkRows = [NSMutableArray array];
	[linkRows addObject:
		[[[LinkRowCellController alloc]
			initWithLabel:@"Link to another page"
			controllerClass:[PlainViewController class]]
		autorelease]];

	NSMutableArray *phoneNumberRows = [NSMutableArray array];
	for (NSDictionary *entry in addressBookDataSource.phoneNumbers)
	{
		PhoneNumberCellController *row = [[[PhoneNumberCellController alloc]
				initWithPhoneNumberData:entry]
			autorelease];
		[phoneNumberRows addObject:
			row];
	}
	
	tableGroups = [[NSArray arrayWithObjects:linkRows, phoneNumberRows, nil] retain];
}

@end

