# create-task
var NUM_ROWS = 10;
var NUM_COLS = 10;
var COLOROFBOARD = new Color(82, 91, 104);
var newGrid;

//Functions I made are below here.

function start(){
    makeBoard();
    grid();
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
var bombs = 0;
var noPoints = 4;

function genRectangle(width,height,x,y,color){ 
    var rect = new Rectangle(width,height); 
    rect.setPosition(x,y); 
    rect.setColor(color); 
    add(rect); 
}

function grid(){
    var number = Randomizer.nextInt(bombs, noPoints);
    newGrid  = new Grid(NUM_ROWS,NUM_COLS);
    newGrid.init(number);
    println(newGrid);
}
