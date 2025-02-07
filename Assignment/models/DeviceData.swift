//
//  ComputerItem.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation
import SwiftData


// MARK: - ComputerItem
@Model
final class DeviceData: Codable, Identifiable, Hashable, Equatable {
    static func == (lhs: DeviceData, rhs: DeviceData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @Attribute(.unique) var id: String
    var name: String
    var data: ItemData?
    
    enum CodingKeys: String, CodingKey {
        case id, name, data
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        data = try? container.decode(ItemData.self, forKey: .data)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(data, forKey: .data)
    }
}

@Model
final class ItemData: Codable {
    
    var color: String?
    var capacity: String?
    var price: Double?
    var capacityGB: Int?
    var screenSize: Double?
    var desc: String?
    var generation: String?
    var strapColour: String?
    var caseSize: String?
    var cpuModel: String?
    var hardDiskSize: String?

    enum CodingKeys: String, CodingKey {
        case color
        case capacity
        case price
        case capacityGB = "capacity GB"
        case screenSize = "Screen size"
        case desc = "Description"
        case generation = "Generation"
        case strapColour = "Strap Colour"
        case caseSize = "Case Size"
        case cpuModel = "CPU model"
        case hardDiskSize = "Hard disk size"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        color = try? container.decode(String.self, forKey: .color)
        capacity = try? container.decode(String.self, forKey: .capacity)
        price = try? container.decode(Double.self, forKey: .price)
        capacityGB = try? container.decode(Int.self, forKey: .capacityGB)
        screenSize = try? container.decode(Double.self, forKey: .screenSize)
        desc = try? container.decode(String.self, forKey: .desc)
        generation = try? container.decode(String.self, forKey: .generation)
        strapColour = try? container.decode(String.self, forKey: .strapColour)
        caseSize = try? container.decode(String.self, forKey: .caseSize)
        cpuModel = try? container.decode(String.self, forKey: .cpuModel)
        hardDiskSize = try? container.decode(String.self, forKey: .hardDiskSize)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(color, forKey: .color)
        try container.encode(capacity, forKey: .capacity)
        try container.encode(price, forKey: .price)
        try container.encode(capacityGB, forKey: .capacityGB)
        try container.encode(screenSize, forKey: .screenSize)
        try container.encode(desc, forKey: .desc)
        try container.encode(generation, forKey: .generation)
        try container.encode(strapColour, forKey: .strapColour)
        try container.encode(caseSize, forKey: .caseSize)
        try container.encode(cpuModel, forKey: .cpuModel)
        try container.encode(hardDiskSize, forKey: .hardDiskSize)
    }
}
