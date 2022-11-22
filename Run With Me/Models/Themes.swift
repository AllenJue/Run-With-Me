//
//  Themes.swift
//  Run With Me
//
//  Created by Allen Jue on 11/17/22.
//

import Foundation
import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    case pastey
    case ocean
    case platinum
    case pinky
    case UT
    case love
    case limey
    case magic
    case zhu
    
    var accentColor: Color {
//        switch self {
//        case .limey, .pinky, .zhu, .pastey: return .black
//        case .magic, .UT, .love, .platinum, .ocean: return .white
//        }
        return .black
        
    }
    
    var mainColor: Color {
        Color(rawValue)
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
}


