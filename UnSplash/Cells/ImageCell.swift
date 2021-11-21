//
//  ImageCell.swift
//  UnSplash
//
//  Created by Mutee Ur Rehman on 20/11/2021.
//

import UIKit

protocol ImageCellDelegate: AnyObject {
    func imageCellDoubleTapped(_ cell: ImageCell)
    func addButtonPressed(_ cell: ImageCell)

}
class ImageCell: UICollectionViewCell {
    
    ///IBoutlets
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var imageView: AsyncImageView!
    @IBOutlet weak var tagLabel: UILabel!

    ///properties
    weak var delegate: ImageCellDelegate?
    
    ///life cycle
    override func awakeFromNib() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tapGestureRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(tapGestureRecognizer)
    }
   
    ///handle double tap
    @objc func handleTap(sender: UITapGestureRecognizer) {
        delegate?.imageCellDoubleTapped(self)
    }
    
    ///handle Favourite
    func showFavourite() {
        favouriteImageView.isHidden = false
    }
    func hideFavourite() {
        favouriteImageView.isHidden = true
    }

    ///IBActions
    @IBAction func addButtonPressed(_ sender: Any) {
        delegate?.addButtonPressed(self)
    }
    
}
