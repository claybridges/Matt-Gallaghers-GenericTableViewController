//
//  AddressBookDataSource.m
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

#import "AddressBookDataSource.h"
#import <AddressBook/AddressBook.h>

@implementation AddressBookDataSource

@dynamic phoneNumbers;

- (NSArray *)phoneNumbers
{
	if (!phoneNumbers)
	{
		NSMutableArray *addressBookNumbers = [NSMutableArray array];
		
		ABAddressBookRef addressBook = ABAddressBookCreate();
		NSArray *people = (NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
		for (id peopleRecord in people)
		{
			ABRecordRef aRecord = (ABRecordRef)peopleRecord;
			ABMutableMultiValueRef multi = ABRecordCopyValue(aRecord, kABPersonPhoneProperty);
			
			CFStringRef firstName = ABRecordCopyValue(aRecord, kABPersonFirstNameProperty);
			CFStringRef lastName  = ABRecordCopyValue(aRecord, kABPersonLastNameProperty);
			
			if (!firstName && !lastName)
			{
				firstName = ABRecordCopyValue(aRecord, kABPersonOrganizationProperty);
				lastName = CFSTR("");
			}
			else if (!firstName)
			{
				firstName = CFSTR("");
			}
			else if (!lastName)
			{
				lastName = CFSTR("");
			}
			
			for (CFIndex i = 0; i < ABMultiValueGetCount(multi); i++)
			{
				CFStringRef phoneNumberLabel = ABMultiValueCopyLabelAtIndex(multi, i);
				CFStringRef phoneNumber = ABMultiValueCopyValueAtIndex(multi, i);
				
				NSMutableString *label = [(NSString *)phoneNumberLabel mutableCopy];
				[label replaceOccurrencesOfString:@"_$!<" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [label length])];
				[label replaceOccurrencesOfString:@">!$_" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [label length])];

				[addressBookNumbers addObject:
					[NSDictionary dictionaryWithObjectsAndKeys:
						[NSString stringWithFormat:@"%@ %@ (%@)", firstName, lastName, label], @"name",
						lastName, @"lastName",
						firstName, @"firstName",
						label, @"kind",
						phoneNumber, @"number",
					nil]];

				CFRelease(phoneNumberLabel);
				CFRelease(phoneNumber);
			}
		}
		[people release];
		CFRelease(addressBook);
		
		NSSortDescriptor *lastNameSortDescriptor =
			[[[NSSortDescriptor alloc]
				initWithKey:@"lastName"
				ascending:YES]
			autorelease];
		NSSortDescriptor *firstNameSortDescriptor =
			[[[NSSortDescriptor alloc]
				initWithKey:@"firstName"
				ascending:YES]
			autorelease];
		NSSortDescriptor *kindSortDescriptor =
			[[[NSSortDescriptor alloc]
				initWithKey:@"kind"
				ascending:YES]
			autorelease];
		NSArray *sortedArray =
			[addressBookNumbers
				sortedArrayUsingDescriptors:
					[NSArray arrayWithObjects:lastNameSortDescriptor, firstNameSortDescriptor, kindSortDescriptor, nil]];
		
		phoneNumbers = [sortedArray retain];
	}
	
	return phoneNumbers;
}

@end

