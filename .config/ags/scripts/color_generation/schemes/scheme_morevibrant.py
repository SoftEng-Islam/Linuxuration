from materialyoucolor.scheme.dynamic_scheme import DynamicSchemeOptions, DynamicScheme
from materialyoucolor.scheme.variant import Variant
from materialyoucolor.palettes.tonal_palette import TonalPalette


class SchemeMoreVibrant(DynamicScheme):
    # Broadened hue rotations to maximize contrast across different tones
    hues = [0.0, 45.0, 70.0, 105.0, 135.0, 190.0, 255.0, 310.0, 360.0]
    secondary_rotations = [20.0, 17.0, 15.0, 13.0, 17.0, 20.0, 17.0, 13.0, 13.0]
    tertiary_rotations = [40.0, 35.0, 25.0, 30.0, 35.0, 40.0, 35.0, 30.0, 30.0]

    def __init__(self, source_color_hct, is_dark, contrast_level):
        super().__init__(
            DynamicSchemeOptions(
                source_color_argb=source_color_hct.to_int(),
                variant=Variant.VIBRANT,
                contrast_level=contrast_level,
                is_dark=is_dark,
                primary_palette=TonalPalette.from_hue_and_chroma(
                    source_color_hct.hue, 240.0  # Stronger primary color intensity
                ),
                secondary_palette=TonalPalette.from_hue_and_chroma(
                    DynamicScheme.get_rotated_hue(
                        source_color_hct,
                        SchemeMoreVibrant.hues,
                        SchemeMoreVibrant.secondary_rotations,
                    ),
                    50.0,  # Higher chroma for a distinct secondary palette
                ),
                tertiary_palette=TonalPalette.from_hue_and_chroma(
                    DynamicScheme.get_rotated_hue(
                        source_color_hct,
                        SchemeMoreVibrant.hues,
                        SchemeMoreVibrant.tertiary_rotations,
                    ),
                    55.0,  # Stronger tertiary contrast
                ),
                neutral_palette=TonalPalette.from_hue_and_chroma(
                    source_color_hct.hue,
                    25.0,  # Increased for more distinct neutral tones
                ),
                neutral_variant_palette=TonalPalette.from_hue_and_chroma(
                    source_color_hct.hue,
                    28.0,  # Higher variant chroma for stronger emphasis
                ),
            )
        )
