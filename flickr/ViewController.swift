//
//  ViewController.swift
//  flickr
//
//  Created by AZioT on 2021-07-14.
//

import UIKit
import Alamofire

struct Photo: Decodable {
    var id: String
    var title: String
    var owner: String
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case owner = "owner"
      }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var photoArr: [Photo] = []

    var photo1: Photo = Photo(id: "https://picsum.photos/id/237/200/300", title: "Gajah Sumatera di Temukan Mati Tanpa Kepala", owner: "51310278407")

    override func viewDidLoad() {
        super.viewDidLoad()        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        photoArr.append(photo1)
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photoArr.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! TableViewCell

        let photo = photoArr[indexPath.row]
        cell.titleLabel?.text = photo.title
        cell.ownerIDLabel?.text = photo.id
        
        AF.request( photo.id, method: .get).response{ response in

           switch response.result {
            case .success(let responseData):
                cell.photoImage?.image = UIImage(data: responseData!, scale:1)

            case .failure(let error):
                print("error--->",error)
            }
        }

        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    // Network manager need to write in seperate class
    func loadData () {
        let url = "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=56b967889e2bbe0848dd63f7161cb30a&format=json&nojsoncallback=1"
        Session.default.request(url).responseDecodable(of: Photo.self) { response in

            switch response.result {
            case .success(let photos):
//                print(users.map { "\($0.id) \($0.title)" })
            print ("")
            case .failure(let error):
                print(error)
            }
        }
    }
}


