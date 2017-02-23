# Load the shiny and ggplot2 libraries
library(shiny)
library(ggplot2)

# Define a server function
server <- function(input, output) {
  
  # Create a `reactiveValues()` variable
  data <- reactiveValues()
  
  # Assign a key `selected.class` to the reactiveValue with a default value of ""
  data$selected.class <- ""  # assign a default value
  
  # Render the `milage` plot output
  output$milage <- renderPlot({
    
    # Return a ggplot Scatterplot for the `mpg` dataset, with `displ` on the x and `hwy` on the y axis
    # Color each point by whether the `class` is %in% the `selected.class` reactive value
    # Add `guides()` so that the `color` legend is not shown (FALSE)
    ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
      geom_point(aes(color=(class %in% data$selected.class)), size=5) +
      guides(color=FALSE)
  })
  
  # Render the `selected` text output
  output$selected <- renderText({
    
    # Return the (text) value of the reactiveValue
    return(data$selected.class)
  })
  
  # Use `observeEvent()` to respond to plot clicks
  observeEvent(input$plot_click, {
    
    # Use `nearPoints()` to get selected rows in the `mpg` data set
    selected <- nearPoints(mpg, input$plot_click)
    
    # Satore `unique()` values from the `class` feature of the selected rows
    # in the `selected.class` reactiveValue
    data$selected.class <- unique(selected$class)
  })
  
  # Bonus: also use `observeEvent()` to respond to brushing and change the plot in a different way!
  
}

# call `shinyServer()` to create the server out of your server function
shinyServer(server)