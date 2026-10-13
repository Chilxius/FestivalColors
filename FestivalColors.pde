//330 - 1700

//1370
//500 + 150 + 35 = 685 + 330

//1015 - 460 = 555
//1015
//1475

import processing.sound.*;

ArrayList<Integer> reds = new ArrayList<Integer>();
ArrayList<Integer> blues = new ArrayList<Integer>();
ArrayList<Integer> yellows = new ArrayList<Integer>();
ArrayList<Integer> greens = new ArrayList<Integer>();
ArrayList<Integer> purples = new ArrayList<Integer>();

SoundFile hit, open, place;

PImage cloth, fullRod, partRod, powder, banner;
PImage [] rock = new PImage[4];
int rockStage = -1;

int clothSize = 100;
color firstColor = -1;
color powderColor = color(0);

float rValue = -1, yValue = -1, gValue = -1, bValue = -1, pValue = -1;

int rockX = 1015;

void setup()
{
  fullScreen();
  
  cloth   = loadImage( "cloth.png" );   cloth.resize(clothSize,0);
  powder  = loadImage( "powder.png" );  powder.resize(450,0);
  partRod = loadImage( "partRod.png" ); partRod.resize(clothSize,0);
  fullRod = loadImage( "fullRod.png" ); fullRod.resize(clothSize,0);
  banner  = loadImage( "banner.png" );  banner.resize(450,0);
  
  rock[0] = loadImage( "rock0.png" ); rock[0].resize(450,0);
  rock[1] = loadImage( "rock1.png" ); rock[1].resize(450,0);
  rock[2] = loadImage( "rock2.png" ); rock[2].resize(450,0);
  rock[3] = loadImage( "rock3.png" ); rock[3].resize(475,0);
  
  hit = new SoundFile(this, "rockHit.mp3");
  open = new SoundFile(this, "rockBreak.mp3");
  place = new SoundFile(this, "rockPlace.mp3");
  
  loadColors();
}

void draw()
{
  background(0);
  
  drawCloths( clothSize * 0, reds );
  drawCloths( clothSize * 1.2, yellows );
  drawCloths( clothSize * 2.4, greens );
  drawCloths( clothSize * 3.6, blues );
  drawCloths( clothSize * 4.8, purples );
  
  if( firstColor != -1 )
    tint( firstColor );
  else
    tint( 255 );
    image( banner, 555-250, height/2+75 );
    //image( banner, 1015-250, height/2+75 );
    image( banner, 1475-250, height/2+75 );
    
  showRock();
  
  showValues();
  
  showRGB();
}

void keyPressed()
{
  if( key == 'x' )
  {
    saveColors();
    exit();
  }
  
  if( key == '*' )
  {
    clearData();
    exit();
  }
  
  if( key == 'r' )  reds.add( color( 255,0,0 ) );
  if( key == 'y' )  yellows.add( color( 255,255,0 ) );
  if( key == 'g' )  greens.add( color( 0,255,0) );
  if( key == 'b' )  blues.add( color( 0,0,255 ) );
  if( key == 'p' )  purples.add( color( 255,0,255 ) );

  if( key == ' ' )  advanceRock();//generateColor();
  
  recalculateValues();
}

void mousePressed()
{
  println( mouseX + " " + mouseY );
}

void showRock()
{
  if( rockStage < 0 ) return;
  
  imageMode(CORNER);
  
  if( rockStage < 4 )
  {
    noTint();
    image( rock[rockStage], rockX-245, height/2+75 );
  }
  
  if( rockStage == 3 )
  {
    tint(powderColor);
    image( powder, rockX-245, height/2+75 );
  }
}

void advanceRock()
{
  if( rockStage < 4 )
  {
    rockStage++;
    if( rockStage == 0 )
      place.play();
    if( rockStage == 1 || rockStage == 2 )
      hit.play();
    if( rockStage == 3 )
      open.play();
  }
  if( rockStage == 3 )
    generateColor();

  if( rockStage == 4 )
    rockStage = -1;
}

