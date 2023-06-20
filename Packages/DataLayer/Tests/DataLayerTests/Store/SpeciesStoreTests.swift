//
//  SpeciesStoreTests.swift
//  
//
//  Created by Adriano Rezena on 18/06/23.
//

import DomainLayer
import DataLayer
import XCTest

final class SpeciesStoreTests: XCTestCase {

    // MARK: - save
    func test_save_successfullyAddSpecies() throws {
        let expectedResult: [Species] = [makeSpecies()]
        let sut = SpeciesStoreSpy()
        try sut.save(makeSpecies())
        XCTAssertEqual(sut.species, expectedResult)
    }
    
    func test_save_failsOnDatabaseException() throws {
        let sut = SpeciesStoreSpy()
        sut.shouldFail = true
        
        do {
            try sut.save(makeSpecies())
            XCTFail("Expected failure")
        } catch {
            XCTAssertEqual(error as NSError, anyNSError())
        }
    }
    
    // MARK: - delete
    func test_delete_successfullyRemoveSpecies() throws {
        let expectedResult: [Species] = []
        let sut = SpeciesStoreSpy()
        sut.species = [makeSpecies()]
        
        try sut.delete(makeSpecies())
        XCTAssertEqual(sut.species, expectedResult)
    }
    
    func test_delete_failsOnDatabaseException() throws {
        let sut = SpeciesStoreSpy()
        sut.shouldFail = true
        
        do {
            try sut.delete(makeSpecies())
            XCTFail("Expected failure")
        } catch {
            XCTAssertEqual(error as NSError, anyNSError())
        }
    }
    
    // MARK: - get
    func test_get_successfullyReturnSpecies() throws {
        let expectedResult: Species = makeSpecies()
        let sut = SpeciesStoreSpy()
        sut.species = [makeSpecies()]
        let response = try sut.get(id: "999")
        XCTAssertEqual(response, expectedResult)
    }
    
    func test_get_returnsNilIfSpeciesNotFound() throws {
        let expectedResult: Species? = nil
        let sut = SpeciesStoreSpy()
        let response = try sut.get(id: "999")
        XCTAssertEqual(response, expectedResult)
    }
    
    func test_get_failsOnDatabaseException() throws {
        let sut = SpeciesStoreSpy()
        sut.shouldFail = true
        
        do {
            let _ = try sut.get(id: "999")
            XCTFail("Expected failure")
        } catch {
            XCTAssertEqual(error as NSError, anyNSError())
        }
    }
    
    // MARK: - getAll
    func test_getAll_successfullyReturnSpecies() throws {
        let expectedResult: [Species] = [makeSpecies()]
        let sut = SpeciesStoreSpy()
        sut.species = [makeSpecies()]
        let response = try sut.getAll()
        XCTAssertEqual(response, expectedResult)
    }
    
    func test_getAll_failsOnDatabaseException() throws {
        let sut = SpeciesStoreSpy()
        sut.shouldFail = true
        
        do {
            let _ = try sut.getAll()
            XCTFail("Expected failure")
        } catch {
            XCTAssertEqual(error as NSError, anyNSError())
        }
    }
    
}

// MARK: - Helpers
extension SpeciesStoreTests {
    
    private class SpeciesStoreSpy: SpeciesStore {
        var species: [Species] = []
        var shouldFail: Bool = false
        
        func get(id: String) throws -> Species? {
            if shouldFail {
                throw anyNSError()
            }
            
            if let species = species.first(where: { $0.id == id }) {
                return species
            }
            
            return nil
        }
        
        func getAll() throws -> [Species] {
            if shouldFail {
                throw anyNSError()
            }
            
            return species
        }
        
        func save(_ species: Species) throws {
            if shouldFail {
                throw anyNSError()
            }
            
            self.species.append(species)
        }
        
        func delete(_ species: Species) throws {
            if shouldFail {
                throw anyNSError()
            }
            
            self.species.removeAll(where: { $0.id == species.id })
        }
    }
    
    func makeSpecies() -> Species {
        Species(name: "Any Species", id: "999", imageURL: anyURL().absoluteString)
    }

}
