////////////// Imports //////////////
import UIKit
import MessageUI

class DetailController: UIViewController {

	@IBOutlet weak var titleLabel: UILabel!
	
	@IBAction func emailButton(_ sender: Any) {
		let composeVC = MFMailComposeViewController()
		composeVC.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
		
		// Configure the fields of the interface.
		composeVC.setToRecipients(["chrisbrocklesby@icloud.com"])
		composeVC.setSubject("StoryBook Feedback")
		composeVC.setMessageBody("Hey Josh! Here's my feedback.", isHTML: false)
		
		// Present the view controller modally.
		self.present(composeVC, animated: true, completion: nil)
	}
	
	var mytext: String!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		titleLabel.text = mytext
		
		
	}
	
}
