
var NUM_ROWS = 10;
var NUM_COLS = 10;
var COLOROFBOARD = new Color(82, 91, 104);
var bombs = 4;
var noPoints = 0;
function start(){
    makeBoard();
    grid();
    mouseClickMethod(breakApart());
}
function breakApart(e){
    click(e);
    points(click);
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

function genRectangle(width,height,x,y,color){ 
    var rect = new Rectangle(width,height); 
    rect.setPosition(x,y); 
    rect.setColor(color); 
    add(rect); 
}

function genLine(x1, y1, x2, y2){
    var line = new Line(x1, y1, x2, y2);
    line.setColor(Color.black);
    line.setLineWidth(5);
    add(line);
}

function grid(){
    var newGrid  = new Grid(NUM_ROWS,NUM_COLS);
    newGrid.set(NUM_COLS,NUM_ROWS,Randomizer.nextInt(0, 4));
    println(newGrid);
    add(newGrid);
}

function clicke(e){
    var xCord = e.getX();
    var yCord = e.getY();
    var location = (xCord + ", " + yCord);
    return(location);
}

function getRowForClick(Y){
    var decimalCol = Y / SQUARE_HEIGHT;
    var row = Math.floor(decimalCol);
    return row;
}

function getColForClick(X){
    var decimalCol = X / SQUARE_WIDTH;
    var column = Math.floor(decimalCol);
    return column;
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

