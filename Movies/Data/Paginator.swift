//
//  Pager.swift
//  Movies
//
//  Created by Benjamin Macanovic on 07.06.2024..
//

import Foundation

protocol Paginatable {
    var currentPage: Int { get }
    var totalPages: Int { get }
}

protocol Paginator: Sendable {
    func getCurrentPage() async -> Int
    func paginate<T: Paginatable & Sendable>(_ data: T) async throws
    func reset() async
}

struct AllPagesLoadedError: Error {}

actor DefaultPaginator: Paginator {
    private var currentPage = 1
    
    func paginate<T: Paginatable & Sendable>(_ data: T) throws {
        guard currentPage < data.totalPages else { throw AllPagesLoadedError() }
        
        currentPage = data.currentPage + 1
    }
    
    func getCurrentPage() async -> Int {
        currentPage
    }
    
    func reset() {
        currentPage = 1
    }
}
