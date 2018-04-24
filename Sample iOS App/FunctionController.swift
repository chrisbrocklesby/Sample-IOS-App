////////////// Imports //////////////

import UIKit

class FunctionController: UIViewController {

	////////////// Post Request Button Action //////////////
	@IBAction func postButton(_ sender: Any) {
		
		let bodyData = ["title": "Ms. Piggy", "body": "This is a female pig."]
		
		http(url: "https://api.chrisbrocklesby.com", method: "POST", type: "JSON", data: bodyData)
		
		/// Alert Popup Box
		let alertPopup = UIAlertController(title: "POST added", message: "New post to JSON", preferredStyle: UIAlertControllerStyle.alert)
		
		alertPopup.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default,handler: nil))
		
		self.present(alertPopup, animated: true, completion: nil)
	}
	
	////////////// Get Request Button Action //////////////
	@IBAction func getButton(_ sender: Any) {

			
			/// Alert Popup Box
			let alertPopup = UIAlertController(title: "GET post", message: "Printed Results in Xcode Panel", preferredStyle: UIAlertControllerStyle.alert)
			
			alertPopup.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default,handler: nil))
			
			self.present(alertPopup, animated: true, completion: nil)
		
	}
	
	
}
