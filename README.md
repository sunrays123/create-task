var NUM_ROWS = 10;
var NUM_COLS = 10;
var COLOROFBOARD = new Color(82, 91, 104);
var newGrid  = new Grid(NUM_ROWS,NUM_COLS);
var BOMBCOUNTER = 0;



//Functions I made are below here.

function start(){
    makeBoard();
    grid();
    mouseClickMethod(determineLocation);
}

function makeBoard(){
    genRectangle(getWidth(), getHeight(), 0, 0, COLOROFBOARD);
    
    var xSpacing = getWidth()/NUM_ROWS;
    var OriginalXSpacing = xSpacing;
    for(var x = 1; x < NUM_ROWS + 1; x++){
        genLine(xSpacing, 0, xSpacing, getHeight());
        xSpacing = OriginalXSpacing * x;
    }
    
    var ySpacing = getHeight()/NUM_COLS;
    var OriginalYSpacing = ySpacing;
    for(var y = 0; y < NUM_COLS + 1; y++){
        genLine(0, ySpacing, getWidth(), ySpacing);
        ySpacing = OriginalYSpacing * y;
    }
}


function genLine(x1, y1, x2, y2){
    var line = new Line(x1, y1, x2, y2);
    line.setColor(Color.black);
    line.setLineWidth(2);
    add(line);
}

//Functions my partner made are below here.
var bombs = 4;
var noPoints = 0;

function genRectangle(width,height,x,y,color){ 
    var rect = new Rectangle(width,height); 
    rect.setPosition(x,y); 
    rect.setColor(color); 
    add(rect); 
}

function limitAmountOfBombs(x, y){
    if(newGrid.get(x,y) == bombs){
        BOMBCOUNTER++;
        if(BOMBCOUNTER == 15){
            bombs = 3;        
        }
    }
}

function grid(){
    for(var x = 0; x < NUM_ROWS; x++){
        for(var y = 0; y < NUM_COLS; y++){
            var number = Randomizer.nextInt(noPoints, bombs);
            newGrid.set(x, y, number);
            limitAmountOfBombs(x, y);
        }
    }
    bombs = 4;
    println(newGrid);
}

function determineLocation(e){
    var xCoord = e.getX();
    var yCoord = e.getY();
    var row = getColForClick(xCoord);
    var col = getRowForClick(yCoord);
    println(row + "," + col);
}

function getColForClick(X){
    var WIDTHOFBOX = getWidth()/NUM_ROWS;
    var decimalCol = X / WIDTHOFBOX;
    var column = Math.floor(decimalCol);
    return column;
}

function getRowForClick(Y){
    var HEIGHTOFBOX = getHeight()/NUM_COLS;
    var decimalCol = Y / HEIGHTOFBOX;
    var row = Math.floor(decimalCol);
    return row;
}

function valueXCord(COL){
    if(COL == 0){
        return SQUARE_WIDTH /2;
    }else{
        return (SQUARE_WIDTH * COL) + (SQUARE_WIDTH / 2); 
    }
}

function valueYCord(ROW){
    if(ROW == 0){
        return SQUARE_HEIGHT /2;
    } else {
        return (SQUARE_HEIGHT * ROW) + (SQUARE_HEIGHT /2);
    }
}
function points(){
    var elem = newGrid.get(clicke);
    
}
