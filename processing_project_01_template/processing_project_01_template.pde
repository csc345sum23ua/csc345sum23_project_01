/*
Author: Md Moyeen Uddin
moyeen@arizona.edu
*/

// Global variables (fixed)
int WINDOW_SIDE_LEN = 1024;
//
// int DRAW_DELAY_AMOUNT = 0; //0s
int DRAW_DELAY_AMOUNT = 100; //100ms
// int DRAW_DELAY_AMOUNT = 1000; //1s
//
float EPS = 0.07; // [note] change if needed
int CUSTOM_SCALE_FACTOR = 3 * 10;
//float CUSTOM_SCALE_FACTOR_PERCENTAGE = 10.0;


// Global variables loaded from input file
int h = -1;
int grid_side_length = -1;

ArrayList<String> queryStringsList = new ArrayList<String>();

// global variables
PrintWriter output;

//
ArrayList<HorizontalLineSegment> inputHLSList = new ArrayList<HorizontalLineSegment>();
//
ArrayList<Rectangle> currentRectList = new ArrayList();
Set<Integer> currentLineIdsSet = new HashSet();

// runtime temp variables
Rectangle queryRectangle = null;
// eg: for 'r' and 'c' type query
// String currentStatusBarText = DEFAULT_STATUS_BAR_TEXT;
String currentStatusBarTextLine1 = DEFAULT_STATUS_BAR_TEXT_LINE_1;
String currentStatusBarTextLine2 = DEFAULT_STATUS_BAR_TEXT_LINE_2;

// animation mode
boolean isDrawnTempCircleOnMouseClickPosition = false;
int savedMouseX, savedMouseY;
HorizontalLineSegment hlsFromMouseClick = null;

void settings() {
    //fullScreen();
    size(WINDOW_SIDE_LEN, WINDOW_SIDE_LEN);
    
    customInitialization();
}

void customInitialization() {
    FLAG_IS_INPUT_FILE_LOADED = false;
}

void finputFileSelected(File selection) {
    if (selection == null) {
        println("Window was closed or the user hit cancel.");
    } else {
        println("User selected " + selection.getAbsolutePath());
        
        // FLAG_IS_INPUT_FILE_LOADED = true;       
    }
    // task: read the input file
    // task: read FULL file line by line and save the queries for offline processing
    readInputFile(selection);
    FLAG_IS_INPUT_FILE_LOADED = true;
    fsetup();
}

void fsetup() {
    // task: create a new output log file in the sketch directory
    output = createWriter("output.txt");
    // output.println("test output");
    
    
    // task: build qaud tree
    

    
    
    // task: process the queries from input file
    processQueries();
}

void setup() {
    // task: choose an input file
    selectInput("Select an input file to process:", "finputFileSelected");
}

void draw() {
    if (!FLAG_IS_INPUT_FILE_LOADED) {
        return;
    }
    customDraw();
    output.flush();
}

void customDraw() {
    //
    background(255, 255, 255);
    
    // task: draw the status bar
    drawStatusBar();
    
    // task: drawing the 2^h x 2^h grid
    draw2dGrid();
    
    // task: clear color of ALL inserted lines
    // to be able to re-color them as needed
    // clearLineColors();
    
    
    // task: draw and color all the hls ever inserted
    drawHLSs();
    
    // task: draw query rectangle if any
    drawCurrentQueryRectangle();

    
    //
    if(mousePressed)
        ellipse(
            mouseX,
            mouseY,
            s(CUSTOM_DIAMATER_OF_CIRLCE_DRAWN_AROUND_MOUSE_CLICK),
            s(CUSTOM_DIAMATER_OF_CIRLCE_DRAWN_AROUND_MOUSE_CLICK)
        );
    
    
    delay(DRAW_DELAY_AMOUNT);
    output.flush();
}

void drawStatusBar() {
    textAlign(LEFT, BOTTOM);
    text(
        currentStatusBarTextLine1 + ", " + currentStatusBarTextLine2,
        s(0),
        s(grid_side_length)
    );
}

void clearLineColors() {
    for (HorizontalLineSegment hls : inputHLSList) {
        hls.setRgbColor(lineDefaultRgbColor);
    }
}

void draw2dGrid() {
    stroke(0); // black
    strokeWeight(s(CUSTOM_GRID_THICKNESS));
    
    for (int row = 0; row < grid_side_length; row++) {
        line(s(0), s(row), s(grid_side_length - 1), s(row));
    }
    for (int col = 0; col < grid_side_length; col++) {
        line(s(col), s(0), s(col), s(grid_side_length - 1));
    }
}

