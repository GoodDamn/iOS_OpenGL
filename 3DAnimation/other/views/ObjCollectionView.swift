//
//  ObjsCollectionView.swift
//  3DAnimation
//
//  Created by GoodDamn on 26/02/2024.
//

import Foundation
import UIKit.UICollectionView


final class ObjCollectionView
    : UICollectionView {
    
    private let mId = "cell"
    
    weak var delegateObj: ObjCollectionViewDelegate? = nil
    
    private let mObjs: [String]?
    
    init(
        frame: CGRect,
        direction: UICollectionView
            .ScrollDirection
    ) {
        mObjs = Bundle.files(
            ".obj"
        )
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = direction
        
        let b = frame.width * 0.3
        
        layout.itemSize = CGSize(
            width: b,
            height: b
        )
        
        super.init(
            frame: frame,
            collectionViewLayout: layout
        )
     
        register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: mId
        )
        
        delegate = self
        dataSource = self
        
    }
    
    
    required init?(coder: NSCoder) {
        mObjs = Bundle.files(
            ".objs"
        )
        super.init(coder: coder)
    }
    
}

extension ObjCollectionView
    : UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return mObjs?.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let index = indexPath.row
        
        let cell = collectionView
            .dequeueReusableCell(
            withReuseIdentifier: mId,
            for: indexPath
        )
        
        let content = cell.contentView
        let views = content.subviews
        
        cell.contentView
            .backgroundColor = .green
        
        if views.isEmpty {
            
            let title = UILabel(
                frame: CGRect(
                    origin: .zero,
                    size: cell.frame.size
                )
            )
            
            title.tintColor = .systemBlue
            title.text = mObjs?[index]
            
            content.addSubview(title)
            return cell
        }
        
        let title = views[0] as? UILabel
        title?.text = mObjs?[index]
        return cell
    }
    
    
}

extension ObjCollectionView
: UICollectionViewDelegate {
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        delegateObj?.onSelectObject(
            name: mObjs?[indexPath.row]
        )
    }
    
}
