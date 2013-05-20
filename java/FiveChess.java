import java.util.Arrays;
import java.util.Scanner;

public class FiveChess {
    private static final int CELL = 16;
    private static final char CELL_CHAR = '\u253C';
    private char[][] cells;
    private boolean turn;//true:黑;false:白
    
    public FiveChess() {
        cells = new char[FiveChess.CELL][FiveChess.CELL];
        for (int i=0; i<cells.length; i++) {
            Arrays.fill(cells[i],FiveChess.CELL_CHAR);
        }
        turn = true;
    }
    
    public void printCells() {
        System.out.print("  ");
        for (int i=0; i<FiveChess.CELL; i++) {
            System.out.print((char)(i+'a')+" ");
        }
        System.out.println();
        for (int i=0; i<FiveChess.CELL; i++) {
            for (int j=0; j<FiveChess.CELL; j++) {
                if (j==0) {
                    System.out.print((char)(i+'a')+" ");
                }
                System.out.print(cells[i][j]+" ");
            }
            System.out.println();
        }
    }
    
    public boolean downChess(int row, int column) {
        boolean flag = true;
        if (row >= FiveChess.CELL || row <0
                || column >= FiveChess.CELL || column <0) {
            System.out.println("输入有误,请重新输入!");
            flag = false;
        } else {
            if (cells[row][column] != FiveChess.CELL_CHAR) {
                System.out.println("输入位已落子,请重新输入!");
                flag = false;
            } else {
                cells[row][column] = turn?'@':'o';
            }
        }
        return flag;
    }
    
    public boolean isWin(int row, int column) {
        boolean isWin = false;
        char curChess = turn?'@':'o';
        if (this.isHorizontalWin(row, column, curChess)
                || this.isVerticalWin(row, column, curChess)
                || this.isLeftObliqueDownWin(row, column, curChess)
                || this.isLeftObliqueUpWin(row, column, curChess)) {
            isWin = true;
        }
        return isWin;
    }
    
    public boolean isHorizontalWin(int row, int column, char curChess) {
        boolean isWin = false;
        int count = 0;
        for (int c = column-1; c>=0; c--) {
            if (cells[row][c] == curChess) {
                count++;
            } else {
                break;
            }
        }
        for (int c = column+1; c<FiveChess.CELL; c++) {
            if (cells[row][c] == curChess) {
                count++;
            } else {
                break;
            }
        }
        System.out.println("horizontal count :"+ count);
        if (count >=4) {
            isWin = true;
        }
        return isWin;
    }
    
    public boolean isVerticalWin(int row, int column, char curChess) {
        boolean isWin = false;
        
        return isWin;
    }
    
    public boolean isLeftObliqueDownWin(int row, int column, char curChess) {
        boolean isWin = false;
        return isWin;
    }
    
    public boolean isLeftObliqueUpWin(int row, int column, char curChess) {
        boolean isWin = false;
        int count = 0;
        for (int r = row-1, c = column-1; r>=0 && c>=0; r--, c--){
            if (cells[r][c] == curChess) {
                count++;
            } else {
                break;
            }
        }
        if (count >=4) {
            isWin = true;
        }
        return isWin;
    }
    
    public void console() {
        Scanner scanner = new Scanner(System.in);
        System.out.println("欢迎使用山寨版五子棋!");
        while( true ) {
            printCells();
            System.out.println("请 ["+(turn?"黑":"白")+"] 方落子");
            String command = scanner.next();
            if (command.equalsIgnoreCase("quit")) {
                System.out.println("谢谢使用,再见!");
                break;
            } else {
                int row = command.charAt(0)-'a';
                int column = command.charAt(1)-'a';
                boolean isDown = downChess(row, column);
                if (!isDown) 
                    continue;
                boolean isWin = isWin(row, column);
                if (isWin) {
                    printCells();
                    System.out.println("["+(turn?"黑":"白")+"] 方获胜,游戏结束!");
                    break;
                } else {
                    turn = !turn;
                }
            }
        }
    }
    
    public static void main(String[] args) {
        FiveChess chess = new FiveChess();
        chess.console();
    }
}
