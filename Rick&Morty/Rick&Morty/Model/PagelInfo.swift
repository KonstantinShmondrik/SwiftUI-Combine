//
//  PagelInfo.swift
//  Rick&Morty
//
//  Created by Константин Шмондрик on 07.01.2023.
//

import Foundation

public struct PagelInfo: Codable {
    
    public var count: Int
    public var pages: Int
    public var prev: String?
    public var next: String?
    
    public init(
        count: Int,
        pages: Int,
        prev: String?,
        next: String?
    ) {
        self.count = count
        self.pages = pages
        self.prev = prev
        self.next = next
    }
}
