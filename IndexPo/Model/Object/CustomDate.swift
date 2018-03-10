//
//  Date.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/25/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit
enum CustomDateType {
    case persian
    case english
}

class CustomDate: BaseObject {
    var year:Int = 0
    var month:Int = 0
    var day:Int = 0
    var calenderType:CustomDateType = .persian
}
