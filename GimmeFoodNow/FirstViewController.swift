import UIKit

protocol FirstViewControllerDelegate: class {
    func updateLoadingState(isLoading: Bool)
    func showErrorState()
    func showRestaurantViewController(viewModel: RestaurantViewModel)
}

class FirstViewController: UIViewController {
    
    private var viewModel: FirstViewModel? {
        didSet {
            setupView()
        }
    }
    
    private lazy var findMeFoodButton: UIButton = {
        if let viewModel = self.viewModel {
            let button = UIButton(type: .roundedRect)
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 16)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(viewModel.buttonTitle, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.blue.cgColor
            button.sizeToFit()
            button.addTarget(self, action: #selector(findMeFoodButtonAction), for: .touchUpInside)
            return button
        }
        return UIButton()
    }()
    
    private lazy var spinnerView: UIView = {
        let spinnerView = UIView(frame: self.view.bounds)
        spinnerView.backgroundColor = UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        loadingIndicator.center = self.view.center
        loadingIndicator.startAnimating()
        loadingIndicator.center = spinnerView.center
        spinnerView.addSubview(loadingIndicator)
        return spinnerView
    }()
    
    init(viewModel: FirstViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel?.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setupView()
        setupConstraints()
        super.viewDidLoad()
    }
    
    func setupView() {
        title = "Find me food"
        view.addSubview(findMeFoodButton)
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(bookmarksTapped))
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            findMeFoodButton.heightAnchor.constraint(equalToConstant: 48),
            findMeFoodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            findMeFoodButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func findMeFoodButtonAction() {
        if let viewModel = self.viewModel {
            viewModel.findMeFoodAction()
        }
    }
    
    func bookmarksTapped() {
        let bookmarksTableViewController = FavoritesTableViewController(viewModel: FavoritesTableViewModel())
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(bookmarksTableViewController, animated: true)
        }
    }
    
    func displaySpinner() {
        DispatchQueue.main.async { [weak self] in
            if let viewController = self {
                viewController.view.addSubview(viewController.spinnerView)
            }
        }
    }
    
    func removeSpinner() {
        DispatchQueue.main.async { [weak self] in
            self?.spinnerView.removeFromSuperview()
        }
    }
}

extension FirstViewController: FirstViewControllerDelegate {
    func updateLoadingState(isLoading: Bool) {
        if isLoading {
            displaySpinner()
        } else {
            removeSpinner()
        }
    }
    
    func showErrorState() {
        let alert = UIAlertController(title: "Invalid current location", message: "Allow location services by going to settings", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showRestaurantViewController(viewModel: RestaurantViewModel) {
        let viewController = RestaurantViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

