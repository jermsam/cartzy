//
//  MoneyFormatter.swift
//  Cartzy
//
//  Created by Samson Ssali on 4/28/26.
//

import Foundation

func formatMoney(_ cents: UInt32) -> String {
    let dollars = Double(cents) / 100.0
    return dollars.formatted(.currency(code: "USD"))
}
