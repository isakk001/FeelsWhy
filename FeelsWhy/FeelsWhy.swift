//
//  FeelsWhy.swift
//  FeelsWhy
//
//  Created by Yisak on 2023/08/23.
//

import Foundation
import CoreData

public class FeelsWhy: NSManagedObject {
//    @NSManaged public var id: UUID
    @NSManaged public var txt: String
    @NSManaged public var diarytxt: String
    @NSManaged public var selectedDate: Date
}
