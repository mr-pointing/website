---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - arrays
title: Contains Duplicate
date: 2024-09-18
updated: 2024-09-18T18:55
---

-------------------------------------------------------------------------------


***Question:*** Given an integer array `nums`, return `true` if any value appears **more than once** in the array, otherwise return `false`.

***How to Solve:*** We can create a secondary list that we can start to throw the values from our array `nums` into, and check to see if they already exist in the list or not. As soon as we enter a number that already exists in our list, it will return `True` and end. If it goes through the entire `nums` array without breaking, our list has no duplicates, and we can return `False`.

***Answer:***

```python
def hasDuplicate(nums: List[int]) -> bool:
        num_list = []
        for num in nums:
            if num not in num_list:
                num_list.append(num)
            else:
                return True
        return False
```

