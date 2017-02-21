# load the "shiny" library as well as any other libraries you will need
library(shiny)
library(ggplot2)
library(dplyr)

# load the `msleep` data set and store it in `animal.sleep`
# do a google search to find function that can keep only rows that don't
# have any values missing


# View it to learn more about it


# Define a new `ui` variable. This variable should be assigned a `fluidPage` layout


  #Include a `titlepanel` of "Mammals and thier Sleep"


  # Include a paragraph introducing the data

  # Select a panel. In that panel have `selectInput` that will allow someone
  # to go through the diffrent types of of choices such as `vore`, `order`, `conservation`
  # Add another way to interact with the data
  # Add a `submitButton` so all changes occur together
  # What are benefits of using the submit button vs not?


  # include a concluding paragraph about the data after making the plot. What are
  # some trends in the data you notice? Be aware that you filtered the data set!

# Define a server function for the app



  # assign a `renderPlot` to `output$plot`


    # The filtered data set should then be used in a ggplot2 scatter plot with the
    # sleep_total on the x-axis, the sleep_rem on the y-axis, and color based on the vore
    # You should specify facets based on what feature the user selected to "facet by"
    #   (hint: you can just pass that string to the `facet_wrap()` function!)


# Create a new `shinyApp()` using the above ui and server


#Bonus: use the whole msleep data set and see what conclusions you can draw. Do they
# support your original conclusions?

# Bonus bonus: add a radio button to in shiny that will add another layer of interaction
