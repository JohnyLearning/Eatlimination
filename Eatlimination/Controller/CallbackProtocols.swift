//
//  RefreshFoodsProtocol.swift
//  Eatlimination

import Foundation

protocol RefreshList: NSObjectProtocol {
    func refresh(doit: Bool)
}

protocol OnComplete: NSObjectProtocol {
    func execute()
}

