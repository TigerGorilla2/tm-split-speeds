namespace SplitSpeeds {
    bool get_visible() {
        return GUI::visible;
    }
    bool get_hasDifference() {
        return GUI::hasDiff;
    }

    float get_speed() {
        return GUI::currentSpeed;
    }
    float get_difference() {
        return GUI::difference;
    }
    string get_textDifference() {
        return GUI::text;
    }

    vec4 get_slowerColour() {
        return slowerColour;
    }
    vec4 get_fasterColour() {
        return fasterColour;
    }
    vec4 get_sameSpeedColour() {
        return GUI::sameSpeedColour;
    }
}