void showValues()
{
  fill(255);
  textSize(40);
  textAlign(LEFT);
  
  text( "Red:", 40, height - 300 );    text( rValue>0?rValue:0, 170, height-300 );
  text( "Yellow:", 40, height - 250 ); text( yValue>0?yValue:0, 170, height-250 );
  text( "Green:", 40, height - 200 );  text( gValue>0?gValue:0, 170, height-200 );
  text( "Blue:", 40, height - 150 );   text( bValue>0?bValue:0, 170, height-150 );
  text( "Purple:", 40, height - 100 ); text( pValue>0?pValue:0, 170, height-100 );
  
  textSize(20);
  text( reds.size() + yellows.size() + greens.size() + blues.size() + purples.size(), 20, height-30 );
}

//Currently off
void showRGB()
{
  int col = mouseX/clothSize;
  int row = int(mouseY/(clothSize*1.2));
  if( row >= 5 ) return;
  textAlign(CENTER);
  
  fill(255);
  switch( row )
  {
    case 0:
      if( col >= reds.size() ) return;
      text( red(reds.get(col)) + ", " + green(reds.get(col)) + ", " + blue(reds.get(col)), 160, 660 );
      break;
    case 1:
      if( col >= yellows.size() ) return;
      text( red(yellows.get(col)) + ", " + green(yellows.get(col)) + ", " + blue(yellows.get(col)), 160, 660 );
      break;
    case 2:
      if( col >= greens.size() ) return;
      text( red(greens.get(col)) + ", " + green(greens.get(col)) + ", " + blue(greens.get(col)), 160, 660 );
      break;
    case 3:
      if( col >= blues.size() ) return;
      text( red(blues.get(col)) + ", " + green(blues.get(col)) + ", " + blue(blues.get(col)), 160, 660 );
      break;
    case 4:
      if( col >= purples.size() ) return;
      text( red(purples.get(col)) + ", " + green(purples.get(col)) + ", " + blue(purples.get(col)), 160, 660 );
      break;
      
  }
}

void generateColor()
{
  int r=0, g=0, b=0;
  
  int type = int(random(5));
  boolean bright = random(2) > 1 ? true : false;
  
  switch(type)
  {
    case 0: //red
      r = int(random(150,255));
      g = int(random(0,125));
      b = int(random(0,125));
      if( bright )
        while(r < 255)
        {
          r++;
          if( random(3) < 1 ) g++;
          if( random(3) < 1 ) b++;
        }
      else
        while( g > 0 && b > 0 )
        {
          g--;
          b--;
          if( random(3) < 1 ) r--;
        }
      break;
    
    case 1: //yellow/orange
      r = int(random(150,255));
      do{
      g = int(random(150,255));
      }while(g > r);
      b = int(random(0,100));
      if( bright )
        while(r < 255)
        {
          r++;
          g++;
          b--;
        }
      else
        while( g > 0 && b > 0 )
        {
          b--;
          if( random(3) < 1 ) r--;
          if( random(3) < 1 ) g--;
        }
      break;
    
    case 2: //green
      r = int(random(0,125));
      g = int(random(150,255));
      b = int(random(0,125));
      if( bright )
        while(g < 255)
        {
          g++;
          if( random(3) < 1 ) r++;
          if( random(3) < 1 ) b++;
        }
      else
        while( r > 0 && b > 0 )
        {
          r--;
          b--;
          if( random(3) < 1 ) g--;
        }
      break;
    
    case 3: //blue
      r = int(random(0,125));
      g = int(random(0,125));
      b = int(random(150,255));
      if( bright )
        while(b < 255)
        {
          b++;
          if( random(3) < 1 ) g++;
          if( random(3) < 1 ) r++;
        }
      else
        while( g > 0 && r > 0 )
        {
          g--;
          r--;
          if( random(3) < 1 ) b--;
        }
      break;
    
    case 4: //purple
      r = int(random(150,255));
      g = int(random(0,125));
      do{
      b = int(random(150,255));
      }while(b<r);
      if( bright )
        while(b < 255)
        {
          r++;
          if( random(2) < 1 ) g++;
          b++;
        }
      else
        while( g > 0  )
        {
          g--;
          if( random(3) < 1 ) b--;
          if( random(3) < 1 ) r--;
        }
      break;
  }
  
  color newColor = color(r,g,b);
  
  if( firstColor == -1 )
    firstColor = newColor;
    
  powderColor = newColor;
  
  switch(type)
  {
    case 0: reds.add(    newColor ); break;
    case 1: yellows.add( newColor ); break;
    case 2: greens.add(  newColor ); break;
    case 3: blues.add(   newColor ); break;
    case 4: purples.add( newColor ); break;
  }
}

