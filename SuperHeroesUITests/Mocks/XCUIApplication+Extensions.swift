//
//  XCUIApplication+Extensions.swift
//  SuperHeroesUITests
//
//  Created by Joseph Umoru on 23/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
import XCTest

/*
 Description: Verify if the UI element with the identifier exists
 */

extension XCUIApplication {
    var isDisplayingOnboarding: Bool {
        return otherElements["onboardingView"].exists
    }
}
