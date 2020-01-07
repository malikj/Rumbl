//  Rumbl-Assignment
//
//  Created by malikj on 05/01/20.
//  Copyright © 2020 malikj. All rights reserved.
//

import UIKit

class CustomHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    class var customView : CustomHeaderView {
        let cell = Bundle.main.loadNibNamed(Constants.CellIdentifiers.CustomHeaderView, owner: self, options: nil)?.last
        return cell as! CustomHeaderView
    }
    
   override func awakeFromNib() {
        super.awakeFromNib()
    }
}
