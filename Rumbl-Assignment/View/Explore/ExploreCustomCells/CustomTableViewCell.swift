//  Rumbl-Assignment
//
//  Created by malikj on 05/01/20.
//  Copyright © 2020 malikj. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

protocol CustomCollectionCellDelegate:class {
    
    func collectionView(collectioncell:CustomCollectionViewCell?, didTappedInTableview TableCell:CustomTableViewCell)
}

class CustomTableViewCell:UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    weak var cellDelegate:CustomCollectionCellDelegate? 
    @IBOutlet weak var collectionView: UICollectionView!
    
    var rootModel:Root?
    var imageCacheLoader : ImageLoader?
    let cellReuseId = "CollectionViewCell"
    class var customCell : CustomTableViewCell {
        let cell = Bundle.main.loadNibNamed(Constants.CellIdentifiers.CustomTableViewCell, owner: self, options: nil)?.last
        return cell as! CustomTableViewCell
    }
    
    override func prepareForReuse() {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: Constants.Size.CollectionCellWidth, height: Constants.Size.CollectionCellHeight)
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.minimumInteritemSpacing = 10.0
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        //register the xib for collection view cell
        let cellNib = UINib(nibName: Constants.CellIdentifiers.CustomCollectionViewCell, bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: cellReuseId)
    }
    
    //MARK: Instance Methods
    func updateCellWith(root:Root, imageCache: ImageLoader) {
        imageCacheLoader = imageCache;
        self.rootModel = root
        self.collectionView.reloadData()
    }
    
    //MARK: Collection view datasource and Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell
        self.cellDelegate?.collectionView(collectioncell: cell, didTappedInTableview: self)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let cell = cell as! CustomCollectionViewCell
//        cell.tag = indexPath.row
//        if let rootImageName = self.rootModel?.nodes[indexPath.item] {
//            updateCellWithImage(cell: cell, name: rootImageName.video, indexPath: indexPath)
//        }
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let nodes = self.rootModel?.nodes {
            return nodes.count
        } else {
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as? CustomCollectionViewCell
        cell?.tag = indexPath.row
        if let rootImageName = self.rootModel?.nodes[indexPath.item] {
            updateCellWithImage(cell: cell!, name: rootImageName.video, indexPath: indexPath)
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
    
    //MARK: Update Cells

    func updateCellWithImage(cell : CustomCollectionViewCell, name:Video, indexPath: IndexPath) {
        cell.activityIndicator.startAnimating()
        imageCacheLoader!.obtainImageWithPath(imagePath: name.encodeUrl) { (image) in
            if(cell.tag == indexPath.row) {
                cell.activityIndicator.stopAnimating();
                cell.cellImageView.image = image;
            }
        }
    }

}
