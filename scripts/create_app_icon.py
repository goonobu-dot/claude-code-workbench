#!/usr/bin/env python3
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont, ImageFilter


ROOT = Path(__file__).resolve().parents[1]
ASSET_DIR = ROOT / "Assets"
ICONSET_DIR = ASSET_DIR / "ClaudeCode9Panes.iconset"
PNG_PATH = ASSET_DIR / "ClaudeCode9Panes.png"


def font(size: int, bold: bool = False) -> ImageFont.FreeTypeFont:
    candidates = [
        "/System/Library/Fonts/Supplemental/Menlo.ttc",
        "/System/Library/Fonts/Supplemental/Arial Bold.ttf" if bold else "/System/Library/Fonts/Supplemental/Arial.ttf",
        "/System/Library/Fonts/SFNS.ttf",
    ]
    for candidate in candidates:
        try:
            return ImageFont.truetype(candidate, size=size, index=1 if bold and candidate.endswith(".ttc") else 0)
        except Exception:
            continue
    return ImageFont.load_default()


def rounded_rectangle_mask(size: int, radius: int) -> Image.Image:
    mask = Image.new("L", (size, size), 0)
    draw = ImageDraw.Draw(mask)
    draw.rounded_rectangle((0, 0, size - 1, size - 1), radius=radius, fill=255)
    return mask


