//
//  InnovationAttributes.swift
//  AEPSampleApp
//
//  Created by phuo on 10/10/22.
//  Copyright © 2022 Christopher Hoffman. All rights reserved.
//

import SwiftUI
import ActivityKit

struct InnovationAttributes: ActivityAttributes {
    public typealias PizzaDeliveryStatus = ContentState

    public struct ContentState: Codable, Hashable {
        var driverName: String
        var deliveryTimer: ClosedRange<Date>
    }

    var numberOfPizzas: Int
    var totalAmount: String
    var orderNumber: String
}
