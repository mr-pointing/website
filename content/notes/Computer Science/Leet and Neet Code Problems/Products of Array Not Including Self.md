---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - arrays
title: Products of Array Not Including Self
date: 2024-10-12
updated: 2024-10-12T13:17
---

-------------------------------------------------------------------------------


***Question:*** Given an integer array `nums`, return an array `output` where `output[i]` is the product of all the elements of `nums` except `nums[i]`.

***How to Solve:*** I originally thought I had an awesome solution, but it only passed with the first test case that didn't have zeros: 

```python
def productExceptSelf(self, nums: List[int]) -> List[int]:
        total = nums[0] * nums[1]
        ans = []
        i = 2

        while i < len(nums):
            total *= nums[i]
            i += 1
        for num in nums:
            if num != 0:
                ans.append(int(total/num))
            else:
                ans.append(total)

        return ans
```

My issue began when there were 0's to worry about. I spent a decent amount of time on this so I just decided to look at the answer below and I'll dissect it after:

```python
class Solution:
    def productExceptSelf(self, nums: List[int]) -> List[int]:
        prod, zero_cnt = 1, 0
        for num in nums:
            if num:
                prod *= num
            else:
                zero_cnt +=  1
        if zero_cnt > 1: return [0] * len(nums)

        res = [0] * len(nums)
        for i, c in enumerate(nums):
            if zero_cnt: res[i] = 0 if c else prod
            else: res[i] = prod // c
        return res
```

Let's start off with the first line, creating `prod` and `zero_cnt`. One will keep our total product, and the other how many zero's in the list, respectively.

Then, we move through the `nums` and check to make sure the number isn't zero. If it is, we iterate `zero_cnt` up by 1, otherwise multiply by `prod` to keep generating total.

If there are more than 1 zero, we just return a list of 0's. Otherwise, We begin to enumerate through `nums` to keep an eye on the location for our return list, `res`, and compare the actual value of `nums`.

The `if` statement uses this logic: if there is a zero in the list, then the only time we are going to get an output ***NOT*** 0, it would be in the position where there ***IS*** a 0. If there isn't a zero it will just divide `prod` by `c`, which will return the product of every other element not including `c`. 