//
//  CustomCell.swift
//  Documents
//
//  Created by Дмитрий Голубев on 02.05.2022.
//

import Foundation
import UIKit

final class CustomCell: UITableViewCell{
    var image: UIImage?
    
    lazy var customImageView: UIImageView = {
        let customImageView = UIImageView()
        customImageView.contentMode = .scaleAspectFit
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(customImageView)
        
        return customImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setUpLayout(){
        NSLayoutConstraint.activate([
            customImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customImageView.topAnchor.constraint(equalTo: self.topAnchor),
            customImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
