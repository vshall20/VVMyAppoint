//
//  CustomMyAppointmentListCell.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 13/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomMyAppointmentListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_SrtipColor;
@property (weak, nonatomic) IBOutlet UILabel *lbl_AppointmentType;
@property (weak, nonatomic) IBOutlet UILabel *lbl_ClientName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_DateTime;

@end
