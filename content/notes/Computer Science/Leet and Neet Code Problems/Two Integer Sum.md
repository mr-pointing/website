---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - arrays
title: Two Integer Sum
date: 2024-09-18
updated: 2024-09-21T12:25
---

-------------------------------------------------------------------------------
***Question:*** Given an array of integers `nums` and an integer `target`, return the indices `i` and `j` such that `nums[i] + nums[j] == target` and `i != j`.

You may assume that _every_ input has exactly one pair of indices `i` and `j` that satisfy the condition.

Return the answer with the smaller index first.

***How to Solve:*** We can use a two pointer approach with `i` and `j`. First, we set up a for loop that will iterate `j` from the length of the array to the first position. Then we can use `i` to move through the array forwards. We use a nested while loop with a conditional statement that says if the combination of position `i` and `j` are equal to target, return those positions in `[i, j]` format.

***Answer:***

```python
def twoSum(self, nums: List[int], target: int) -> List[int]:
        for j in range(len(nums) - 1, 0, -1):
            i = 0
            while i < len(nums):
                if nums[i] + nums[j] == target:
                    return [i, j]
                i += 1
```

