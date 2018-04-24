struct Root: Codable{
	var data:[Data]
}

struct Data: Codable{
	let id: Int
	let title: String
	let body: String
}

struct Post: Codable{
	let id: Int
	let title: String
	let body: String
}

var postArray = [Post]()

