//  Rumbl-Assignment
//
//  Created by malikj on 05/01/20.
//  Copyright © 2020 malikj. All rights reserved.
//

import UIKit
import AVFoundation

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    class var CustomCell : CustomCollectionViewCell {
        let cell = Bundle.main.loadNibNamed(Constants.CellIdentifiers.CustomCollectionViewCell, owner: self, options: nil)?.last
        return cell as! CustomCollectionViewCell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImageView.layer.cornerRadius = 6
        cellImageView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        cellImageView.image = nil;
    }
}
