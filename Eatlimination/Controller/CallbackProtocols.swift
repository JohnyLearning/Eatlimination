//
//  RefreshFoodsProtocol.swift
//  Eatlimination

import Foundation

protocol RefreshList: NSObjectProtocol {
    func refresh()
}

protocol OnComplete: NSObjectProtocol {
    func execute()
}

