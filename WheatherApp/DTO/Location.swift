
import Foundation
struct LocationData : Codable {
	// let sources : [Sources]?
	let location_type : String?
	let title : String?
	let latt_long : String?
	let timezone_name : String?
	let sun_rise : String?
	// let consolidated_weather : [Weather]?
	let sun_set : String?
	let woeid : Int?
	// let parent : Parent?
	let time : String?
	let timezone : String?

	enum CodingKeys: String, CodingKey {

		// case sources = "sources"
		case location_type = "location_type"
		case title = "title"
		case latt_long = "latt_long"
		case timezone_name = "timezone_name"
		case sun_rise = "sun_rise"
		// case consolidated_weather = "consolidated_weather"
		case sun_set = "sun_set"
		case woeid = "woeid"
		// case parent = "parent"
		case time = "time"
		case timezone = "timezone"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		// sources = try values.decodeIfPresent([Sources].self, forKey: .sources)
		location_type = try values.decodeIfPresent(String.self, forKey: .location_type)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		latt_long = try values.decodeIfPresent(String.self, forKey: .latt_long)
		timezone_name = try values.decodeIfPresent(String.self, forKey: .timezone_name)
		sun_rise = try values.decodeIfPresent(String.self, forKey: .sun_rise)
		// consolidated_weather = try values.decodeIfPresent([Weather].self, forKey: .consolidated_weather)
		sun_set = try values.decodeIfPresent(String.self, forKey: .sun_set)
		woeid = try values.decodeIfPresent(Int.self, forKey: .woeid)
		// parent = try values.decodeIfPresent(Parent.self, forKey: .parent)
		time = try values.decodeIfPresent(String.self, forKey: .time)
		timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
	}

}
