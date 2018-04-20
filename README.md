var NUM_ROWS = 3;
var NUM_COLS = 3;
var COLOROFBOARD = new Color(82, 91, 104);
var newGrid  = new Grid(NUM_ROWS,NUM_COLS);
var BOMBCOUNTER = 0;
var BOMBPERCENT = 0.2;
var bombTxt;

var SQUARE_WIDTH = getWidth()/NUM_COLS;
var SQUARE_HEIGHT = getHeight()/NUM_COLS;
var stateVariable = 0;
var gameHasStarted = false;
var COUNTER = 0;

var bombs = 1;
var noPoints = 0;
var openSquare = 2;
var falseDefused = 3;

//Functions I made are below here.

function start(){
    if(gameHasStarted == false){
        makeLoadingScreen();
    }
    
}

function startGame(e){
    if(e.keyCode == Keyboard.letter('S')){
        gameHasStarted == true;
        makeBoard();
        grid();
        keyDownMethod(switchModes);
        mouseClickMethod(determineTypeOfClick);
    }
}

function makeLoadingScreen(){
    var colorOfText = new Color(12, 87, 209);
    generateCustomPicture();
    setText("Press 'S' to begin.", 0, getHeight()/2 + 50, "20pt Arial");
    setText("Press 'E'for marker mode.", 0, getHeight()/2 + 100, "20pt Arial");
    setText("Press 'Q' for reveal mode.", 0, getHeight()/2 + 150, "20pt Arial");
    if(keyDownMethod(startGame) == true){
        gameHasStarted = true;
    }else{
        gameHasStarted = false;
    }
}

function generateCustomPicture(){
    var image = new WebImage("https://i.ytimg.com/vi/r6FLC6kwtss/maxresdefault.jpg");
    image.setSize(getWidth(), getHeight());
    image.setPosition(0,0);
    add(image);
}

function setText(num, X, Y, font){
    var txt = new Text(num, font);
    txt.setPosition(X + ((SQUARE_WIDTH / 2) - 3), Y + ((SQUARE_HEIGHT / 2) + 3));
    txt.setColor(Color.blue);
    add(txt);
}

function switchModes(e){
    if(e.keyCode == Keyboard.letter("q")){
        stateVariable = 1;
    }
    if(e.keyCode == Keyboard.letter("e")){
        stateVariable = 0;
    }
}

function makeBoard(){
    genRectangle(getWidth(), getHeight(), 0, 0, COLOROFBOARD);
    generateGridPicture();
}

function generateGridPicture(){
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

function determineTypeOfClick(e){
    if(stateVariable == 0){
        markBomb(e);
        generateGridPicture();
    }
    if(stateVariable == 1){
        revealSquare(e);
        generateGridPicture();
    }
    checkForWin();
}

function checkForWin(){
    var win = false;
    for(var x = 0; x < NUM_ROWS; x++){
        for(var y = 0; y < NUM_COLS; y++){
            var current = newGrid.get(x, y);
            if(current == openSquare && current != bombs){
                win = true;
                
            }else{
                win = false;
            }
        }
    }
    if(win==true){
        printScreen(win);
    }
}

function printScreen(win){
    setText("You have won the game!", 50, getHeight()/2,"20pt Arial");
}

function markBomb(e){
    var col = getColForClick(e.getX());
    var row = getRowForClick(e.getY());
    var number = newGrid.get(row, col);
    var totalBombs = numberOfBombs();
    if(COUNTER <= totalBombs){
        if(number == 3 || number == 2){
            removeMarker(col, row, number);
        }else{
            addMarker(col,row,number);
        }
    }
    println(totalBombs);
    println(COUNTER);
}

function removeDefused(col, row, number){
    genRectangle(SQUARE_WIDTH, SQUARE_HEIGHT, SQUARE_WIDTH * col, SQUARE_HEIGHT * row, COLOROFBOARD);
    println(newGrid);
}

function numberOfBombs(){
    var temp = 0;
    for(var x = 0; x <= NUM_ROWS - 1; x++){
        for(var y = 0; y <= NUM_COLS - 1; y++){
            var current = newGrid.get(x, y);
            if(current == bombs){
                temp++;
            }
        }
    }
    return temp;
}

function addMarker(col,row,number){
    genRectangle(SQUARE_WIDTH,SQUARE_HEIGHT,SQUARE_WIDTH*col,SQUARE_HEIGHT*row,COLOROFBOARD);
    makeCircle(SQUARE_WIDTH/2, SQUARE_WIDTH * col + (SQUARE_WIDTH/2), SQUARE_HEIGHT * row + (SQUARE_HEIGHT/2), Color.red);
    println(newGrid);
}

function makeCircle(radius, X, Y, color){
    var circle = new Circle(radius);
    circle.setPosition(X, Y);
    circle.setColor(color);
    add(circle);
}

function revealSquare(e){
    var xCoord = e.getX();
    var yCoord = e.getY();
    var col = getColForClick(xCoord);
    var row = getRowForClick(yCoord);
    var number = newGrid.get(row, col);
    if(number == bombs){
        println("Lose");
    }else if(number == 0){
        var neighbors = checkNeighbors(row, col);
        fillInCell(neighbors, row, col);
        newGrid.set(row,col,openSquare);
        BOMBCOUNTER = 0;
    }else{
        
    }
}

function fillInCell(num, row, col){
    var rectXCoord = SQUARE_WIDTH * col;
    var rectYCoord = SQUARE_HEIGHT * row;
    genRectangle(SQUARE_WIDTH, SQUARE_HEIGHT, rectXCoord, rectYCoord, Color.white);
    setText(num, rectXCoord, rectYCoord, "10pt Arial");
}


function getColForClick(X){
    var column = Math.floor(X/(getWidth()/NUM_ROWS));
    return column;
}

function getRowForClick(Y){
    var row = Math.floor(Y/(getHeight()/NUM_COLS));
    return row;
}
