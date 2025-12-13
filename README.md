# ShopNow

ShopNow is a server-rendered Flask e-commerce application backed by MySQL. It includes authentication, catalogue, cart, checkout, simulated payments, and an admin dashboard. MySQL (e.g., XAMPP) is the only supported database.

## Tech Stack
- Flask 2.1+ (app factory, blueprints)
- MySQL (SQLAlchemy ORM via PyMySQL)
- Flask-Login, Flask-WTF (CSRF), Flask-Migrate
- Jinja2 + Bootstrap 5
- Pillow (image handling)
- PyTest (smoke tests)

## Features
- Authentication: register, login, logout, profile edit, role-based access.
- Products: paginated catalogue, details, admin CRUD, JSON add endpoint with auto-category creation.
- Cart: persistent per-user cart, add/update/remove with stock checks.
- Orders: checkout, order history/detail, stock decrement, status tracking.
- Payments: simulated flow that marks payments/orders successful.
- Admin: dashboard stats (sales/users/orders), low-stock alerts, order status updates.
- Security: CSRF protection, upload validation, login gating.

## Screenshots

### Welcome Page
![Welcome Page](screenshots/welcomepage.png)

### Product Catalogue
![Product Catalogue](screenshots/products.png)

### Cart Page
![Cart Page](screenshots/carts.png)

### Orders / History
![Orders / History](screenshots/orders_management.png)

### Admin Dashboard
![Admin Dashboard](screenshots/admindashboard.png)

### Admin Add Product
![Admin Add Product](screenshots/addproducts.png)

## Project Layout
```
ShopNow/
├── app/
│   ├── __init__.py          # create_app + blueprint registration
│   ├── extensions.py        # db, migrate, login_manager, csrf
│   ├── models.py            # User, Category, Product, ProductImage, Cart, CartItem, Order, OrderItem, Payment
│   ├── utils.py             # admin/customer guards, image helpers
│   ├── blueprints/
│   │   ├── auth.py          # register/login/profile, admin login
│   │   ├── main.py          # home
│   │   ├── products.py      # catalogue + admin CRUD + JSON add
│   │   ├── cart.py          # cart flows
│   │   ├── orders.py        # checkout, payment, history
│   │   └── admin.py         # dashboard, order status updates
│   ├── forms/               # WTForms for auth/products/cart/orders
│   ├── templates/           # Jinja2 pages (auth, product, cart, order, admin)
│   └── static/              # css/js/uploads + default images
├── config.py                # Dev/Prod configs (requires DATABASE_URI)
├── manage.py                # Flask CLI commands
├── run.py                   # Entry point (python run.py)
├── seed.py                  # Drop/create DB and seed sample data
├── scripts/                 # DB/product maintenance helpers
├── sql/                     # schema + migration SQL helpers
├── tests/test_basic.py      # Basic smoke tests
└── README.md
```

## Quickstart (MySQL / XAMPP)
```bash
cd ShopNow
python -m venv venv && venv\Scripts\activate      # Windows
# python3 -m venv venv && source venv/bin/activate  # macOS/Linux
pip install -r requirements.txt
copy .env.example .env                            # or: cp .env.example .env

# Create MySQL database (adjust credentials as needed)
mysql -u root -p -e "CREATE DATABASE ecommerce CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# Initialize tables (choose one)
flask --app manage.py create-db                   # via Flask CLI
# or: mysql -u root -p ecommerce < sql/schema.sql

# Seed sample data (drops/recreates tables)
python seed.py

# Run the app
python run.py   # http://localhost:5000
```

### Windows helper (optional)
```
.\setup_db.ps1
```
Creates DB/user, imports schema, and writes `DATABASE_URI` to `.env` (review before running).

## Configuration (.env)
```
FLASK_ENV=development
SECRET_KEY=change-me
DATABASE_URI=mysql+pymysql://root:root@localhost:3306/ecommerce
UPLOAD_FOLDER=app/static/uploads
ALLOWED_IMAGE_EXTENSIONS=jpg,jpeg,png,webp
MAX_CONTENT_LENGTH=5242880
# Admin login (demo defaults)
ADMIN_USERNAME=admin123@gmail.com
ADMIN_PASSWORD=CSE_123
ADMIN_EMAIL=admin@example.com
```
- `DATABASE_URI` is required; use the MySQL URI format.
- Admin credentials above are demo/default; change for real deployments.

## Access & Flows
- Catalogue: `/` or `/products` (12 per page), details at `/product/<id>`.
- Cart: add from product pages; view/update at `/cart`.
- Checkout: `/checkout` creates `Order` + `OrderItem`s, decrements stock, creates `Payment`.
- Payment: `/payment/<order_id>` simulates payment and moves order to `Processing`.
- Orders: history at `/orders`, detail at `/orders/<id>`.
- Admin: `/admin/dashboard`, `/admin/products`, `/admin/orders`; status updates allowed.
- JSON add product: `POST /products/add` accepts name/price/stock_status/category/image_url and auto-creates categories.
- Image handling: uploads saved to `app/static/uploads`; allowed extensions from `.env`.

## CLI Utilities
```bash
flask --app manage.py create-db     # create tables
flask --app manage.py drop-db       # drop tables
flask --app manage.py seed-db       # run seed.py
flask --app manage.py add-products  # add sample products
flask --app manage.py update-images # refresh image URLs
```

## Testing
```bash
pytest tests/
```
Tests expect a MySQL `DATABASE_URI`; CSRF is disabled during tests.

## Troubleshooting
- `DATABASE_URI is not set`: ensure `.env` is present and loaded.
- MySQL connection issues: confirm server is running and credentials are correct; `pip install pymysql` if MySQLdb is missing.
- Upload issues: ensure `app/static/uploads` exists and is writable; verify allowed extensions.

## Production Notes
- Use a strong `SECRET_KEY`; set `FLASK_ENV=production`.
- Run behind a WSGI server (Gunicorn/uWSGI), enable HTTPS, and use durable storage for uploads.
- Rotate all demo/default credentials before any public deployment.

## Database Schema (ER Diagram)

![ShopNow ER Diagram](screenshots/ER-Diagram.png)

The ER diagram shows how core entities—users, products, categories, carts, orders, payments—are linked to power browsing, checkout, and fulfillment. It illustrates how user sessions connect to carts and orders, how products map to categories and cart items, and how payments tie back to completed orders. Use it as a quick reference when modifying data flows or extending the MySQL schema.

## License

This project is licensed under the MIT License.