void drawRectangle(Rectangle rt) {
    // task: picking a random color for this rect drawing
    float r = random(256);
    float g = random(256);
    float b = random(256);
    
    // strokeWeight(s(CUSTOM_RECTANGLE_THICKNESS)); // thickness
    stroke(r, g, b);
    
    
    // task: draw 4 lines to represent the rectangle
    // bottom
    line(
        s(rt.getBottomLeftPoint().getX() + EPS), s(rt.getBottomLeftPoint().getY() - EPS),  
        s(rt.getTopRightPoint().getX() - EPS), s(rt.getBottomLeftPoint().getY() - EPS)
       );
    // right
    line(
        s(rt.getTopRightPoint().getX() - EPS), s(rt.getBottomLeftPoint().getY() - EPS),
        s(rt.getTopRightPoint().getX() - EPS), s(rt.getTopRightPoint().getY() + EPS)
       );
    // top
    line(
        s(rt.getTopRightPoint().getX() - EPS), s(rt.getTopRightPoint().getY() + EPS),
        s(rt.getBottomLeftPoint().getX() + EPS), s(rt.getTopRightPoint().getY() + EPS)
       );
    // left
    line(
        s(rt.getBottomLeftPoint().getX() + EPS), s(rt.getTopRightPoint().getY() + EPS),
        s(rt.getBottomLeftPoint().getX() + EPS), s(rt.getBottomLeftPoint().getY() - EPS)
       );
}

void drawCurrentQueryRectangle() {
    strokeWeight(s(CUSTOM_QUERY_RECTANGLE_THICKNESS));
    drawRectangle(queryRectangle);
    // also, marking it as Q
    text(
        "Q",
        s(queryRectangle.getBottomLeftPoint().getX() + EPS),
        s(queryRectangle.getBottomLeftPoint().getY() - EPS)
       );
}

void drawHLSs() {
    strokeWeight(s(CUSTOM_LINE_THICKNESS));
    
    // for (Integer lineId: currentLineIdsSet) {
    for (HorizontalLineSegment hls : inputHLSList) {
        // HorizontalLineSegment hls = inputHLSList.get(lineId);
        if (hls == null) {
            println("hls == null");
            exit();
        } else {
            // println(hls.toString());
        }
        
        // println("" + hls.getLineId());
        
        // task: get the assigned color for this HLS drawing
        RgbColor rgbColor = hls.getRgbColor();
        float r = rgbColor.getR();
        float g = rgbColor.getG();
        float b = rgbColor.getB();
        stroke(r, g, b);
        
        
        // task: draw 1 line
        line(
            s(hls.getLeftEndPoint().getX()), s(hls.getLeftEndPoint().getY()),  
            s(hls.getRightEndPoint().getX()), s(hls.getRightEndPoint().getY())
           );
        
        // task: draw/write the line id beside the line (eg: "s1")
        textSize(s(CUSTOM_DEFAULT_TEXT_SIZE));
        // text color
        fill(lineIdTextRgbColor.getR(), lineIdTextRgbColor.getG(), lineIdTextRgbColor.getB()); // brown
        text(
            "s" + hls.getLineId(),
            s(hls.getLeftEndPoint().getX()),
            s(hls.getLeftEndPoint().getY())
           );
    }
}

void readInputFile(File file) {
    String filePath = "./input.txt"; // default
    if (file != null) {
        // println("file.getAbsolutePath(): " + file.getAbsolutePath());
        // exit();
        
        // task: read the selected input file
        filePath = file.getAbsolutePath();
        
    }
    println("filePath: " + filePath);
    
    // task: reading the default input file
    String[] lines = loadStrings(filePath);
    // println("there are " + lines.length + " lines");
    for (int i = 0; i < lines.length; i++) {
        // println(lines[i]);
        String str = lines[i];
        
        queryStringsList.add(str);
        
        if (i == 0) {
            h = int(str);
            grid_side_length = int(pow(2.0, h * 1.0));
            
            // println("h: " + str(h));
            // println("grid_side_length: " + str(grid_side_length));
            continue;
        }
    }
}

//
float s(float x) {
    return x * CUSTOM_SCALE_FACTOR;
}
int sr(int x) {
    // s() reversed
    return (int) (x / CUSTOM_SCALE_FACTOR);
}

