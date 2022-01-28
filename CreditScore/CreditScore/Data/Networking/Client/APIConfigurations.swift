//
//  APIConfigurations.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 26/1/22.
//

import Foundation

struct BaseURL {
    static let clearscoreBaseURL = "5lfoiyb0b3.execute-api.us-west-2.amazonaws.com"
}

enum ServerEnvironment: String {
    case staging = "Staging"
    case production = "Production"
}