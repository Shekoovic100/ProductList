# ProductList

ProductListApp is an iOS application that fetches and displays a list of products from the Fake Store API. Built with UIKit, Storyboard, and Swift, the app follows the MVVM architecture with Clean Architecture principles to ensure modularity, testability, and maintainability. It features a paginated collection view, grid/list view toggling, skeleton loading animations, offline handling, and navigation to product details. The project includes some comprehensive unit tests to ensure robust functionality.

## Features


### Product Listing:

- Fetches products from the Fake Store API.
- Displays products in a paginated collection view (7 products per page), but as the the fake store doesnot have any offset i have to call all product and then make paginated localy  
- Supports grid and list view modes with a toggle button.

### Skeleton Loading:

- Uses SkeletonView to show loading animations while fetching data.

### Offline Handling:

- Monitors network connectivity using NetworkMonitor (based on NWPathMonitor).
- Displays an alert when offline and automatically retries fetching on reconnection.

### Product Details:

- Navigates to a detailed view (ProductDetailsViewController) when a product is selected with required detils for this product.


### Error Handling:

- Handles API errors (e.g., no internet, invalid URL, decoding issues) with user-friendly alerts.


### Testing:

- Some Unit tests for DomainLayer (FetchProductsUseCase) ViewLayer (productListViewModel)

## Screenshots     

<img src="https://github.com/user-attachments/assets/4283edf1-b227-405a-a816-bdb63402c1f4" alt="Home Screen" width="180"/>
<img src="https://github.com/user-attachments/assets/3368072f-8270-4c70-9942-7138c5746ab0" alt="Home Screen" width="180"/>
<img src="https://github.com/user-attachments/assets/e2845f64-3139-4332-a4d9-120c68b0eaf6" alt="Home Screen" width="180"/>
<img src="https://github.com/user-attachments/assets/bd4b82ed-9094-4841-b00a-4494f1882801" alt="Home Screen" width="180"/>



## Architecture

The app follows Clean Architecture with MVVM to separate concerns and enhance testability:

### Domain Layer:

Contains business entities (Product) and use cases (FetchProductsUseCase).
Independent of frameworks and UI.

### Data Layer:

- Handles data fetching (NetworkService, RemoteProductDataSource, ProductRepository).
- Manages network connectivity (NetworkMonitor).
- Defines errors (NetworkError).

### Presentation Layer:

- Manages UI state (ProductListViewModel).
- Displays UI (ProductListViewController, ProductCell, ShadowImageView, ProductDetailsViewController).
- Uses Storyboard for UI layout.


## Requirements

- Xcode: 16.2
- Swift: 5.0
- Dependencies: SkeletonView (via Swift Package Manager)

## Setup Instructions

### Prerequisites

 - Install Xcode from the Mac App Store.
 - Ensure you have Git installed.

### Installation

- git clone https://github.com/Shekoovic100/ProductList
- Open the Project:
- Open ProductListApp.xcodeproj in Xcode.
- Build and Run:
Select a simulator (e.g., iPhone 14) or a physical device.
Press Cmd + R to build and run the app.


## Configuration

API: The app uses https://fakestoreapi.com/products. No API key is required.
Network: Ensure an internet connection for initial data fetching. 
Offline mode is supported with alerts.

## Testing

The app includes unit tests using XCTest.
