"""
Generate a simple default product image and save it to `app/static/uploads/default.jpg`.
Run with the project virtualenv active:

    python .\scripts\generate_default_image.py

This script uses Pillow to draw a neutral product-like placeholder. It avoids downloading
copyrighted images and gives you a consistent local default image.
"""
from PIL import Image, ImageDraw, ImageFont
import os

def make_default(path):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    w, h = 800, 600
    bg = (245, 245, 245)
    fg = (100, 115, 130)

    img = Image.new("RGB", (w, h), color=bg)
    draw = ImageDraw.Draw(img)

    # draw a simple product mockup (mat/device rectangle + shadow)
    box_w, box_h = int(w * 0.8), int(h * 0.6)
    bx = (w - box_w) // 2
    by = (h - box_h) // 2
    draw.rectangle([bx + 10, by + 10, bx + box_w + 10, by + box_h + 10], fill=(230,230,230))
    draw.rectangle([bx, by, bx + box_w, by + box_h], fill=(255,255,255), outline=(220,220,220))

    # draw some decorative lines
    draw.line([bx + 30, by + 40, bx + box_w - 30, by + 40], fill=fg, width=3)
    draw.line([bx + 30, by + 100, bx + box_w - 30, by + 100], fill=(200,200,200), width=2)

    # product label text
    try:
        font = ImageFont.truetype("arial.ttf", 36)
    except Exception:
        font = ImageFont.load_default()

    text = "Default Product"
    tw, th = draw.textsize(text, font=font)
    draw.text(((w - tw) / 2, by + box_h - th - 30), text, fill=fg, font=font)

    img.save(path, format="JPEG", quality=85)

if __name__ == "__main__":
    target = os.path.join(os.path.dirname(os.path.dirname(__file__)), "app", "static", "uploads", "default.jpg")
    print("Generating default image to:", target)
    make_default(target)
    print("Done. You can now start the app and the default image will be used for products without images.")