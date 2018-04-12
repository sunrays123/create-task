var NUM_ROWS = 10;
var NUM_COLS = 10;
var COLOROFBOARD = new Color(82, 91, 104);
var newGrid  = new Grid(NUM_ROWS,NUM_COLS);
var BOMBCOUNTER = 0;
var BOMBPERCENT = 0.2;
var SQUARE_WIDTH = getWidth()/NUM_COLS;
var SQUARE_HEIGHT = getHeight()/NUM_COLS;


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

function grid(){
    for(var x = 0; x < NUM_ROWS; x++){
        for(var y = 0; y < NUM_COLS; y++){
            var number = Randomizer.nextBoolean(BOMBPERCENT);
            newGrid.set(x, y, number);
            setCellGrid(number, x, y);
        }
    }
    println(newGrid);
}

function setCellGrid(number, x, y){
    if(number == true){
        newGrid.set(x, y, bombs);
    }else{
        newGrid.set(x, y, noPoints);
    }
}

//Functions my partner made are below here.
var bombs = 1;
var noPoints = 0;

function genRectangle(width,height,x,y,color){ 
    var rect = new Rectangle(width,height); 
    rect.setPosition(x,y); 
    rect.setColor(color); 
    add(rect); 
}

function checkNeighbors(row, col){
    if(newGrid.inBounds(row - 1, col) == true && newGrid.get(row - 1, col) == bombs){
        BOMBCOUNTER++;
    }
    if(newGrid.inBounds(row - 1, col + 1) == true && newGrid.get(row - 1, col + 1) == bombs){
        BOMBCOUNTER++;
    }
    if(newGrid.inBounds(row - 1, col - 1) == true && newGrid.get(row - 1, col - 1) == bombs){
        BOMBCOUNTER++;
    }
    if(newGrid.inBounds(row, col - 1) == true && newGrid.get(row, col - 1) == bombs){
        BOMBCOUNTER++;
    }
    if(newGrid.inBounds(row, col + 1) == true && newGrid.get(row, col + 1) == bombs){
        BOMBCOUNTER++;
    }
    if(newGrid.inBounds(row + 1, col) == true && newGrid.get(row + 1, col) == bombs){
        BOMBCOUNTER++;
    }
    if(newGrid.inBounds(row + 1, col - 1) == true && newGrid.get(row + 1, col - 1) == bombs){
        BOMBCOUNTER++;
    }
    if(newGrid.inBounds(row + 1, col + 1) == true && newGrid.get(row + 1, col + 1) == bombs){
        BOMBCOUNTER++;
    }
    return BOMBCOUNTER;
}

function determineLocation(e){
    var xCoord = e.getX();
    var yCoord = e.getY();
    var col = getColForClick(xCoord);
    var row = getRowForClick(yCoord);
    var number = newGrid.get(row, col);
    if(number == bombs){
        println("Lose");
    }else{
        var neighbors = checkNeighbors(row, col);
        fillInCell(neighbors, row, col);
        BOMBCOUNTER = 0;
    }
}

function rowInBounds(row){
    if(row < 0){
        return false;
    }
    if(row >=  NUM_ROWS){
        return false;
    }
    return true;
}

function colInBounds(col){
    if(column < 0){
        return false;
    }
    if(column >= NUM_COLS){
        return false;
    }
    return true;
    
}

function fillInCell(num, row, col){
    var rectXCoord = translateRowToX(col);
    var rectYCoord = translateColToY(row);
    genRectangle(SQUARE_WIDTH, SQUARE_HEIGHT, rectXCoord, rectYCoord, Color.white);
    if(num == 0){
        setText(num, rectXCoord, rectYCoord);
            for(var x =1; x <= 9; x++){
                for(var y =1; y <= 9; y++){
                    var rows = row - x;
                    var cols = col - y;
                    var r = getColForClick(rows);
                    var c = getRowForClick(cols);
                    var xCord = translateRowToX(r);
                    var yCord = translateColToY(c);
                    if(num >= 1 && num <= 8){
                        setText(num,xCord,yCord);
                    }else{
                        setText(num,xCord,yCord);
                    }
                }
        }
    }else{
        setText(num,rectXCoord, rectYCoord);
    }
}

function setText(num, X, Y){
    var txt = new Text(num, "10pt Arial");
    txt.setPosition(X + ((SQUARE_WIDTH / 2) - 3), Y + ((SQUARE_HEIGHT / 2) - 5));
    txt.setColor(Color.blue);
    add(txt);
}


function getColForClick(X){
    var column = Math.floor(X/(getWidth()/NUM_ROWS));
    return column;
}

function getRowForClick(Y){
    var row = Math.floor(Y/(getHeight()/NUM_COLS));
    return row;
}

function translateRowToX(col){
    return SQUARE_WIDTH * col;
}

function translateColToY(row){
    return SQUARE_HEIGHT * row;
}
