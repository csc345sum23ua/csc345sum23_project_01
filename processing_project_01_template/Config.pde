/*
Author: Md Moyeen Uddin
moyeen@arizona.edu
*/

//
// DEFAULT_COLOR_FOR_INTERSECTING_LINES
RgbColor brownRgbColor = new RgbColor(150, 75, 16);

RgbColor lineDefaultRgbColor = 
    // new RgbColor(220, 220, 220); // grey
    brownRgbColor; // grey
RgbColor intersectingLineRgbColor = new RgbColor(255, 000, 000);
RgbColor enclosingLineRgbColor = new RgbColor(000, 255, 000);
RgbColor lineIdTextRgbColor = brownRgbColor;

float CUSTOM_GRID_THICKNESS       = 0.03;
float CUSTOM_LINE_THICKNESS       = 0.6;
float CUSTOM_QUAD_RECTANGLE_THICKNESS  = 0.1;
float CUSTOM_QUERY_RECTANGLE_THICKNESS  = 0.2;
float CUSTOM_DEFAULT_TEXT_SIZE  = 0.8;
float CUSTOM_DIAMATER_OF_CIRLCE_DRAWN_AROUND_MOUSE_CLICK = 1;

// flags
boolean FLAG_IS_INPUT_FILE_LOADED = false;

// some default values
static String DEFAULT_STATUS_BAR_TEXT_LINE_1 = "Animation Mode: OFF";
String ANIMATION_MODE_ON_TEXT = "Animation Mode: ON";
String ANIMATION_MODE_OFF_TEXT = "Animation Mode: OFF";
static String DEFAULT_STATUS_BAR_TEXT_LINE_2 = "Input Mode: u";