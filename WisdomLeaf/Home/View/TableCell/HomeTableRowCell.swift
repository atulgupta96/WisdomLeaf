//
//  HomeTableRowCell.swift
//  WisdomLeaf
//
//  Created by Atul Gupta on 02/05/23.
//

import UIKit
import SDWebImage

class HomeTableRowCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var checkboxSwitch: UISwitch!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var downloadUrlLabel: UILabel!
    
    //MARK: Private Variables
    private var photo: Photo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        mainImage.sd_cancelCurrentImageLoad()
        mainImage.image = nil
        super.prepareForReuse()
    }
    
    //MARK: Methods
    func setupView(_ photo: Photo) {
        self.photo = photo
        setImage(with: photo.downloadUrl, on: mainImage)
        authorLabel.text = photo.author
        urlLabel.text = photo.url
        downloadUrlLabel.text = photo.downloadUrl
        checkboxSwitch.setOn(photo.isChecked ?? false, animated: false)
    }
    
    private func setImage(with imageUrl: String, on imageView: UIImageView) {
        SDWebImageManager.shared.loadImage(
            with: URL(string: imageUrl)!,
            options: .highPriority,
            progress: nil) { [weak self] (image, _, _, _, _, _) in
                guard let image = image else { return }
                
                let scale = UIScreen.main.scale
                let size = CGSize(width: imageView.bounds.width * scale, height: imageView.bounds.height * scale)
                let scaledImage = image.sd_resizedImage(with: size, scaleMode: .aspectFill)
                
                if imageUrl == self?.photo?.downloadUrl {
                    imageView.image = scaledImage
                    
                } else {
                    self?.setImage(with: self?.photo?.downloadUrl ?? "", on: imageView)
                }
            }
    }
}
