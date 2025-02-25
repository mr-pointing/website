---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - dictionaries
title: Valid Sudoku
date: 2025-02-18
updated: 2025-02-18T12:49
---

-------------------------------------------------------------------------------


***Question:*** You are given a a `9 x 9` Sudoku board `board`. A Sudoku board is valid if the following rules are followed:

1. Each row must contain the digits `1-9` without duplicates.
2. Each column must contain the digits `1-9` without duplicates.
3. Each of the nine `3 x 3` sub-boxes of the grid must contain the digits `1-9` without duplicates.

Return `true` if the Sudoku board is valid, otherwise return `false`


***How to Solve:*** Like any problem, we need to think of what we are trying to do. We are trying to check against duplicates, so we know we are going to probably have to use a set. But how can we ensure we've checked the rows, columns, *and* squares efficiently?

My original theory was to get all the numbers out of each row and column, moving through each one and returning false if we ran into any of the duplicates on the way. I didn't do this very efficiently after looking at the solution, but I was proud I got this far on my own:

```python
def check_dupes(board):  
    for x in range(9):  
        c_row = [int(col) for col in board[x][0:] if col.isnumeric()]  
        c_col = [int(board[row][x]) for row in range(9) if board[row][x].isnumeric()]  
        print(c_col)  
        if len(set(c_row)) != len([z for z in c_row if z != "."]) or len(set(c_col)) != len(  
                [z for z in c_col if z != "."]):  
            return False  
  
    return True
```

My thought was the sum of the numbers didn't matter, just the occurences, but I thought a little too little and went for length of the set instead of appearance in the set as the determining factor. This makes my code really long and harder to read, since I need to turn everything into a numerical list, then get the set of both, and check if they're the same length as the list without all the periods. Not super efficient.

Then I had to tackle actually getting the squares. I was stumped on this for a bit, but I found a way to actually get all of the squares:

```python
for j in range(0, 7, 3):  
    for x in range(3):  
        print(board[x][j:j+3])  
    print("\n")  
    for x in range(3, 6):  
        print(board[x][j:j+3])  
    print("\n")  
    for x in range(6, 9):  
        print(board[x][j:j+3])
```

Again, not the most efficient at all. I honestly didn't realize what I should have done was set up a hash set, or a dictionary with sets as all the values. The columns, rows, and squares would have their own hash set, and a neat way to keep your squares separated is using `//3` against the indicies:

```python
class Solution:
    def isValidSudoku(self, board: List[List[str]]) -> bool:
        cols = defaultdict(set)
        rows = defaultdict(set)
        squares = defaultdict(set)  

        for r in range(9):
            for c in range(9):
                if board[r][c] == ".":
                    continue
                if ( board[r][c] in rows[r]
                    or board[r][c] in cols[c]
                    or board[r][c] in squares[(r // 3, c // 3)]):
                    return False

                cols[c].add(board[r][c])
                rows[r].add(board[r][c])
                squares[(r // 3, c // 3)].add(board[r][c])

        return True
```