
//  Rumbl-Assignment
//
//  Created by malikj on 05/01/20.
//  Copyright © 2020 malikj. All rights reserved.
//

import Foundation
import UIKit

public struct Constants {
    
    struct CellIdentifiers {
        static let Main = "Main"
        static let CustomHeaderView = "CustomHeaderView"
        static let CustomTableViewCell = "CustomTableViewCell"
        static let CustomVideoPlayCell = "CustomVideoPlayCell"
        static let DetailViewController = "DetailViewController"
        static let CustomCollectionViewCell = "CustomCollectionViewCell"
    }
    
    struct Titles {
        static let Explore = "Explore"
        static let PlayerScreen = "Player Screen"
    }
    
    struct Size {
        static let TableViewHeight: CGFloat = 260
        static let HeightForHeaderInSection: CGFloat = 40
        static let CollectionCellWidth: CGFloat = 140
        static let CollectionCellHeight: CGFloat = 235
    }

    struct Key {
        struct JsonKeys {
        static let fileExtention = "json"
        static let jsonFileNameKey = "assignment"
        static let nodesKey = "nodes"
        static let titleKey = "title"
        static let videoKey = "video"
        static let encodeUrlKey = "encodeUrl"
        }
    }
    
    struct ImageNames {
        static let backIconImage = "arrowPointingToRightCopy"

    }
    
    
}
