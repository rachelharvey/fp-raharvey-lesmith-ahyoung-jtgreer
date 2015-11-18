//
//  CryptoswiftWrapperTests.swift
//  PasswordGenerator
//
//  Created by Rachel Harvey on 11/17/15.
//  Copyright © 2015 Rachel Harvey, Lucas Smith, Aaron Young, and Jeffery Greer. All rights reserved.
//

import XCTest
@testable import PasswordGenerator

class CryptoswiftWrapperTests: XCTestCase {
    
    func testCrtyptoswiftPasswordIsNotNil() {
        let password = CryptoswiftWrapper(length: 12)
        XCTAssert(password.getPassword() as String! != nil)
    }
    
    func testCryptoswiftPasswordLength() {
        let password = CryptoswiftWrapper(length: 12)
        XCTAssert(password.getPassword().characters.count == 12)
    }
}