void processQueries() {
    
    int lineId = 0;
    for (int qid = 0; qid < queryStringsList.size(); qid++) {
        String str = queryStringsList.get(qid);
        
        // process the query
        if (str.charAt(0) == '%') {
            // output.println("comment");
            // task: print the string in log file
            // output.println("q: " + str);
            output.println(str);
            continue;
        }
        
        if (str.charAt(0) == 'i') {
            // output.println("q: " + str);
            
            str = str.substring(2);
            
            int[] nums = int(split(str, ' '));
            int x1 = nums[0];
            int x2 = nums[1];
            int y = nums[2];
            
            HorizontalLineSegment hls = new HorizontalLineSegment(
                inputHLSList.size(),
                new Point(x1, y),
                new Point(x2, y)
               );
            
            inputHLSList.add(hls);
            
            
            
            
            lineId += 1;
            
            continue;
        }
        
        if (str.charAt(0) == 'r') {
            // output.println("q: " + str);
            
            str = str.substring(2);
            
            int[] nums = int(split(str, ' '));
            int x1 = nums[0];
            int y1 = nums[1];
            int x2 = nums[2];
            int y2 = nums[3];
            
            queryRectangle = new Rectangle(
                new Point(x1, y1),
                new Point(x2, y2)
               );
            
            // String outputString = "RangeReporting was called with parameters x1, y1, x2, y"
            String outputString = "RangeReporting was called with parameters " + x1 + " " + y1 + " " + x2 + " " + y2;
            output.println(outputString);
            
            
            continue;
        }
        if (str.charAt(0) == 'c') {
            // output.println("q: " + str);
            
            str = str.substring(2);
            
            int[] nums = int(split(str, ' '));
            int x1 = nums[0];
            int y1 = nums[1];
            int x2 = nums[2];
            int y2 = nums[3];
            
            Rectangle qRect = new Rectangle(
                new Point(x1, y1),
                new Point(x2, y2)
               );
            
            String outputString = "RangeCouting was called with parameters " + x1 + " " + y1 + " " + x2 + " " + y2;
            output.println(outputString);
            
            
            continue;
        }
    }
}

String changeModeString(String str, char mode) {
    StringBuilder sb = new StringBuilder(str);
    sb.setCharAt(str.length()-1, mode);
    str = sb.toString();
    return str;
}
void keyPressed() {
    println("Key Pressed: " + key);
    //
    if (key == 'a') {
        // println("Key Pressed: " + "a");
        CUR_ANIMATION_MODE = 1-CUR_ANIMATION_MODE;
        if (CUR_ANIMATION_MODE == 1) {
            currentStatusBarTextLine1 = ANIMATION_MODE_ON_TEXT;
        } else {
            currentStatusBarTextLine1 = ANIMATION_MODE_OFF_TEXT;
        }
    } else if (key == 'i') {
        CUR_INPUT_MODE = 'i';
        currentStatusBarTextLine2 = changeModeString(currentStatusBarTextLine2, 'i');
    } else if (key == 'r') {
        CUR_INPUT_MODE = 'r';
        currentStatusBarTextLine2 = changeModeString(currentStatusBarTextLine2, 'r');
    } else if (key == 'c') {
        CUR_INPUT_MODE = 'c';
        currentStatusBarTextLine2 = changeModeString(currentStatusBarTextLine2, 'c');
    }
    println("CUR_INPUT_MODE: " + CUR_INPUT_MODE);
}

void drawTempCircleOnMouseClickPosition() {
    if(!isDrawnTempCircleOnMouseClickPosition) {

    } else {
        isDrawnTempCircleOnMouseClickPosition = true;
    }
}

// void mouseClicked() {
void mousePressed() {
    println("f(): mousePressed(): " + "CUR_INPUT_MODE: " + CUR_INPUT_MODE);
    println("mouseX: " + mouseX + ", mouseY: " + mouseY);
    println("sr(mouseX): " + sr(mouseX) + ", sr(mouseY): " + sr(mouseY));
    // println("\n\n");
    if(CUR_INPUT_MODE == 'i') {
        // task: saving data to draw a small circle around this mouse click location
        isDrawnTempCircleOnMouseClickPosition = false;
        savedMouseX = (int) sr(mouseX);
        savedMouseY = (int) sr(mouseY);


        // task: insert the point (ie: a degenerate line) in qt
        HorizontalLineSegment hls = new HorizontalLineSegment(
                inputHLSList.size(),
                new Point(savedMouseX, savedMouseY),
                new Point(savedMouseX, savedMouseY)
        );
            
        inputHLSList.add(hls);
        println("inputHLSList.size(): " + inputHLSList.size());
        
    } else {

    }
}
