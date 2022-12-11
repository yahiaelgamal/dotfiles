libraries = c('ggplot2',
              'dplyr',
              'readr',
              'scales',
              'glue',
              'plotly',
              'lintr',
              'styler',
)

# TODO install libraries if not installed already

# load libraries
library(ggplot2)
library(dplyr)
library(readr)
library(scales)
library(glue)
library(plotly)

angled_x_axis = function(angle=60){
  theme(axis.text.x = element_text(angle = angle, hjust = 1))
}

# This method calculates the avg cardinality (cardinality being how many values does
# one value in column c1 coexist in column c2). If the avg cardinality is
# 1, it means that c2 is a subset of c1
# if you look at the lower half (under the diagonal). You will see what columns
# strictly coexist with one value (so you can derive hierarchical structure
# Note that the matrix is NOT symmetric.
# Note that because we of naming conflicts, numbers that are very close to 1
# (maybe) should be considered as hierarchical. As there might be naming conflicts
avg_cardinality_matrix = function(df){
  avg_cardinality = list()
  for(c1 in colnames(df)){
    avg_cardinality[[c1]] = list()
    for(c2 in colnames(df)){
      cc = df %>%  group_by(!!sym(c1)) %>%  summarise(!!sym(paste0('len_', c2)):=length(unique(!!sym(c2))))
      avg_cardinality[[c1]][c2] = mean(cc[[2]])
    }
  }
  mm = as.matrix(avg_cardinality)
  mm_unlisted = mapply(as.list, mm)
  colnames(mm_unlisted) = rownames(mm_unlisted)
  mat = t(mm_unlisted)
  avg_cardinality_list  = apply(mat, 1, function(x){mean(unlist(x))})
  sorted_indices = sort(avg_cardinality_list, decreasing=T, index.return=T)$ix
  return(mat[sorted_indices, sorted_indices])
}

#m = avg_cardinality_matrix(df2[1:3])