def draw_sparkle(draw: ImageDraw.ImageDraw, cx: int, cy: int, radius: int, fill: tuple[int, int, int, int]) -> None:
    draw.polygon(
        [
            (cx, cy - radius),
            (cx + radius // 4, cy - radius // 4),
            (cx + radius, cy),
            (cx + radius // 4, cy + radius // 4),
            (cx, cy + radius),
            (cx - radius // 4, cy + radius // 4),
            (cx - radius, cy),
            (cx - radius // 4, cy - radius // 4),
        ],
        fill=fill,
    )


def draw_icon(size: int = 1024) -> Image.Image:
    scale = size / 1024
    image = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    base = Image.new("RGBA", (size, size), (21, 24, 44, 255))
    draw = ImageDraw.Draw(base)

    for y in range(size):
        t = y / size
        color = (
            int(22 + 38 * t),
            int(28 + 42 * t),
            int(58 + 54 * t),
            255,
        )
        draw.line((0, y, size, y), fill=color)

    # Soft candy glows so the Dock icon feels friendly rather than utilitarian.
    glow = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    glow_draw = ImageDraw.Draw(glow)
    glow_draw.ellipse(
        (int(-220 * scale), int(-180 * scale), int(720 * scale), int(690 * scale)),
        fill=(88, 235, 218, 82),
    )
    glow_draw.ellipse(
        (int(340 * scale), int(250 * scale), int(1220 * scale), int(1150 * scale)),
        fill=(255, 158, 204, 74),
    )
    glow_draw.ellipse(
        (int(120 * scale), int(580 * scale), int(780 * scale), int(1160 * scale)),
        fill=(252, 224, 120, 42),
    )
    base = Image.alpha_composite(base, glow.filter(ImageFilter.GaussianBlur(int(54 * scale))))
    draw = ImageDraw.Draw(base)

    for cx, cy, radius in [
        (155, 142, 22),
        (850, 126, 18),
        (116, 770, 16),
        (910, 510, 14),
        (510, 94, 12),
    ]:
        draw_sparkle(
            draw,
            int(cx * scale),
            int(cy * scale),
            int(radius * scale),
            (255, 246, 184, 180),
        )

    margin = int(96 * scale)
    gap = int(24 * scale)
    grid_top = int(150 * scale)
    tile_w = int((size - 2 * margin - 2 * gap) / 3)
    tile_h = int(122 * scale)

    for row in range(3):
        for col in range(3):
            x = margin + col * (tile_w + gap)
            y = grid_top + row * (tile_h + gap)
            rect = (x, y, x + tile_w, y + tile_h)
            shadow = (x, y + int(8 * scale), x + tile_w, y + tile_h + int(8 * scale))
            draw.rounded_rectangle(shadow, radius=int(28 * scale), fill=(6, 9, 24, 92))
            draw.rounded_rectangle(rect, radius=int(28 * scale), fill=(250, 253, 255, 238), outline=(119, 244, 226, 210), width=max(2, int(4 * scale)))
            draw.rounded_rectangle((x, y, x + tile_w, y + int(34 * scale)), radius=int(28 * scale), fill=(134, 238, 224, 230))
            dot_y = y + int(17 * scale)
            for dot in range(3):
                dot_x = x + int(22 * scale) + dot * int(20 * scale)
                draw.ellipse((dot_x - 5 * scale, dot_y - 5 * scale, dot_x + 5 * scale, dot_y + 5 * scale), fill=(255, 153, 198, 235))
            prompt_y = y + int(56 * scale)
            draw.text((x + int(22 * scale), prompt_y), ">", font=font(int(30 * scale), bold=True), fill=(42, 73, 103, 245))
            draw.line((x + int(62 * scale), prompt_y + int(18 * scale), x + tile_w - int(26 * scale), prompt_y + int(18 * scale)), fill=(105, 135, 174, 160), width=max(2, int(4 * scale)))

    badge_rect = (int(584 * scale), int(592 * scale), int(944 * scale), int(928 * scale))
    draw.rounded_rectangle((badge_rect[0], badge_rect[1] + int(12 * scale), badge_rect[2], badge_rect[3] + int(12 * scale)), radius=int(88 * scale), fill=(8, 13, 28, 95))
    draw.rounded_rectangle(badge_rect, radius=int(88 * scale), fill=(255, 244, 251, 250), outline=(255, 183, 214, 255), width=max(4, int(8 * scale)))
    number_font = font(int(174 * scale), bold=True)
    label_font = font(int(34 * scale), bold=True)
    draw.text((int(680 * scale), int(590 * scale)), "9", font=number_font, fill=(46, 49, 86, 255))
    draw.text((int(642 * scale), int(792 * scale)), "KAWAII 9", font=label_font, fill=(214, 83, 142, 255))

    mask = rounded_rectangle_mask(size, int(210 * scale))
    image.paste(base, (0, 0), mask)

    shine = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    shine_draw = ImageDraw.Draw(shine)
    shine_draw.arc((int(80 * scale), int(60 * scale), int(940 * scale), int(940 * scale)), 204, 292, fill=(255, 255, 255, 44), width=max(2, int(10 * scale)))
    image = Image.alpha_composite(image, shine)
    return image


def save_iconset(source: Image.Image) -> None:
    ICONSET_DIR.mkdir(parents=True, exist_ok=True)
    sizes = [16, 32, 64, 128, 256, 512, 1024]
    for output_size in sizes:
        resized = source.resize((output_size, output_size), Image.Resampling.LANCZOS)
        if output_size == 64:
            resized.save(ICONSET_DIR / "icon_32x32@2x.png")
        elif output_size == 1024:
            resized.save(ICONSET_DIR / "icon_512x512@2x.png")
        else:
            point_size = output_size if output_size <= 512 else 512
            resized.save(ICONSET_DIR / f"icon_{point_size}x{point_size}.png")

    source.resize((32, 32), Image.Resampling.LANCZOS).save(ICONSET_DIR / "icon_16x16@2x.png")
    source.resize((256, 256), Image.Resampling.LANCZOS).save(ICONSET_DIR / "icon_128x128@2x.png")
    source.resize((512, 512), Image.Resampling.LANCZOS).save(ICONSET_DIR / "icon_256x256@2x.png")


def main() -> None:
    ASSET_DIR.mkdir(parents=True, exist_ok=True)
    icon = draw_icon()
    icon.save(PNG_PATH)
    save_iconset(icon)
    print(PNG_PATH)


if __name__ == "__main__":
    main()
