"""
Inspect the MySQL database via SQLAlchemy (PyMySQL) and list sample rows.

Run from the project root `E-Commerce Platform` with DATABASE_URI set:

    python .\scripts\inspect_db.py
"""
import os

from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError

load_dotenv()


def get_uri():
    uri = os.environ.get("DATABASE_URI")
    if not uri:
        raise RuntimeError(
            "DATABASE_URI is not set. Export a MySQL URI before running this script "
            "(e.g. mysql+pymysql://user:password@localhost:3306/ecommerce)."
        )
    return uri


def inspect_db(uri: str):
    print(f"Using DATABASE_URI={uri}")
    engine = create_engine(uri, echo=False, pool_pre_ping=True)

    try:
        with engine.connect() as conn:
            product_count = conn.execute(text("SELECT COUNT(*) FROM products")).scalar_one()
            print(f"products count: {product_count}")

            print("\nSample products (id, name):")
            for row in conn.execute(text("SELECT product_id, name FROM products LIMIT 20")):
                print(row)

            print("\nSample product_images (image_id, product_id, filename, is_main):")
            for row in conn.execute(
                text(
                    "SELECT image_id, product_id, filename, is_main "
                    "FROM product_images LIMIT 50"
                )
            ):
                print(row)
    except SQLAlchemyError as exc:
        print("SQL error:", exc)


if __name__ == "__main__":
    inspect_db(get_uri())
