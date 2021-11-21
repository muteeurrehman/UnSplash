//
//  ViewController.swift
//  UnSplash
//
//  Created by Mutee Ur Rehman on 20/11/2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addTagContainer: UIView!
    
    @IBOutlet weak var addTagViewHeightConstraint: NSLayoutConstraint!

    //MARK: - Properties
    var images: [Image] = []
    var selectedImageId: Int!
    
    //MARK: - Vc's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTagContainer.isHidden = true
        loadData()
    }
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
      super.preferredContentSizeDidChange(forChildContentContainer: container)
      if (container as? AddTagVC) != nil {
          addTagViewHeightConstraint?.constant = container.preferredContentSize.height
      }
    }

    func loadData() {
        images = DataService.getImages()
        collectionView.reloadData()
    }
    
    //MARK: - Screen rotation
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        collectionView.reloadData()
    }
}

//MARK: - Collection View
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.image.rawValue, for: indexPath) as! ImageCell
        let image = images[indexPath.row]
        cell.imageView.setImageURL(image.url)
        cell.tagLabel.text = image.tag
        cell.tag = indexPath.row
        cell.delegate = self
        image.isFavourite == true ? cell.showFavourite() : cell.hideFavourite()
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = view.safeAreaLayoutGuide.layoutFrame.size
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            return CGSize(width: screenSize.width/2 - 10, height: screenSize.width/2 - 10)
        }
        return CGSize(width: screenSize.width, height: screenSize.width)
    }

}

//MARK: - Image Cell Delegate
extension ViewController: ImageCellDelegate {
    func imageCellDoubleTapped(_ cell: ImageCell) {
        let index = cell.tag
        
        let image = images[index]
        image.isFavourite ? DataService.removeFromFavourites(id: image.id) : DataService.addToFavourites(id: image.id)
        
        loadData()
    }
    func addButtonPressed(_ cell: ImageCell) {
        let index = cell.tag
        selectedImageId = images[index].id
        addTagContainer.isHidden = false
    }
}

//MARK: - AddTagVC Delegate
extension ViewController: AddTagVCDelegate {
    func addTagAddPressed(tag: String) {
        DataService.add(tag: tag, toImageWith: selectedImageId)
        addTagContainer.isHidden = true
        loadData()
    }
    
    func addTagCancelPressed() {
        addTagContainer.isHidden = true
    }
    
    func addTagDidStartEditing() {
    }
   
    func addTagDidEndEditing() {
    }
}

//MARK: - Navigation
extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddTagVC {
            vc.delegate = self
        }
    }
}


