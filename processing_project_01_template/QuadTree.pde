/*
Author: Md Moyeen Uddin
moyeen@arizona.edu
*/

import java.util.*;

// [constants]
// number of children fixed: 4
int NUMBER_OF_CHILDREN_FOR_EACH_NODE = 4;
int MAX_NUMBER_OF_LINE_SEGMENT_ON_EACH_NODE = 3;
String DEBUG_MSG_PRFX = "DEBUG_MSG: ";
void debug_print(String debug_msg) {
    println(DEBUG_MSG_PRFX + debug_msg);
}
//


class Rectangle {
    // note: only these 2 data are passed from outside during construction
    private Point bottomLeftPoint; // 0
    private Point topRightPoint; // 2

    // the below vars are later computed and assigned accordingly
    //
    private int minX;
    private int maxX;
    private int minY;
    private int maxY;
    //
    private Point bottomRightPoint; // 1
    private Point topLeftPoint; // 3

    Rectangle(Point bottomLeftPoint, Point topRightPoint) {
        this.bottomLeftPoint = bottomLeftPoint;
        this.topRightPoint = topRightPoint;
        //
        this.minX = this.bottomLeftPoint.getX();
        this.maxX = this.topRightPoint.getX();
        this.minY = this.topRightPoint.getY();
        this.maxY = this.bottomLeftPoint.getY();
        //
        this.bottomRightPoint = new Point(this.maxX, this.maxY);
        this.topLeftPoint = new Point(this.minX, this.minY);
    }
    //
    public Point getBottomLeftPoint() {
        return bottomLeftPoint;
    }
    public Point getTopRightPoint() {
        return topRightPoint;
    }
    //
    boolean isPointInside(Point p) {
        boolean res = false;
        // TODO: insert code
        return res;
    }
    //
    boolean isPointOnBorder(Point point) {
        boolean res = false;

        // check if the point is on any of the 4 lines
        // TODO: insert code

        return res;
    }
    boolean isLineIntersecting(Integer hlsId) {
        boolean res = false;
        

        // TODO: insert code

        return res;
    }

    //
    boolean isLineFullyInside(Integer hlsId) {
        HorizontalLineSegment hls = inputHLSList.get(hlsId);

        boolean res = false;

        // test if BOTH of the 2 endpoints of the HORIZONTAL line is INSIDE
        if(
            this.isPointInside(hls.getLeftEndPoint())
            &&
            this.isPointInside(hls.getRightEndPoint())
        ) {
            res = true;
        }

        return res;
    }
    //
    boolean isLineStriclyOutside(Integer hlsId) {
        
        boolean res = false;
        // TODO: insert code

        return res;
    }

    //
    boolean isFullyInsideOfRect(Rectangle qRect) {
        boolean res = true;

        // TODO: insert code

        return res;
    }
    //
    boolean isFullyOutsideOfRect(Rectangle qRect) {
        boolean res = true;

        // TODO: insert code

        return res;
    }
    //
    public String toString() {
        return "Rectangle(bottomLeftPoint: " + this.bottomLeftPoint.toString() + ", topRightPoint:" + this.topRightPoint.toString() + ")";
    }
}

class HorizontalLineSegment {
    private int lineId = -1;
    private RgbColor rgbColor;
    private Point leftEndPoint;
    private Point rightEndPoint;
    
    HorizontalLineSegment() {
        this.lineId = -1;
        this.rgbColor = lineDefaultRgbColor; // default color
        this.leftEndPoint = null;
        this.rightEndPoint = null;
    }
    HorizontalLineSegment(int lineId, Point leftEndPoint, Point rightEndPoint) {
        this.lineId = lineId;
        this.rgbColor = lineDefaultRgbColor; // default color
        this.leftEndPoint = leftEndPoint;
        this.rightEndPoint = rightEndPoint;
    }
    //
    public int getLineId() {
        return this.lineId;
    }
    public void setLineId(int lineId) {
        this.lineId = lineId;
    }
    public Point getLeftEndPoint() {
        return this.leftEndPoint;
    }
    public Point getRightEndPoint() {
        return this.rightEndPoint;
    }
    public RgbColor getRgbColor() {
        return this.rgbColor;
    }
    //
    public void setRgbColor(RgbColor rgbColor) {
        this.rgbColor = rgbColor;
    }
    public void setLeftEndPoint(Point leftEndPoint) {
        this.leftEndPoint = leftEndPoint;
    }
    public void setRightEndPoint(Point rightEndPoint) {
        this.rightEndPoint = rightEndPoint;
    }
    //
    public String toString() {
        // return "HorizontalLineSegment(lp: " + this.leftEndPoint.toString() + ", rp:" + this.rightEndPoint.toString() + ")";
        return "s" + str(this.getLineId());
    }
}

class Point {
    private int x;
    private int y;
    
    Point(int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    public int getX() {
        return this.x;
    }
    public int getY() {
        return this.y;
    }
    //
    public void setX(int x) {
        this.x = x;
    }
    public void setY(int y) {
        this.y = y;
    }
    //
    public String toString() {
        // return "Point(x: " + str(x) + ", y:" + str(y) + ")";
        return "(" + str(x) + ", " + str(y) + ")";
    }
}
