//
//  Result.swift
//  teamvoy
//
//  Created by Alessandro Marconi on 13/11/2019.
//  Copyright © 2019 OleksandrZheliezniak. All rights reserved.
//

import UIKit
// better to use struct here and create another struct for nested object
struct Result: Decodable {
    
    var summary: String?
    var icon: String?
    var temperature: Double?
    var humidity: Double?
    var windSpeed: Double?
    
    var latitude: Double?
    var longitude: Double?
    var timezone: String?
    
    enum CodingKeys: String, CodingKey {
        case currently
        case latitude
        case longitude
        case timezone
    }
    // rawValues are the same as names
    enum CurrentlyCodingKeys: String, CodingKey {
        case summary
        case icon
        case temperature
        case humidity
        case windSpeed
    }
    
    required init(from decoder: Decoder) throws {
        // Direct values
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try? container.decode(Double.self, forKey: .latitude)
        self.longitude = try? container.decode(Double.self, forKey: .longitude)
        self.timezone = try? container.decode(String.self, forKey: .timezone)
        
        // Nested values
        let currentlyContainer = try container.nestedContainer(keyedBy: CurrentlyCodingKeys.self, forKey: .currently)
        self.summary = try currentlyContainer.decode(String.self, forKey: .summary)
        self.icon = try currentlyContainer.decode(String.self, forKey: .icon)
        self.temperature = try currentlyContainer.decode(Double.self, forKey: .temperature)
        self.humidity = try currentlyContainer.decode(Double.self, forKey: .humidity)
        self.windSpeed = try currentlyContainer.decode(Double.self, forKey: .windSpeed)
    }
}
