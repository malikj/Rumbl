//  Rumbl-Assignment
//
//  Created by malikj on 05/01/20.
//  Copyright © 2020 malikj. All rights reserved.
//

import UIKit

class CustomVideoPlayCell: UITableViewCell {

    @IBOutlet weak var videoView: VideoView!
    
    class var customCell : CustomVideoPlayCell {
        let cell = Bundle.main.loadNibNamed(Constants.CellIdentifiers.CustomVideoPlayCell, owner: self, options: nil)?.last
        return cell as! CustomVideoPlayCell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func updateCellWithVideo(name:Video) {
        videoView.configure(url: name.encodeUrl)
        videoView.isLoop = true
    }
}
