var NUM_ROWS = 10;
var NUM_COLS = 10;
var COLOROFBOARD = new Color(82, 91, 104);
var newGrid  = new Grid(NUM_ROWS,NUM_COLS);
var BOMBCOUNTER = 0;
var BOMBPERCENT = 0.1;
var bombTxt;

var SQUARE_WIDTH = getWidth()/NUM_COLS;
var SQUARE_HEIGHT = getHeight()/NUM_COLS;
var stateVariable = 0;
var gameHasStarted = false;
var gameIsOver = false;

var noPoints = 0;
var bombs = 1;
var openSquare = 2;
var marker = 3;
var markedBomb = 4;

//Functions I made are below here.

function start(){
    if(gameHasStarted == false){
        makeLoadingScreen();
    }
    
}
//sdsdsdsdsdsd
function startGame(e){
    if(e.keyCode == Keyboard.letter('S')){
        gameHasStarted == true;
        makeBoard();
        grid();
        keyDownMethod(switchModes);
        mouseClickMethod(determineTypeOfClick);
    }
    println(newGrid);
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
    for(var x = -1; x <=1 ; x++){
            for(var y = -1; y <= 1; y++){
                var neighborRow = row - x;
                var neighborCols = col - y;
                if(newGrid.inBounds(neighborRow,neighborCols) == true && newGrid.get(neighborRow,neighborCols) == bombs){
                    BOMBCOUNTER++;
                }
            }
    }
    return  BOMBCOUNTER;
}

function determineTypeOfClick(e){
    if(gameIsOver == false){    
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
}

function checkForWin(){
    var winCounter = 0;
    var totalNotBombs = findAllNotBombs();
    for(var x = 0; x < NUM_ROWS; x++){
        for(var y = 0; y < NUM_COLS; y++){
            var current = newGrid.get(x, y);
            if(current == openSquare){
                winCounter++;
            }
        }
    }
    if(totalNotBombs == winCounter){
        printScreen("Won");
    }else{
        winCounter = 0;
    }
}

function findAllNotBombs(){
    var squares = 0;
    for(var x = 0; x < NUM_ROWS; x++){
        for(var y = 0; y < NUM_COLS; y++){
            var current = newGrid.get(x, y);
            if(current == openSquare || current == noPoints || current == marker){
                squares++;
            }
        }
    }
    return squares;
}


function printScreen(condition){
    genRectangle(getWidth(), getHeight(), 0, 0, Color.white);
    setText("You have " + condition + " the game!", 0, getHeight()/2-50,"20pt Arial");
    gameIsOver = true;
}

function markBomb(e){
    var col = getColForClick(e.getX());
    var row = getRowForClick(e.getY());
    var number = newGrid.get(row, col);
    var condition = false;
    if(number == 3 || number == 4){
        if(number == 3){
            condition = false;
            removeMarker(col, row, number, condition);
        }else{
            condition = true;
            removeMarker(col, row, number, condition);
        }
    }else{
        if(number == 0){
            addMarker(col,row,number);
        }else if(number == 1){
            addMarkerOnBomb(col,row,number);
        }else{
            println("You can't mark an opened square.")
        }
    }
}

function addMarkerOnBomb(col, row, number){
    genRectangle(SQUARE_WIDTH, SQUARE_HEIGHT, SQUARE_WIDTH * col, SQUARE_HEIGHT * row, COLOROFBOARD);
    makeCircle(SQUARE_WIDTH/2, SQUARE_WIDTH * col + (SQUARE_WIDTH/2), SQUARE_HEIGHT * row + (SQUARE_HEIGHT/2), Color.red);
    newGrid.set(row, col, markedBomb);
}

function removeMarker(col, row, number, condition){
    genRectangle(SQUARE_WIDTH, SQUARE_HEIGHT, SQUARE_WIDTH * col, SQUARE_HEIGHT * row, COLOROFBOARD);
    if(condition == false){
        newGrid.set(row,col,0);
    }else{
        newGrid.set(row, col, 1);
    }
}

function addMarker(col,row,number){
    genRectangle(SQUARE_WIDTH,SQUARE_HEIGHT,SQUARE_WIDTH*col,SQUARE_HEIGHT*row,COLOROFBOARD);
    makeCircle(SQUARE_WIDTH/2, SQUARE_WIDTH * col + (SQUARE_WIDTH/2), SQUARE_HEIGHT * row + (SQUARE_HEIGHT/2), Color.red);
    newGrid.set(row,col,marker);
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
    if(number == bombs || number == markedBomb){
        printScreen("Lost");
    }else if(number==0||number == 3 || number){
        var neighbors = checkNeighbors(row, col);
        if(neighbors==0){
            adajacentSquare(neighbors,row,col);
            fillInCell(neighbors,row,col);
            newGrid.set(row,col,openSquare);
            BOMBCOUNTER=0;
        }else{
            fillInCell(neighbors, row, col);
        newGrid.set(row,col,openSquare);
        BOMBCOUNTER = 0;
        }
    }else{
        println("This square has already been opened");  
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
    if(col < 0){
        return false;
    }
    if(col >= NUM_COLS){
        return false;
    }
    return true;
    
}


function adajacentSquare(num,row,col){
    if(num == 0){
        for(var x = -1; x <=1 ; x++){
            for(var y = -1; y <= 1; y++){
                var neighborRow = row - x;
                var neighborCols = col - y;
                var nums = checkNeighbors(neighborRow,neighborCols);
                    if(rowInBounds(neighborRow) && colInBounds(neighborCols)){
                        if(neighborRow != row || neighborCols != col){
                            if(nums >= 1 && nums <= 8){
                                fillInCell(nums,neighborRow,neighborCols);
                                println(nums);
                        }else{
                            adajacentSquare(nums,neighborRow,neighborCols);
                            
                        }
                    }
                }
            }
        }
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
