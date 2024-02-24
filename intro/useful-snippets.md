### Sorting a dataset by indexing on a key column
```
idx <- order(data$column) # Get order of rows
sorted <- data[idx,]      # Select data in sorted order
```

### Removing elements from a list without modifying the list itself
##### Using negative slices
```
stripped<-list[-n]          # Removes element number n
stripped<-list[-c(k, j)]    # Removes element k and j
```
##### Using comparison
```
stripped<-list[list (logical operator) "k"]   # Removes elements that are (=, !=, <, >) to k
```
