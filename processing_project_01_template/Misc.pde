/*
Author: Md Moyeen Uddin
moyeen@arizona.edu
*/

class RgbColor {
    private int r;
    private int g;
    private int b;

    RgbColor() {
        // default CLEAR.WHITE color of lines
        this.r = 255;
        this.g = 255;
        this.b = 255;
    }
    
    RgbColor(int r, int g, int b) {
        this.r = r;
        this.g = g;
        this.b = b;
    }

    //
    int getR() {
        return this.r;
    }
    int getG() {
        return this.g;
    }
    int getB() {
        return this.b;
    }
}


//
static int CUR_ANIMATION_MODE = 0; // 0: off, 1: on
static char CUR_INPUT_MODE = 'u'; // i, r, c // 'u' unknown

// int MOUSE_CLICK_COUNT_IN_MODE_i  = 0;