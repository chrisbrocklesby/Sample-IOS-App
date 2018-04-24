import UIKit

class AddController: UIViewController {
	
	@IBOutlet weak var titleField: UITextField!
	@IBOutlet weak var bodyField: UITextView!
	
	@IBAction func saveButton(_ sender: Any) {
	savePost()
		
	}
	
	func savePost(){
		
		let postTitle = titleField.text
		let postBody = bodyField.text
		
		let bodyData = ["title": postTitle, "body": postBody]
		
		http(url: "https://api.chrisbrocklesby.com", method: "POST", type: "JSON", data: bodyData) { (status, response, error) in
			print("Saved")
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
}
