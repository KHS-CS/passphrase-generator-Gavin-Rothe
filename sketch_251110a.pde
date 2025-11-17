String[] words = new String[66667];
ArrayList<String> topWords = new ArrayList<String>();
String currentWord = "";
String baseWord = "";

boolean capFirst = false;
boolean replaceO = false;
boolean replaceL = false;

void setup() { 
  size(1000, 700);
  textSize(40);
  textAlign(CENTER, CENTER);
  background(240);
  String[] lines = loadStrings("eff_large_wordlist.txt");
  for (int i = 0; i < lines.length; i++) {
    String[] results = split(lines[i], '\t');
    if (results.length == 2) {
      words[int(results[0])] = results[1];
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    // Move the current center word to the top array
    if (!currentWord.equals("")) {
      topWords.add(currentWord);
    }
    
    
    // Generate a new random Diceware word
    String lookupString = "";
    for (int i = 0; i < 5; i++) {
      lookupString += str(int(random(1, 7)));
    }
    int index = int(lookupString);
    
 if (index > 0 && index < words.length && words[index] != null) {
      baseWord = words[index];
      toggleWord();
    }
  }
    
    if (key == 'u') {   // toggle uppercase first letter
    capFirst = !capFirst;
    toggleWord();
  }
  if (key == 'o') {   // toggle o → 0
    replaceO = !replaceO;
    toggleWord();
  }
  if (key == 'l') {   // toggle l → 1
    replaceL = !replaceL;
    toggleWord();
  }
  
  //clear everything
  if (key == 'c') {
    topWords.clear();
    currentWord = "";
  }
}

void toggleWord() {
  if (baseWord.equals("")) return;

  String w = baseWord;

  if (replaceO) w = w.replace('o', '0');
  if (replaceL) w = w.replace('l', '1');

  if (capFirst && w.length() > 0) {
    w = Character.toUpperCase(w.charAt(0)) + w.substring(1);
  }

  currentWord = w;
}

float wrapHeight(float fontSize) {
  textSize(fontSize);
  float x = 20;
  float y = 20;
  float lineHeight = textAscent() + textDescent() + 10;

  for (String w : topWords) {
    float wWidth = textWidth(w);
    if (x + wWidth > width - 20) {
      x = 20;
      y += lineHeight;
    }
    x += wWidth + 20;
  }

  return y + lineHeight; // total height of wrapped text block
}

void draw() {
  background(240);
  fill(50);

float targetMaxHeight = height;
float fontSize = 20;

// Try shrinking until text fits
while (fontSize > 8 && wrapHeight(fontSize) > targetMaxHeight) {
  fontSize *= 0.99;
}

textAlign(LEFT, TOP);
textSize(fontSize);

float x = 20;
float y = 20;
float lineHeight = textAscent() + textDescent() + 10;

for (String w : topWords) {
  float wWidth = textWidth(w);
  if (x + wWidth > width - 20) {
    x = 20;
    y += lineHeight;
  }
  text(w, x, y);
  x += wWidth + 20;
}
  centerword();
}

void centerword(){
    textAlign(CENTER, CENTER);
  float tw = textWidth(currentWord);
  float th = textAscent() + textDescent();
  
  fill(255);
  noStroke();
  rectMode(CENTER);
  rect(width/2, height/2, tw + 40, th + 20, 10);
  fill(0);
  text(currentWord, width/2, height/2);
  println(topWords);
}
