//
//  FeelsWhy.swift
//  FeelsWhy
//
//  Created by Yisak on 2023/08/23.
//

import Foundation
import CoreData

public class FeelsWhy: NSManagedObject {
    @NSManaged public var txt: String
    @NSManaged public var whyText1: String
    @NSManaged public var whyText2: String
    @NSManaged public var howText: String
    @NSManaged public var selectedDate: String
}
