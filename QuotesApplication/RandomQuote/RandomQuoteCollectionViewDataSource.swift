//
//  RandomQuoteCollectionViewDataSource.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 27.12.2021.
//

import UIKit

class RandomQuoteCollectionViewDataSource: NSObject {
    private var viewModel: RandomQuoteViewModelProtocol
    
    init(_ viewModel: RandomQuoteViewModelProtocol) {
        self.viewModel = viewModel
    }
}

extension RandomQuoteCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tagsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TagCell.self), for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: viewModel.tagsArray[indexPath.item])
        
        return cell
    }
}

extension RandomQuoteCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (VisualConstants.letterWidth * CGFloat(viewModel.tagsArray[indexPath.item].count)) + (VisualConstants.letterWidth * 2.0)
        return CGSize(width: width, height: VisualConstants.collectionCellHeight)
    }
}
