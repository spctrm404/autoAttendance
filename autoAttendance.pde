import java.awt.Color;
import java.awt.Robot;
import java.awt.event.InputEvent;
Robot r;

int[] tColor = {245, 66, 125};

int[][] seqA = {
  {1746, 206, 255, 255, 255}, // 로딩체크
  {1746, 166, 16, 54, 119}, // 검색 버튼
  {1550, 351, tColor[0], tColor[1], tColor[2], 147}, // 출결입장 버튼
  {1206, 247, 47, 49, 58} // 다음날짜 버튼
};

int[][] seqB = {
  {288, 493, 18, 140, 225}, // 로딩체크
  {1573, 202, 255, 255, 255}, // 호명 버튼
  {1490, 244, 16, 160, 247}, // 출결시작 버튼
  {907, 789, 18, 140, 225}, // 시작확인 버튼
  {288, 493, 18, 140, 225}, // 전체출석 버튼
  {1046, 163, 138, 180, 248}, // 전체확인 버튼
  {1490, 244, 252, 65, 92}, // 완료 버튼
  {1046, 183, 138, 180, 248}, // 완료확인 버튼
  {1118, 163, 138, 180, 248}, // 출석확인 버튼
  {1730, 244, 46, 49, 58} // 목록 버튼
};

boolean colorChk (int _x, int _y, int _critR, int _critG, int _critB) {
  Color c = r.getPixelColor(_x, _y);
  if (c.getRed() == _critR 
    && c.getGreen() == _critG 
    && c.getBlue() == _critB) {
    return true;
  }
  return false;
}

void loop(int _lastMillis, int times) {
  int[] dataARoot = seqA[0];
  int lastMillis = _lastMillis;
  int stpA = 0;
  int nthClass = 0;
  int cnt = 0;
  while (cnt < times) {
    stpA = stpA % seqA.length;
    int[] dataA = seqA[stpA];
    if (stpA == 0) {
      if (millis() - lastMillis > 1000) {
        if (colorChk(dataARoot[0], dataARoot[1], 
          dataARoot[2], dataARoot[3], dataARoot[4])) {
          lastMillis = millis();
          stpA++;
          println("cnt:"+ cnt);
          println("loading");
        }
      }
    } else if (stpA == 1) {
      if (millis() - lastMillis > 1000) {
        if (colorChk(dataARoot[0], dataARoot[1], 
          dataARoot[2], dataARoot[3], dataARoot[4])) { 
          r.mouseMove(dataA[0], dataA[1]);
          r.mousePress(InputEvent.BUTTON1_MASK);
          r.mouseRelease(InputEvent.BUTTON1_MASK);
          nthClass = 0;
          lastMillis = millis();
          stpA++;
          println("search");
        }
      }
    } else if (stpA == 2) {
      if (millis() - lastMillis > 1000) {
        if (colorChk(dataARoot[0], dataARoot[1], 
          dataARoot[2], dataARoot[3], dataARoot[4])) { 
          if (colorChk(dataA[0], dataA[1] + dataA[5] * nthClass, 
            dataA[2], dataA[3], dataA[4])) { 
            r.mouseMove(dataA[0], dataA[1] + dataA[5] * nthClass);
            r.mousePress(InputEvent.BUTTON1_MASK);
            r.mouseRelease(InputEvent.BUTTON1_MASK);
            println("enter");
            loopInLoop(millis());
            stpA = 0;
            lastMillis = millis();
          } else if (colorChk(dataA[0], dataA[1] + dataA[5] * nthClass, 
            255, 255, 255)) { 
            lastMillis = millis();
            stpA++;
            println("no more");
          } else {
            nthClass++;
            println("pass");
          }
        }
      }
    } else if (stpA == 3) {
      if (millis() - lastMillis > 1000) {
        if (colorChk(dataARoot[0], dataARoot[1], 
          dataARoot[2], dataARoot[3], dataARoot[4])) { 
          r.mouseMove(dataA[0], dataA[1]);
          r.mousePress(InputEvent.BUTTON1_MASK);
          r.mouseRelease(InputEvent.BUTTON1_MASK);
          lastMillis = millis();
          stpA++;
          cnt++;
          println("next day");
        }
      }
    }
  }
}

