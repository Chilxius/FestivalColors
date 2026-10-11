
ArrayList<Integer> reds = new ArrayList<Integer>();
ArrayList<Integer> blues = new ArrayList<Integer>();
ArrayList<Integer> yellows = new ArrayList<Integer>();
ArrayList<Integer> greens = new ArrayList<Integer>();
ArrayList<Integer> purples = new ArrayList<Integer>();

PImage cloth, fullRod, partRod;

int mainColor = -1;

int clothSize = 75;

void setup()
{
  size(1200,700);
  
  cloth = loadImage( "cloth.png" );     cloth.resize(clothSize,0);
  partRod = loadImage( "partRod.png" ); partRod.resize(clothSize,0);
  fullRod = loadImage( "fullRod.png" ); fullRod.resize(clothSize,0);
  
  mainColor = int(random(5));
}

void draw()
{
  background(0);
  drawColors( clothSize * 0, reds );
  drawColors( clothSize * 1, yellows );
  drawColors( clothSize * 2, greens );
  drawColors( clothSize * 3, blues );
  drawColors( clothSize * 4, purples );
  
  showRGB();
}

void keyPressed()
{
  if( key == 'r' )
    reds.add( color( 255,0,0 ) );
  if( key == 'y' )
    yellows.add( color( 255,255,0 ) );
  if( key == 'g' )
    greens.add( color( 0,255,0) );
  if( key == 'b' )
    blues.add( color( 0,0,255 ) );
  if( key == 'p' )
    purples.add( color( 255,0,255 ) );
  if( key == ' ' )
    generateColor();
}

void showRGB()
{
  int col = mouseX/clothSize;
  int row = mouseY/clothSize;
  if( row >= 5 ) return;
  
  fill(255);
  switch( row )
  {
    case 0:
      if( col >= reds.size() ) return;
      text( red(reds.get(col)) + ", " + green(reds.get(col)) + ", " + blue(reds.get(col)), width/2, height-100 );
      break;
    case 1:
      if( col >= yellows.size() ) return;
      text( red(yellows.get(col)) + ", " + green(yellows.get(col)) + ", " + blue(yellows.get(col)), width/2, height-100 );
      break;
    case 2:
      if( col >= greens.size() ) return;
      text( red(greens.get(col)) + ", " + green(greens.get(col)) + ", " + blue(greens.get(col)), width/2, height-100 );
      break;
    case 3:
      if( col >= blues.size() ) return;
      text( red(blues.get(col)) + ", " + green(blues.get(col)) + ", " + blue(blues.get(col)), width/2, height-100 );
      break;
    case 4:
      if( col >= purples.size() ) return;
      text( red(purples.get(col)) + ", " + green(purples.get(col)) + ", " + blue(purples.get(col)), width/2, height-100 );
      break;
      
  }
}

void generateColor()
{
  int r=0, g=0, b=0;
  
  int type = int(random(6));
  boolean bright = true ? random(2) > 1 : false;
  
  if( type == 5 ) type = mainColor;
  
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
          if( random(3) < 1 ) b++;
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
  
  switch(type)
  {
    case 0: reds.add( color(r,g,b) ); break;
    case 1: yellows.add( color(r,g,b) ); break;
    case 2: greens.add( color(r,g,b) ); break;
    case 3: blues.add( color(r,g,b) ); break;
    case 4: purples.add( color(r,g,b) ); break;
  }
}

void drawColors( int y, ArrayList<Integer> colors )
{
  for( int i = 0; i < width/clothSize; i++ )
  {
    if( i < colors.size() )
    {
      noTint();
      image( partRod, i*clothSize, y );
      tint(colors.get(i));
      image( cloth, i*clothSize, y );
    }
    else
    {
      noTint();
      image( fullRod, i*clothSize, y );
    }
  }
}
