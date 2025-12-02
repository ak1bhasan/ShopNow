"""
Simple seed script for the application (no image generation).
"""

from app import create_app
from app.extensions import db
from app.models import User, Category, Product, Cart


def seed_database():
    app = create_app()

    with app.app_context():
        db.drop_all()
        db.create_all()

        admin = User(name="Admin User", email="admin@example.com", phone="1234567890", role="admin")
        admin.set_password("admin123")
        db.session.add(admin)

        user = User(name="Test User", email="user@example.com", phone="0987654321", role="user")
        user.set_password("user123")
        db.session.add(user)
        db.session.flush()

        user_cart = Cart(user_id=user.user_id)
        db.session.add(user_cart)

        categories_data = [
            {"name": "Electronics", "slug": "electronics"},
            {"name": "Clothing", "slug": "clothing"},
            {"name": "Books", "slug": "books"},
            {"name": "Home & Garden", "slug": "home-garden"},
            {"name": "Sports", "slug": "sports"},
        ]

        categories = {}
        for cat in categories_data:
            c = Category(**cat)
            db.session.add(c)
            db.session.flush()
            categories[cat["slug"]] = c

        products_data = [
              {"category_slug": "electronics", "name": "Smartphone", "description": "Latest smartphone.", "price": 599.99, "stock": 50, "image_url": "https://images.pexels.com/photos/1786433/pexels-photo-1786433.jpeg"},
              {"category_slug": "electronics", "name": "Laptop", "description": "High-performance laptop.", "price": 1299.99, "stock": 30, "image_url": "https://images.pexels.com/photos/7974/pexels-photo.jpg"},
              {"category_slug": "clothing", "name": "T-Shirt", "description": "Comfortable cotton t-shirt.", "price": 19.99, "stock": 100, "image_url": "https://images.pexels.com/photos/996329/pexels-photo-996329.jpeg"},
              {"category_slug": "clothing", "name": "Jeans", "description": "Classic blue jeans.", "price": 49.99, "stock": 75, "image_url": "https://images.pexels.com/photos/52518/jeans-pants-blue-shop-52518.jpeg"},
              {"category_slug": "books", "name": "Python Programming Book", "description": "Learn Python programming.", "price": 39.99, "stock": 25, "image_url": "https://images.pexels.com/photos/1181359/pexels-photo-1181359.jpeg"},
              {"category_slug": "books", "name": "Web Development Guide", "description": "Complete guide to web development.", "price": 45.99, "stock": 20, "image_url": "https://images.pexels.com/photos/4974922/pexels-photo-4974922.jpeg"},
              {"category_slug": "home-garden", "name": "Garden Tools Set", "description": "Complete gardening tools set.", "price": 79.99, "stock": 15, "image_url": "https://images.pexels.com/photos/20690251/pexels-photo-20690251.jpeg"},
              {"category_slug": "sports", "name": "Yoga Mat", "description": "Premium yoga mat.", "price": 29.99, "stock": 40, "image_url": "https://images.pexels.com/photos/4325462/pexels-photo-4325462.jpeg"},
        ]

        for p in products_data:
            cat = categories[p["category_slug"]]
            product = Product(
                category_id=cat.category_id,
                name=p["name"],
                description=p["description"],
                price=p["price"],
                stock=p["stock"],
                image_url=p.get("image_url")
            )
            db.session.add(product)

        db.session.commit()
        print("Database seeded successfully.")


if __name__ == "__main__":
    seed_database()
