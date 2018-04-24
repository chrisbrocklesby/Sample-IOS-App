////////////// Imports //////////////
import UIKit

class DetailController: UIViewController {

	@IBOutlet weak var titleLabel: UILabel!
	
	var mytext: String!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		titleLabel.text = mytext
		
		
	}
	
}
