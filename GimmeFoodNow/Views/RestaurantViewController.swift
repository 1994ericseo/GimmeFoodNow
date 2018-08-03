import UIKit

protocol RestaurantViewControllerDelegate: class {
    func addedToFavorites()
    func unableToFavorite()
}

class RestaurantViewController: UIViewController {
    
    let viewModel: RestaurantViewModel

    init(viewModel: RestaurantViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavoritesAction))
        showFavoriteButton(enabled: viewModel.showFavoriteButton)
    }
    
    func addToFavoritesAction() {
        self.viewModel.addToFavorites()
    }
    
    func showFavoriteButton(enabled: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = enabled
    }
}

extension RestaurantViewController: RestaurantViewControllerDelegate {
    func addedToFavorites() {
        let alert = UIAlertController(title: "Added to favorites", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
        showFavoriteButton(enabled: viewModel.showFavoriteButton)
    }
    
    func unableToFavorite() {
        let alert = UIAlertController(title: "Unable to favorite", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
