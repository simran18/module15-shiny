# Load the shiny and ggplot2 libraries
library(shiny)
library(ggplot2)

# Define a server function


  # Create a `reactiveValues()` variable


  # Assign a key `selected.class` to the reactiveValue with a default value of ""


  # Render the `milage` plot output


    # Return a ggplot Scatterplot for the `mpg` dataset, with `displ` on the x and `hwy` on the y axis
    # Color each point by whether the `class` is %in% the `selected.class` reactive value
    # Add `guides()` so that the `color` legend is not shown (FALSE)



  # Render the `selected` text output


    # Return the (text) value of the reactiveValue



  # Use `observeEvent()` to respond to plot clicks


    # Use `nearPoints()` to get selected rows in the `mpg` data set


    # Satore `unique()` values from the `class` feature of the selected rows
    # in the `selected.class` reactiveValue


  # Bonus: also use `observeEvent()` to respond to brushing and change the plot in a different way!


# call `shinyServer()` to create the server out of your server function
