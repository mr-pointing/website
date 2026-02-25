---
aliases:
draft: false
tags:
  - computerscience
  - textbook
  - html
title: HTML & CSS - Chapter 6
date: 2026-02-03
updated: 2026-02-12T11:50
---

-------------------------------------------------------------------------------

# Tables

Another staple of HTML pages, tables are used all over the place. Some pages like stock websites or sports information is full of tables, while some might have one or two for a calendar or schedule. Pretty much anytime we have complex data that needs to be displayed, columns and rows are the way to go in most cases. We also call it a *grid format*, with each box of the grid being a *table cell*. 

## Syntax

Every table starts with a `table` tag, that acts like our other container-type tags (think of `body`, `head`, and `ul` or `ol`).  The table is made up of another container type tag, `tr`, which creates each individual row of the table. Then, for each column, you populate it with a `td` tag, that you put the content of that table cell into. A bit confusing at first, but here's a basic example;

```html
<table>
	<tr>
		<td>1</td>
		<td>2</td>
		<td>3</td>
	</tr>
	<tr>
		<td>2</td>
		<td>4</td>
		<td>6</td>
	</tr>
	<tr>
		<td>3</td>
		<td>6</td>
		<td>9</td>
	</tr>
</table>
```

Since this is the most complex structure we've seen so far, be sure to play around with the layout to ensure you understand what's going on. Depending on which browser you're using, you might have table borders, which are just lines that separate each table cell. Some browsers do, some don't. We'll learn how to control the look of our tables in the CSS portion of this text.

Most of the time, just content in a grid format is not enough. We should properly describe the content in each row and column, with table headers. The best way to do this is a little weird, so let's look at an example first then talk about it;

```html
<table>
	<tr>
		<th></th>
		<th scope="col">1</th>
		<th scope="col">2</th>
		<th scope="col">3</th>
	</tr>
	<tr>
		<th scope="row">1</th> 
		<td>1</td>
		<td>2</td>
		<td>3</td>
	</tr>
	<tr>
		<th scope="row">2</th>
		<td>2</td>
		<td>4</td>
		<td>6</td>
	</tr>
	<tr>
		<th scope="row">3</th>
		<td>3</td>
		<td>6</td>
		<td>9</td>
	</tr>
</table>
```

So here's what we did; if you couldn't tell already, our table is a multiplication table. We used table headers to describe the number we're multiplying. One thing you should be aware of immediately is that we added a whole row at the beginning full of headers. We even left the first one empty, which is hard to understand why until you see it used, where the top most left cell should ALWAYS be empty when using headers.

## Spanning Rows and Columns

These are mostly used in schedule creation, but you might have to make one for your portfolio so we should go over how to do this. If you pass in a special attribute called `colspan` or `rowspan` with a number, the table cell will take up that numerical amount of columns or rows, respectfully. 

```html
<table>
	<tr>
		<th></th>
		<th>9am</th>
		<th>10am</th>
		<th>11am</th>
		<th>12am</th>
	</tr>
	<tr>
		<th>Monday</th>
		<td colspan="2">Geography</td>
		<td>Math</td>
		<td>Art</td>
	</tr>
	<tr>
		<th>Tuesday</th>
		<td colspan="3">Gym</td>
		<td>Computer Science</td>
	</tr>
</table>
```

## Long Tables

If you have enough content that requires maybe 10 or more rows, you might want to consider using a long table. They are set up extremely similar ways, but with a few more tags to keep things organized. We use `thead` tags to contain the header, `tbody` to contain the body, and `tfoot` for the footer or end result of the table. These are best used with calculations, since the footer can act like a summation row.

```html
<table>
	<thead>
		<tr>
			<th>Date</th>
			<th>Income</th>
			<th>Expenditure</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>1st January</th>
			<td>250</td>
			<td>36</td>
		</tr>
		<tr>
			<th>2nd January</th>
			<td>285</td>
			<td>48</td>
		</tr>
		<!-- extra content -->
		<tr>
			<th>31st January</th>
			<td>129</td>
			<td>64</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td></td>
			<td>7824</td>
			<td>1241</td>
		</tr>
	</tfoot>
</table>
```

## Summary

- Tables should be used to contain grid-formatted content
- Each table is drawn row by row with `tr`
- Each table cell is drawn with `td`

---
Next: 
[Chapter 7]({{< ref "HTML & CSS - Chapter 7" >}}) 
