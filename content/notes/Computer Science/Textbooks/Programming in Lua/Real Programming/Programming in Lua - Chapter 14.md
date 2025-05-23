---
aliases: 
draft: true
tags:
  - computerscience
  - textbook
  - lua
title: Programming in Lua - Chapter 14
date: 2025-05-04
updated: 2025-05-04T13:12
---

-------------------------------------------------------------------------------

# Data Structures

As we know, Lua just has tables. Within this, we can arrange tables in numerous different fashions to create whatever data structure we need. Since tables work so well, some of these aren't entirely necessary but can be done.

## Arrays

To accomplish the array structure, we can do something we've done previously; create a table with numbered indexes. Super simple to accomplish.

```lua
a = {}
for i=1, 100 do
  a[i] = 0
end
```

The above creates an array with a range of 1 to 100, and any call to a field out of that range will return `nil`. We can find the length of `a` easily with `#a`. A one liner version for an array type of table is accomplished with any set of numbers like so;

```lua
a = {1, 2, 4, 6, 10, 16, 26}
```

## Matrices and Multi-Dimensional Arrays

Lua has two methods of creating matrices; an array of arrays or combining two indices into one. For the first one;

```lua
local mt = {}
for i = 1, N do
  local row = {}
  mt[i] = row
  for j = 1, M do
    row[j] = 0
  end
end
```

For the second;

```lua
local mt = {}
for i = 1, N do
  local aux = (i - 1) * M
  for j = 1, M do
    mt[aux + j] = 0
  end
end
```

Lua creates naturally *sparse matricies*, since we are using tables. For a graph of ten thousand nodes which 5 neighbors, leading to a hundred million entries, we would need ten thousand tables with 5 elements for the first method, and only a single table with fifty thousand entries.

Length operators can't be used on these structures accurately, but we can accomplish pretty easy mathematical operations;

```lua
for i = 1, M do
  for j = 1, N do
    c[i][j] = 0
    for k = 1, K do
      c[i][j] = c[i][j] + a[i][k] * b[k][j]
    end
  end
end
```

The above would not work on sparse matrix; the reason being that the inner loop doesn't function the way we need to. It's a simple fix for sparse matrices;

```lua
for i = 1, M do
  for k = 1, K do
    for j = 1, N do
      c[i][j] = c[i][j] + a[i][k] * b[k][j]
    end
  end
end
```

## Linked Lists

Another simple to implement structure;

```lua
list = nil
v = "something"
list = {next = list, value = v}
```

To traverse the list;

```lua
local l = list
while l do
  <do something with value>
  l = l.next
end
```

## Queues and Double Ended Queues

Since we already went over `insert` and `remove` in the table library, we know we can accomplish these with a table. The big pain is the process of moving entries over when inserting into a large table. The best way to avoid this is having a pointer to the beginning and end of the table for instant access and easy entry.


## Sets

A good use of sets in Lua are reserved words. The best way is using the value as an index, and setting the value to `True`;

```lua
reserved = {
	["while"] = true,
	["if"] = true,
	["else"] = true,
}

for w in string.gmatch(s, "[%a_][%w_]*") do
  if not reserved[w] then
    <do something>
  end
end
```

We could even write a function to perform this action for us;

```lua
function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

reserved = Set{"while", "if", "else", "do"}
```


## Graphs

Another element needed and necessary for any programming language, and the last one we're going to look at, is unsurprisingly created through tables. Each node in the graph is a table with two fields, the `name` of the node and table of `adjacent` nodes for it's neighbors.

The text offers a pretty thorough example so why not walk through it. If a graph exists in a file, we can use the following to retrieve it;

```lua
function read_graph ()
  local graph = {}
  for line in io.lines() do
    -- splits line into two names
    local namefrom, nameto = string.mathc(line, "(%S+)%s+(%S+)")
    -- find any adjacent nodes
    local from = name2node(graph, namefrom)
    local to = name2node(graph, nameto)
    -- ads 'to' to the adjacent set of 'from'
    from.adj[to] = true
  end
  return graph
end
```

The function `name2node`;

```lua
local function name2node (graph, name)
  local node = graph[name]
  if not node then
    -- node does not exist; create a new one
    node = {name = name, adj = {}}
    graph[name] = node
  end
  return node
end
```

We can even write a function to find the path between two nodes;

```lua
function find_path (curr, to, path, visited)
  path = path or {}
  visited = visited or {}
  if visited[curr] then
    return nil  -- node has already been visited, no path
  end
  visited[curr] = true  -- mark as visited
  path[# path + 1] = curr  -- add to the path
  if curr == to then -- check if final node
    reutrn path
  end
  -- Try all adjacent nodes
  for node in pairs(curr.adj) do
    local p = findpath(node, to, path, visited)
    if p then return p end
  end
  table.remove(path) -- remove node from path
end
```

### Exercises

1. Write a function to add to sparse matrices
2. Modify the queue implementation in Listing 14.2 so that both indices return to 0 when the queue is empty.
3. Modify the graph structure so that it can keep a label for each arc.


---
Next: 
[Chapter 15]({{< ref "Programming in Lua - Chapter 15" >}}) 
