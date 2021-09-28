

import Foundation
struct Parent : Codable {
	let woeid : Int?
	let location_type : String?
	let latt_long : String?
	let title : String?

	enum CodingKeys: String, CodingKey {

		case woeid = "woeid"
		case location_type = "location_type"
		case latt_long = "latt_long"
		case title = "title"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		woeid = try values.decodeIfPresent(Int.self, forKey: .woeid)
		location_type = try values.decodeIfPresent(String.self, forKey: .location_type)
		latt_long = try values.decodeIfPresent(String.self, forKey: .latt_long)
		title = try values.decodeIfPresent(String.self, forKey: .title)
	}

}
