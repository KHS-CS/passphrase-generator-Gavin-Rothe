String[] wordlist = new String[66667];
ArrayList<String> topWords = new ArrayList<String>();
String currentWord = "";

void setup() { 
  size(1000, 800);
  textSize(40);
  textAlign(CENTER, CENTER);
  background(240);
  String[] lines = loadStrings("eff_large_wordlist.txt");
  for (int i = 0; i < lines.length; i++) {
    String[] results = split(lines[i], '\t');
    if (results.length == 2) {
      wordlist[int(results[0])] = results[1];
    }
  }
}

void keyPressed() {
  if (key == 'w') {
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
    
    if (index > 0 && index < wordlist.length && wordlist[index] != null) {
      currentWord = wordlist[index];
      
      // Letter substitutions
      currentWord = currentWord.replace('o', '0');
      currentWord = currentWord.replace('l', '1');
      
      // Capitalize first letter
      if (currentWord.length() > 0) {
        char first = Character.toUpperCase(currentWord.charAt(0));
        currentWord = first + currentWord.substring(1);
      }
    }
  }
  
  // Press 'c' to clear everything
  if (key == 'c') {
    topWords.clear();
    currentWord = "";
  }
}

void draw() {
  background(240);
  fill(50);
  
  // Draw top words with automatic wrapping
  textAlign(LEFT, TOP);
  float x = 20;
  float y = 20;
  float lineHeight = textAscent() + textDescent() + 10; // vertical spacing
  
  for (String w : topWords) {
    float wWidth = textWidth(w);
    if (x + wWidth > width - 20) {
      x = 20;
      y += lineHeight;
    }
    textSize(20);
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

