//
//  BaseURL.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 28/1/22.
//

import Foundation

protocol BaseURLType {
    var domain: String { get }
}

struct BaseURL: BaseURLType {
    let domain = "5lfoiyb0b3.execute-api.us-west-2.amazonaws.com"
}
