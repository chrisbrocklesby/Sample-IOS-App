struct Post : Decodable {
	
	struct Data : Decodable {
		let id: Int
		let title: String
		let body: String
	}
	
	let data : [Data]
}


var postArray = [Post]()

