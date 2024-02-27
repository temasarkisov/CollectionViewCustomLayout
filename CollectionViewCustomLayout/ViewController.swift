import UIKit

private enum Constants {
    static let countCells: Int = 20
    static let cellId: String = String(describing: UICollectionViewCell.self)
    static let collectionLayoutMargins: UIEdgeInsets = .init(
        top: 0,
        left: 10,
        bottom: 0,
        right: 10
    )
}

class ViewController: UIViewController {
    private let collectionView: UICollectionView = ViewController.makeCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyCellSizeForCollectionViewLayout()
    }
}

extension ViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavBar()
        setupCollectionView()
    }

    private func setupNavBar() {
        title = "Collection"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupCollectionView() {
        collectionView.layoutMargins = Constants.collectionLayoutMargins
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.cellId
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        Constants.countCells
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellId,
            for: indexPath
        )

        cell.layer.cornerRadius = 10
        cell.backgroundColor = .systemGray5

        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        Constants.collectionLayoutMargins
    }
}

extension ViewController {
    private func applyCellSizeForCollectionViewLayout() {
        let collectionLayout = collectionView.collectionViewLayout as? CollectionViewPagingLayout
        collectionLayout?.itemSize = .init(
            width: view.frame.width / 1.5,
            height: view.frame.height / 2
        )
        collectionLayout?.prepare()
        collectionLayout?.invalidateLayout()
    }
}

extension ViewController {
    static func makeCollectionView() -> UICollectionView {
        let pagingLayout = CollectionViewPagingLayout()
        pagingLayout.scrollDirection = .horizontal

        return UICollectionView(
            frame: .zero,
            collectionViewLayout: pagingLayout
        )
    }
}
