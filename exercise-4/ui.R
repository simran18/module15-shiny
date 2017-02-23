# Load the shiny library
library(shiny)

# Define a UI using a `fluidPage()` layout
ui <- fluidPage(
  # declare the page titlePanel to be "Milage by Engine Power"
  titlePanel("Milage by Engine Power"),
  
  # output a plot `milage`, and respond to clicks on the plot
  plotOutput('milage', click = "plot_click"),
  
  # output the word "Highlighting:" followed by a `selected` text output
  p("Highlighting:",  strong(textOutput('selected', inline=TRUE)) )
)

# call `shinyUI()` to create the UI out of your `ui` value
shinyUI(ui)