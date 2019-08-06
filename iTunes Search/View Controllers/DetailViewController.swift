//
//  DetailViewController.swift
//  iTunes Search
//
//  Created by Jake Connerly on 8/6/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //
    //MARK: - IBOutlets & Properties
    //

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistDetailLabel: UILabel!
    
    var searchResult: SearchResult? 
    
    //
    //MARK: - View LifeCycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    //
    //MARK: - IBActions & Methods
    //
    
    private func updateViews() {
        guard let searchResult = searchResult else { return }
        
        let imageURL = searchResult.image
        let data = try? Data(contentsOf: imageURL)
        
        guard let imageData = data,
            let image = UIImage(data: imageData),
            let imageView = imageView else { return }
        
        imageView.image        = image
        trackNameLabel.text    = searchResult.title
        artistDetailLabel.text = "\(searchResult.creator) - \(searchResult.album)"
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}



