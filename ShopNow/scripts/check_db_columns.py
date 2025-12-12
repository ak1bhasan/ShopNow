"""
Diagnostic: check database URI and whether products.image_url column exists.
Run with the project's venv active.
"""
import os
from sqlalchemy import create_engine, inspect

db_uri = os.environ.get("DATABASE_URI")
if not db_uri:
    raise RuntimeError(
        "DATABASE_URI is not set. Set it to a MySQL URI before running this script."
    )
print("Using DB URI:", db_uri)

engine = create_engine(db_uri)
inspector = inspect(engine)

print("Tables:", inspector.get_table_names())
if "products" in inspector.get_table_names():
    cols = [c["name"] for c in inspector.get_columns("products")]
    print("products columns:", cols)
else:
    print("products table not found")
