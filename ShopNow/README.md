# ShopNow – Flask E-Commerce Platform

Server-rendered Flask shop with MySQL, session auth, shopping cart, checkout, and an admin dashboard.

## Tech Stack
- Flask 2.1+ (app factory + blueprints)
- MySQL (SQLAlchemy ORM, PyMySQL driver)
- Flask-Login, Flask-WTF (CSRF), Flask-Migrate
- Jinja2 + Bootstrap 5 templates
- Pillow for image handling
- PyTest for basic integration checks

## What’s Implemented
- Auth: register/login/logout, profile edits, hashed passwords, role-based gates.
- Products: paginated catalogue, product detail pages, basic admin CRUD, JSON endpoint to add products with auto-category creation.
- Cart: persistent carts per user, add/update/remove with stock checks and totals.
- Orders: checkout from cart, order detail/history, stock decrement, status tracking.
- Payments: simulated payment flow that marks payments/orders as successful.
- Admin: dashboard stats (sales/users/orders), low-stock alerts, order status updates.
- Security: CSRF on forms, upload validation, login-required flows.

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
│   │   ├── main.py          # /home
│   │   ├── products.py      # catalogue + admin CRUD + JSON add
│   │   ├── cart.py          # cart flows
│   │   ├── orders.py        # checkout, payment, history
│   │   └── admin.py         # dashboard, order status updates
│   ├── forms/               # WTForms for auth/products/cart/orders
│   ├── templates/           # Jinja2 pages (auth, product, cart, order, admin)
│   └── static/              # css/js/uploads + default images
├── config.py                # Dev/Prod configs (requires DATABASE_URI)
├── manage.py                # Flask CLI commands (create/drop/seed DB, add/update products)
├── run.py                   # Entry point (python run.py)
├── seed.py                  # Drop/create DB and seed sample data
├── scripts/                 # Helper scripts for DB/product maintenance
├── sql/                     # schema + migration SQL helpers
├── tests/test_basic.py      # Basic smoke tests
└── README.md
```

## Prerequisites
- Python 3.10+
- MySQL running locally
- PowerShell (Windows) or bash shell

## Quickstart
```bash
cd ShopNow
python -m venv venv && venv\Scripts\activate      # Windows
# python3 -m venv venv && source venv/bin/activate  # macOS/Linux
pip install -r requirements.txt
copy .env.example .env                            # or: cp .env.example .env
# Edit .env with your MySQL creds (see below)

# Create the database (name is up to you)
mysql -u root -p -e "CREATE DATABASE ecommerce CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# Initialize tables (choose one)
flask --app manage.py create-db                   # via CLI helpers
# or: mysql -u root -p ecommerce < sql/schema.sql

# Seed sample data (drops/recreates tables)
python seed.py

# Run the app
python run.py   # http://localhost:5000
```

### Optional Windows helper
```
.\setup_db.ps1
```
This creates the DB/user, imports the schema, and writes `DATABASE_URI` to `.env` (review the script before running).

## Environment (.env example)
```
FLASK_ENV=development
SECRET_KEY=change-me
DATABASE_URI=mysql+pymysql://root:root@localhost:3306/ecommerce
UPLOAD_FOLDER=app/static/uploads
ALLOWED_IMAGE_EXTENSIONS=jpg,jpeg,png,webp
MAX_CONTENT_LENGTH=5242880
# Admin login (optional overrides; defaults shown)
ADMIN_USERNAME=admin123@gmail.com
ADMIN_PASSWORD=CSE_123
ADMIN_EMAIL=admin@example.com
```
- `DATABASE_URI` is required; the app will error if it’s missing.
- Use `mysql+pymysql://user:pass@host:port/dbname`.

## Seeded Data & Logins
- Customer (seed): `user@example.com` / `user123`
- Admin email (seed): `admin@example.com` / `admin123`
- Admin login page (`/admin/login`) uses username/password from env:
  - `ADMIN_USERNAME` / `ADMIN_PASSWORD` (defaults shown above)
  - First admin login creates/updates the `ADMIN_EMAIL` user with that password.

## Core Flows
- Catalogue: `/` or `/products` (12 items per page), detail at `/product/<id>`.
- Cart: add from product pages, view/update at `/cart`.
- Checkout: `/checkout` → creates `Order`, `OrderItem` rows, decrements stock, creates `Payment`.
- Payment: `/payment/<order_id>` simulates success and moves order to `Processing`.
- Order history/detail: `/orders`, `/orders/<id>`.
- Admin: `/admin/dashboard`, `/admin/products`, `/admin/orders`; can update order status (Pending/Processing/Shipped/Delivered/Cancelled).
- JSON add product: `POST /products/add` accepts name/price/stock_status/category/image_url and auto-creates categories.

## Image Handling
- Uploads saved to `app/static/uploads` (Pillow thumbnail support via `utils.save_product_image`).
- Allowed extensions are driven by `ALLOWED_IMAGE_EXTENSIONS` in `.env`.

## CLI Utilities (Flask)
```bash
flask --app manage.py create-db     # create tables
flask --app manage.py drop-db       # drop tables
flask --app manage.py seed-db       # run seed.py
flask --app manage.py add-products  # add extra sample products
flask --app manage.py update-images # refresh image URLs
```

## Testing
```bash
pytest tests/
```
Tests expect `DATABASE_URI` to point to a MySQL instance; they will skip if it’s missing. CSRF is disabled in tests.

## Troubleshooting
- `DATABASE_URI is not set`: ensure `.env` is loaded (use `python -m dotenv.main set` or activate venv).
- MySQL connection issues: verify server is running and credentials match; try `pip install pymysql` if MySQLdb is missing.
- Upload errors: ensure `app/static/uploads` exists and is writable; confirm file extensions.

## Production Notes
- Set a strong `SECRET_KEY` and switch to `FLASK_ENV=production`.
- Run behind a WSGI server (Gunicorn/uWSGI), enable HTTPS, and move uploads to durable storage if needed.
- Change all default credentials before exposing the app.