//void recalculateValues()
//{
//  int total = reds.size() + yellows.size() + blues.size() + greens.size() + purples.size();
  
//  if(reds.size()>0)    rValue = 50 / (total/reds.size());
//  if(yellows.size()>0) yValue = 50 / (total/yellows.size());
//  if(greens.size()>0)  gValue = 50 / (total/greens.size());
//  if(blues.size()>0)   bValue = 50 / (total/blues.size());
//  if(purples.size()>0) pValue = 50 / (total/purples.size());
//}

//From ChatGPT
void recalculateValues()
{
  float r = reds.size() > 0 ? 1.0 / reds.size() : 0;
  float y = yellows.size() > 0 ? 1.0 / yellows.size() : 0;
  float g = greens.size() > 0 ? 1.0 / greens.size() : 0;
  float b = blues.size() > 0 ? 1.0 / blues.size() : 0;
  float p = purples.size() > 0 ? 1.0 / purples.size() : 0;

  float total = r + y + g + b + p;

  if(total == 0) return;

  rValue = 50 * r / total;
  yValue = 50 * y / total;
  gValue = 50 * g / total;
  bValue = 50 * b / total;
  pValue = 50 * p / total;
}

void drawCloths( float y, ArrayList<Integer> colors )
{
  for( int i = 0; i < width/clothSize; i++ )
  {
    if( i < colors.size() )
    {
      noTint();
      image( partRod, i*clothSize, y );
      tint(colors.get(i));
      image( cloth, i*clothSize, y );
      fill(200);
      textSize(15);
      textAlign(LEFT);
      text( i+1, i*clothSize, y+clothSize );
    }
    else
    {
      noTint();
      image( fullRod, i*clothSize, y );
    }
  }
}

void clearData()
{
  try
  {
    PrintWriter pw;
    pw = createWriter("reds.txt");    pw.flush(); pw.close();
    pw = createWriter("yellows.txt"); pw.flush(); pw.close();
    pw = createWriter("greens.txt");  pw.flush(); pw.close();
    pw = createWriter("blues.txt");   pw.flush(); pw.close();
    pw = createWriter("purples.txt"); pw.flush(); pw.close();
    pw = createWriter("data.txt");    pw.flush(); pw.close();
  }
  catch(Exception e)
  {
    println("Something Went Wrong: CLEARING");
  }
}

void saveColors()
{
  try
  {
    PrintWriter pw = createWriter("reds.txt");
    for( Integer i: reds ) pw.println(i);
    pw.flush(); pw.close();
    
    pw = createWriter("yellows.txt");
    for( Integer i: yellows ) pw.println(i);
    pw.flush(); pw.close();
    
    pw = createWriter("greens.txt");
    for( Integer i: greens ) pw.println(i);
    pw.flush(); pw.close();
    
    pw = createWriter("blues.txt");
    for( Integer i: blues ) pw.println(i);
    pw.flush(); pw.close();
    
    pw = createWriter("purples.txt");
    for( Integer i: purples ) pw.println(i);
    pw.flush(); pw.close();
    
    pw = createWriter("data.txt");
    pw.println(firstColor);
    pw.flush(); pw.close();
  }
  catch(Exception e)
  {
    println("Something Went Wrong: SAVING");
  }
}

ArrayList<Integer> loadColors()
{
  ArrayList<Integer> colorList = new ArrayList<Integer>();
  try
  {
    String [] data = loadStrings("reds.txt");
    for( String s: data )
      reds.add(color(int(s)));
      
    data = loadStrings("yellows.txt");
    for( String s: data )
      yellows.add(color(int(s)));
      
    data = loadStrings("greens.txt");
    for( String s: data )
      greens.add(color(int(s)));
      
    data = loadStrings("blues.txt");
    for( String s: data )
      blues.add(color(int(s)));
      
    data = loadStrings("purples.txt");
    for( String s: data )
      purples.add(color(int(s)));
      
    data = loadStrings("data.txt");
    if( data.length > 0 )
      firstColor = int(data[0]);
  }
  catch(Exception e)
  {
    println("Something Went Wrong: LOADING");
    colorList.add( color(0) );
  }
  
  return colorList;
}
