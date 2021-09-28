

import Foundation
struct Sources : Codable {
	let title : String?
	let crawl_rate : Int?
	let slug : String?
	let url : String?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case crawl_rate = "crawl_rate"
		case slug = "slug"
		case url = "url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		crawl_rate = try values.decodeIfPresent(Int.self, forKey: .crawl_rate)
		slug = try values.decodeIfPresent(String.self, forKey: .slug)
		url = try values.decodeIfPresent(String.self, forKey: .url)
	}

}
