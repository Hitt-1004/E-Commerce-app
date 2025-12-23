# E-Commerce App

A Flutter-based e-commerce application that allows users to browse products, manage their shopping cart, and perform user authentication using MongoDB for data storage.

## Features

- **User Authentication**: Login and signup functionality with form validation
- **Product Catalog**: Display products with images, descriptions, and prices
- **Shopping Cart**: Add/remove items from cart with quantity management
- **Responsive Design**: Supports both light and dark themes
- **MongoDB Integration**: Backend database for user data and potentially product data
- **Custom Fonts**: Uses Google Fonts for enhanced UI

## Technologies Used

- **Flutter**: UI framework for building natively compiled applications
- **Dart**: Programming language used by Flutter
- **MongoDB**: NoSQL database for data storage
- **VelocityX**: Flutter extension for rapid UI development
- **Google Fonts**: Custom font integration
- **HTTP**: For network requests
- **Logger**: Logging utility for debugging

## Installation

1. **Prerequisites**:
   - Flutter SDK (version 2.17.6 or higher)
   - Dart SDK
   - MongoDB instance running locally or remotely

2. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd new_application
   ```

3. **Install dependencies**:
   ```bash
   flutter pub get
   ```

4. **Configure MongoDB**:
   - Update the MongoDB connection details in `lib/dbHelper/mongodb.dart`
   - Ensure MongoDB is running on your system

5. **Run the application**:
   ```bash
   flutter run
   ```

## Usage

1. **Launch the app**: The app starts with a login screen
2. **Sign Up**: Create a new account if you don't have one
3. **Login**: Enter your credentials to access the app
4. **Browse Products**: View the product catalog on the home page
5. **Add to Cart**: Tap on products to add them to your shopping cart
6. **View Cart**: Access the cart from the floating action button to see selected items

## Project Structure

- `lib/`: Main application code
  - `main.dart`: App entry point and theme configuration
  - `models/`: Data models for products, cart, etc.
  - `dbHelper/`: MongoDB connection and database operations
- `Assets/`: Images and static files
- `Assets/files/`: JSON data files (e.g., Catalog.json)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
