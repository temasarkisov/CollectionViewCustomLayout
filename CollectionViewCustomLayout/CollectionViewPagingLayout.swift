import UIKit

final class CollectionViewPagingLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
        guard let collectionView else {
            return super.targetContentOffset(
                forProposedContentOffset: proposedContentOffset,
                withScrollingVelocity: velocity
            )
        }

        let offsetInPages = collectionView.contentOffset.x / pageWidth
        let roundPage = calculateRoundPage(
            offsetInPages: offsetInPages,
            velocity: velocity
        )
        let passedPages = calculatePassedPages(velocity: velocity)
        let finalHorizontalOffset = (roundPage + passedPages) * pageWidth - collectionView.contentInset.left

        return CGPoint(
            x: finalHorizontalOffset,
            y: proposedContentOffset.y
        )
    }
}

extension CollectionViewPagingLayout {
    private var pageWidth: CGFloat {
        itemSize.width + minimumInteritemSpacing
    }

    private func calculateRoundPage(
        offsetInPages: CGFloat,
        velocity: CGPoint
    ) -> CGFloat {
        if velocity.x.isZero {
            return round(offsetInPages)
        }
        
        if velocity.x < .zero {
            return floor(offsetInPages)
        }
        
        return ceil(offsetInPages)
    }

    private func calculatePassedPages(velocity: CGPoint) -> CGFloat {
        let shouldStop = abs(round(velocity.x)) <= 1
        return shouldStop ? .zero : round(velocity.x)
    }
}
