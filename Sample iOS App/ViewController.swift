////////////// Imports //////////////

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
	
	////////////// Interface Builder Connection //////////////
	
    @IBOutlet var tableView: UITableView!
	@IBOutlet var searchBar: UISearchBar!

	////////////// Set Variables //////////////
	
	var refreshControl: UIRefreshControl!
	var searchArray = [Post]()
	
	////////////// Default Functions //////////////
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		/// Nav Logo
		let logo = UIImage(named: "logo")
		let imageView = UIImageView(image:logo )
		self.navigationItem.titleView = imageView
		
		/// Refresh Pull Down Settings
		refreshControl = UIRefreshControl()
		refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
		refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
		tableView.addSubview(refreshControl)
		
		/// Search Bar Settings
		searchBar.delegate = self
		
		/// UI Settings
		UIApplication.shared.statusBarStyle = .lightContent // white status bar + Info.plist setting
		
		/// Get Data on view load from JSON and put into 'postArray'
		getData()
		
	}
	
	
	////////////// Custom Functions //////////////
	
	/// Refresh Pull Down
	@objc func refresh(_ sender: Any) {
		getData()
		refreshControl.endRefreshing()
		tableView.reloadData()
		print("Refreshed !")
	}
	
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		searchArray = postArray.filter {
			return $0.title.lowercased().contains(searchBar.text!.lowercased())
		}
		
		tableView.reloadData()
		print(searchArray)
	}
	
	//func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
	//	print("searchText \(searchBar.text ?? "No Results")")
	//}

	func getData() {
		http(url: "https://api.chrisbrocklesby.com", method: "GET") { (status, response, error) in
			
			// Clear postArray Data
			postArray.removeAll()
			
			// Parse Data 'JSON' String (response) into useable data type.
			guard let data = response?.data(using: .utf8)! else {
				print("Error: No JSON data to decode")
				return
			}
			
			// Decode JSON Data and put into a (Post) structure
			guard let json = try? JSONDecoder().decode(Root.self, from: data) else {
				print("Error: Couldn't decode data into Post structure")
				return
			}
			
			// Loop JSON data and insert into postArray
			for result in json.data {
				postArray.insert(Post(id: result.id, title: result.title, body: result.body), at: postArray.endIndex)
			}
			
		}
	}

	////////////// Table View Functions //////////////
	
	//// Set row number in Table View ////
	func tableView(_ tableView: UITableView, numberOfRowsInSection numberOfRows: Int) -> Int {
		if searchArray.isEmpty == false {
			return searchArray.count
		}
		if searchBar.text?.isEmpty == false {
			return 0
		}
		return postArray.count
	}
	
	//// Cell Content in Table View ////
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		/// Set Cell Var
		let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
		
		/// Set Cell Content
		
		if searchArray.isEmpty == false {
			cell.textLabel?.text = searchArray[indexPath.row].title
		} else if searchArray.isEmpty == true {
			cell.textLabel?.text = postArray[indexPath.row].title
		}
		cell.detailTextLabel?.text = String(postArray[indexPath.row].id)
		//cell.imageView?.image = UIImage(named: "apple")
        //cell.backgroundColor = UIColor.brown
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		let myVC = storyboard?.instantiateViewController(withIdentifier: "DetailController") as! DetailController
		navigationController?.pushViewController(myVC, animated: true)
		
		if searchArray.isEmpty == false {
			myVC.mytext = searchArray[indexPath.row].title
		} else if searchArray.isEmpty == true {
			myVC.mytext = postArray[indexPath.row].title
		}
		
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			postArray.remove(at: indexPath.row)
			http(url: "https://api.chrisbrocklesby.com/\(indexPath.row)", method: "DELETE")
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}

}
