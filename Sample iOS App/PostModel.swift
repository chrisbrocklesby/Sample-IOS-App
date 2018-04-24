// JSON (Decodable) Structure - Top Level
struct Root: Decodable {
	var data:[Data] // Set as Array
}

// JSON (Decodable) Structure - Nested Data Values (Array)
struct Data: Decodable {
	let id: Int
	let title: String
	let body: String
}

// Post (Codable) Structure - Uses Decoded JSON Structure
struct Post: Codable {
	let id: Int
	let title: String
	let body: String
}

var postArray = [Post]()

