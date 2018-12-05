library(ggplot2)

angled_x_axis = function(angle=60){
  theme(axis.text.x = element_text(angle = angle, hjust = 1))
}

