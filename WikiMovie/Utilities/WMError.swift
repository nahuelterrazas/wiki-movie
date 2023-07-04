//
//  WMError.swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 03/07/2023.
//

import Foundation

enum WMError: String, Error {
    case unableToComplete = "Unable to check your request. Please check your internet conection"
    case invalidResponse  = "Invalid response from the server. Movie may not exist"
    case invalidData      = "The data received from the server was invalid. Please try again"
}