void loopInLoop(int _lastMillis) {
  int[] dataBRoot = seqB[0];
  int lastMillis = _lastMillis;
  int stpB = 0;
  while (stpB < seqB.length) {
    int[] dataB = seqB[stpB];
    if (stpB == 0) {
      if (millis() - lastMillis > 1000) {
        if (colorChk(dataBRoot[0], dataBRoot[1], 
          dataBRoot[2], dataBRoot[3], dataBRoot[4])) {
          lastMillis = millis();
          stpB++;
          println("loading");
        }
      }
    } else if (stpB == 1) {
      if (millis() - lastMillis > 1000) {
        if (colorChk(dataBRoot[0], dataBRoot[1], 
          dataBRoot[2], dataBRoot[3], dataBRoot[4])) {
          r.mouseMove(dataB[0], dataB[1]);
          r.mousePress(InputEvent.BUTTON1_MASK);
          r.mouseRelease(InputEvent.BUTTON1_MASK);
          lastMillis = millis();
          stpB++;
          println("by call");
        }
      }
    } else if (stpB == 2) {
      if (millis() - lastMillis > 1000) {
        if (colorChk(dataBRoot[0], dataBRoot[1], 
          dataBRoot[2], dataBRoot[3], dataBRoot[4])) {
          r.mouseMove(dataB[0], dataB[1]);
          r.mousePress(InputEvent.BUTTON1_MASK);
          r.mouseRelease(InputEvent.BUTTON1_MASK);
          lastMillis = millis();
          stpB++;
          println("start");
        }
      }
    } else if (stpB == 3) {
      if (millis() - lastMillis > 1000) {
        if (colorChk(dataB[0], dataB[1], 
          dataB[2], dataB[3], dataB[4])) {
          r.mouseMove(dataB[0], dataB[1]);
          r.mousePress(InputEvent.BUTTON1_MASK);
          r.mouseRelease(InputEvent.BUTTON1_MASK);
          lastMillis = millis();
          stpB++;
          println("check start");
        }
      }
    } else if (stpB == 4) {
      if (millis() - lastMillis > 1000) {
        if (colorChk(dataBRoot[0], dataBRoot[1], 
          dataBRoot[2], dataBRoot[3], dataBRoot[4])) {
          r.mouseMove(dataB[0], dataB[1]);
          r.mousePress(InputEvent.BUTTON1_MASK);
          r.mouseRelease(InputEvent.BUTTON1_MASK);
          lastMillis = millis();
          stpB++;
          println("apply all");
        }
      }
    } else if (stpB == 5) {
      if (millis() - lastMillis > 1000) {
        if (colorChk(dataB[0], dataB[1], 
          dataB[2], dataB[3], dataB[4])) {
          r.mouseMove(dataB[0], dataB[1]);
          r.mousePress(InputEvent.BUTTON1_MASK);
          r.mouseRelease(InputEvent.BUTTON1_MASK);
          lastMillis = millis();
          stpB++;
          println("check apply all");
        }
      }
    } else if (stpB == 6) {
      if (millis() - lastMillis > 1000) {
        if (colorChk(dataBRoot[0], dataBRoot[1], 
          dataBRoot[2], dataBRoot[3], dataBRoot[4])) {
          r.mouseMove(dataB[0], dataB[1]);
          r.mousePress(InputEvent.BUTTON1_MASK);
          r.mouseRelease(InputEvent.BUTTON1_MASK);
          lastMillis = millis();
          stpB++;
          println("done");
        }
      }
    } else if (stpB == 7) {
      if (millis() - lastMillis > 1000) {
        if (colorChk(dataB[0], dataB[1], 
          dataB[2], dataB[3], dataB[4])) {
          r.mouseMove(dataB[0], dataB[1]);
          r.mousePress(InputEvent.BUTTON1_MASK);
          r.mouseRelease(InputEvent.BUTTON1_MASK);
          lastMillis = millis();
          stpB++;
          println("check done");
        }
      }
    } else if (stpB == 8) {
      if (millis() - lastMillis > 1000) {
        if (colorChk(dataB[0], dataB[1], 
          dataB[2], dataB[3], dataB[4])) {
          r.mouseMove(dataB[0], dataB[1]);
          r.mousePress(InputEvent.BUTTON1_MASK);
          r.mouseRelease(InputEvent.BUTTON1_MASK);
          lastMillis = millis();
          stpB++;
          println("check check done");
        }
      }
    } else if (stpB == 9) {
      if (millis() - lastMillis > 1000) {
        if (colorChk(dataBRoot[0], dataBRoot[1], 
          dataBRoot[2], dataBRoot[3], dataBRoot[4])) {
          r.mouseMove(dataB[0], dataB[1]);
          r.mousePress(InputEvent.BUTTON1_MASK);
          r.mouseRelease(InputEvent.BUTTON1_MASK);
          lastMillis = millis();
          stpB++;
          println("to list");
        }
      }
    }
  }
}

void setup() {
  size(300, 300);
  try {
    r = new Robot();
    r.setAutoDelay(1);
  } 
  catch(Exception e) {
    e.printStackTrace();
  }
  loop(millis(), 7 * 16);
}
