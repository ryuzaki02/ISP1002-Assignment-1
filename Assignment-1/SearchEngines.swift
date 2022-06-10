//
//  SearchEngines.swift
//  Assignment-1
//
//  Created by Aman on 10/06/22.
//

import Foundation

class SearchEngines {
    enum SearchEngine: String, CaseIterable {
        case Google = "Google Search"
        case Bing = "Microsoft Bing"
        case Yahoo = "Yahoo Search"
        case Baidu = "Baidu"
        case DuckDuckGo = "Duck Duck Go"
    }
    
    @discardableResult
    public init() {
        showSeachEngineNames()
    }
    
    private func showSeachEngineNames() {
        var i = 1
        print("Number of search engines present: -")
        for engine in SearchEngine.allCases {
            print("\(i). " + engine.rawValue)
            i += 1
        }
    }
}
