//
//  UdacityError.swift
//  On The Map

import Foundation

struct ApiError: Codable {
    let status: Int
    let error: String
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
