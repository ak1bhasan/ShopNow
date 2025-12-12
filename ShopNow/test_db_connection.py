import os

from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError

load_dotenv()


def main():
    uri = os.environ.get("DATABASE_URI")
    if not uri:
        raise RuntimeError(
            "DATABASE_URI is not set. Export a MySQL URI before running this test "
            "(e.g. mysql+pymysql://user:password@localhost:3306/ecommerce)."
        )

    print(f"Using DATABASE_URI={uri!r}")
    engine = create_engine(uri, echo=False, pool_pre_ping=True)

    try:
        with engine.connect() as conn:
            result = conn.execute(text("SELECT 1")).scalar_one()
            print("Connection OK, SELECT 1 returned:", result)
    except SQLAlchemyError as exc:
        print("\n[ERROR] Could not connect to MySQL via SQLAlchemy.\n")
        print(exc)
        print(
            "\nCheck that:\n"
            "- MySQL is running on the configured host/port\n"
            "- The username/password in DATABASE_URI are correct\n"
            "- The target database exists (or update the name in DATABASE_URI)\n"
        )


if __name__ == "__main__":
    main()
