//
//  DefaultPaginatorTests.swift
//  MoviesTests
//
//  Created by Benjamin Macanovic on 07.06.2024..
//

import XCTest
@testable import Movies

final class DefaultPaginatorTests: XCTestCase {
    func test_initial() async throws {
        let sut = makeSUT()
        let currentPage = await sut.getCurrentPage()
        XCTAssertEqual(currentPage, 1)
    }
    
    func test_paging() async throws {
        let sut = makeSUT()
        
        let data = DummyData(currentPage: 1)
        try await sut.paginate(data)
        let currentPage = await sut.getCurrentPage()
        XCTAssertEqual(currentPage, 2)
        
        let data2 = DummyData(currentPage: 2)
        try await sut.paginate(data2)
        let currentPage2 = await sut.getCurrentPage()
        XCTAssertEqual(currentPage2, 3)
        
        let data3 = DummyData(currentPage: 3)
        try await sut.paginate(data3)
        let currentPage3 = await sut.getCurrentPage()
        XCTAssertEqual(currentPage3, 4)
    }
    
    func test_noMorePages() async throws {
        let sut = makeSUT()
        
        let data = DummyData(currentPage: 9)
        try await sut.paginate(data)
        let currentPage = await sut.getCurrentPage()
        XCTAssertEqual(currentPage, 10)
        
        let data2 = DummyData(currentPage: 10)
        do {
            _ = try await sut.paginate(data2)
            XCTFail("Should have thrown an AllPagesLoadedError")
        } catch {
            guard error is AllPagesLoadedError else {
                XCTFail("Wrong error type")
                return
            }
        }
    }
}

extension DefaultPaginatorTests {
    func makeSUT() -> DefaultPaginator {
        .init()
    }
}

struct DummyData: Paginatable, Equatable {
    let currentPage: Int
    let totalPages: Int = 10
}
