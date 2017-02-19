# Load the shiny, ggplot2, and dplyr libraries


# You will once again be working with the `diamonds` data set provided by ggplot2
# Use dplyr's `sample_n()` function to get a random 3000 rows from the data set
# Store this sample in a variable `diamonds.sample`


# For convenience store the `range()` of values for the `price` and `carat` values
# for the ENTIRE diamonds dataset.



# Define a UI using a fluidPage layout


  # Include a `titlePanel` with the title "Diamond Viewer"


  # Include a `sidebarLayout()`


    # The `siderbarPanel()` should have the following control widgets:


      # A sliderInput labeled "Price (in dollars)". This slider should let the user pick a range
      # between the minimum and maximum price of the entire diamond data set


      # A sliderInput labeled "Carats". This slider should let the user pick a range
      # between the minimum and maximum carats of the entire diamond data set


      # A checkboxInput labeled "Show Trendline". It's default value should be TRUE


      # A slectInput labeled "Facet By", with choices "cut", "clarity" and "color"



    # The `mainPanel()` should have the following reactive outputs:


      # A plotOutput showing a plot based on the user specifications


      # Bonus: a dataTableOutput showing a data table of relevant observations



# Define a Server function for the app


  # Assign a reactive `renderPlot()` function to the outputted `plot`


    # This function should take the `diamonds.sample` data set and filter it by the
    # input price and carat ranges.
    # Hint: use dplyr and multiple `filter()` operations

    # The filtered data set should then be used in a ggplot2 scatter plot with the
    # carat on the x-axis, the price on the y-axis, and color based on the clarity
    # You should specify facets based on what feature the user selected to "facet by"
    #   (hint: you can just pass that string to the `facet_wrap()` function!)


    # Finally, if the "trendline" checkbox is selected, you should also include a
    # geom_smooth geometry (with `se=FALSE`)
    # Hint: you'll need to use an `if` statement, and save the `ggplot` as a variable
    #      that you can then add the geom to.
    # Be sure and return the completed plot!




  # Bonus: Assign a reactive `renderDataTable()` function to the outputted table
  # You may want to use a `reactive()` variable to avoid needing to filter the data twice!


# Create a new `shinyApp()` using the above ui and server


## Double Bonus: For fun, can you make a similar browser for the `mpg` data set?
## it makes the bonus data table a lot more useful
