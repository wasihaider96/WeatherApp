//
//  weatherModel.swift
//  WheatherApp
//
//  Created by Apple on 17/09/2021.
//

import Foundation

struct weatherModel : Codable {
    let applicable_date : String?
    let created : String?
    let air_pressure : Double?
    let humidity : Double?
    let the_temp : Double?
    let min_temp : Double?
    let weather_state_abbr : String?
    let wind_direction_compass : String?
    let predictability : Double?
//    let id : Int?
    let visibility : Double?
    let wind_speed : Double?
    let wind_direction : Double?
    let max_temp : Double?
    let weather_state_name : String?

    enum CodingKeys: String, CodingKey {

        case applicable_date = "applicable_date"
        case created = "created"
        case air_pressure = "air_pressure"
        case humidity = "humidity"
        case the_temp = "the_temp"
        case min_temp = "min_temp"
        case weather_state_abbr = "weather_state_abbr"
        case wind_direction_compass = "wind_direction_compass"
        case predictability = "predictability"
//        case id = "id"
        case visibility = "visibility"
        case wind_speed = "wind_speed"
        case wind_direction = "wind_direction"
        case max_temp = "max_temp"
        case weather_state_name = "weather_state_name"
    }

    init () {
        applicable_date = ""
        created = ""
        air_pressure = 0.0
        the_temp = 0.0
        min_temp = 0.0
        weather_state_abbr = ""
        wind_direction_compass = ""
        visibility = 0.0
        wind_speed = 0.0
        wind_direction = 0.0
        max_temp = 0.0
        weather_state_name = ""
        predictability = 0.0
        humidity = 0.0
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        applicable_date = try values.decodeIfPresent(String.self, forKey: .applicable_date)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        air_pressure = try values.decodeIfPresent(Double.self, forKey: .air_pressure)
        humidity = try values.decodeIfPresent(Double.self, forKey: .humidity)
        the_temp = try values.decodeIfPresent(Double.self, forKey: .the_temp)
        min_temp = try values.decodeIfPresent(Double.self, forKey: .min_temp)
        weather_state_abbr = try values.decodeIfPresent(String.self, forKey: .weather_state_abbr)
        wind_direction_compass = try values.decodeIfPresent(String.self, forKey: .wind_direction_compass)
        predictability = try values.decodeIfPresent(Double.self, forKey: .predictability)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
        visibility = try values.decodeIfPresent(Double.self, forKey: .visibility)
        wind_speed = try values.decodeIfPresent(Double.self, forKey: .wind_speed)
        wind_direction = try values.decodeIfPresent(Double.self, forKey: .wind_direction)
        max_temp = try values.decodeIfPresent(Double.self, forKey: .max_temp)
        weather_state_name = try values.decodeIfPresent(String.self, forKey: .weather_state_name)
    }

}
