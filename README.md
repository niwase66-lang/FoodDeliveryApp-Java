# 🍔 FoodDeliveryApp-Java

A full-stack Java web application that simulates a real-world food delivery platform (inspired by Swiggy/Zomato).

---

## 🚀 Features

### 👤 User Module
- User registration & login
- Guest user access (skip login)
- Profile sidebar with user details
- Dark mode toggle
- Logout confirmation popup

### 🏪 Restaurant Module
- Browse restaurants with ratings & ETA
- Veg & Non-Veg restaurants
- Search by name/location
- Uniform image handling (fallback support)

### 🛒 Cart & Orders
- Add to cart with quantity control
- Checkout with address selection
- Order history & tracking

## 📸 Application Screenshots

### 🔐 Login Page
![Login](FoodDeliveryApp/FoodDeliverApp-Screenshots/login.png)

### 📝 Register Page
![Register](FoodDeliveryApp/FoodDeliverApp-Screenshots/register.png)

### 🏠 Home Page
![Home Page](FoodDeliveryApp/FoodDeliverApp-Screenshots/homepage.png)

### 🔎 Login from Home Page
![Login From Home](FoodDeliveryApp/FoodDeliverApp-Screenshots/login%20from%20home%20page.png)

### 🛒 Cart Page
![Cart](FoodDeliveryApp/FoodDeliverApp-Screenshots/cart.png)

### 📋 Menu Page
![Menu](FoodDeliveryApp/FoodDeliverApp-Screenshots/menu.png)

### ➕ Add Address
![Add Address](FoodDeliveryApp/FoodDeliverApp-Screenshots/add%20address.png)

### 🚚 Checkout (Login Required)
![Checkout Login](FoodDeliveryApp/FoodDeliverApp-Screenshots/checkout%20login.png)

### 📦 Checkout – Step 1
![Checkout 1](FoodDeliveryApp/FoodDeliverApp-Screenshots/checkout1.png)

### 📦 Checkout – Step 2
![Checkout 2](FoodDeliveryApp/FoodDeliverApp-Screenshots/checkout2.png)

### 📞 Contact Details
![Contact Details](FoodDeliveryApp/FoodDeliverApp-Screenshots/contact%20details.png)

### ✅ Order Confirmation
![Order Confirmation](FoodDeliveryApp/FoodDeliverApp-Screenshots/order%20confirmation%20msg.png)

### 📜 Order History
![Order History](FoodDeliveryApp/FoodDeliverApp-Screenshots/orderhistory.png)

### 📦 Order Item Details
![Order Item Details](FoodDeliveryApp/FoodDeliverApp-Screenshots/orderitem%20details.png)

### 👤 Profile Sidebar
![Profile Bar](FoodDeliveryApp/FoodDeliverApp-Screenshots/profilebar.png)

### 🚪 Logout Confirmation
![Logout Confirmation](FoodDeliveryApp/FoodDeliverApp-Screenshots/logout%20confirmation.png)

## 🏗 Project Architecture

- MVC Architecture
- JSP – View Layer
- Servlets – Controller Layer
- DAO & DAOImpl – Data Access Layer
- MySQL – Database
- JDBC – Database Connectivity


## 🗄 Database Design

### Tables
- users
- restaurants
- menu
- cart
- orders
- order_items
- all_address

## ▶ How to Run the Project

1. Clone the repository
2. Import into Eclipse as Dynamic Web Project
3. Configure Apache Tomcat 10+
4. Create MySQL database and tables
5. Update DB credentials in JDBC connection
6. Run on server

## 🛠 Tech Stack

- Java
- JSP & Servlets
- JDBC
- MySQL
- HTML5
- CSS3
- Apache Tomcat

## ⭐ Key Highlights

- Industry-style UI inspired by Swiggy/Zomato
- Guest user browsing without login
- Dynamic restaurant & menu rendering
- Responsive UI (mobile + desktop)
- Address management with multiple addresses
- Order history with item-level details


