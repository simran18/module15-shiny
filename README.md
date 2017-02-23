# Module 15: Shiny

Adding **interactivity** to a data report is a highly effective way of communication that information and enabling users to explore a data set. In this module you will learn about the **Shiny** framework for building interactive applications in R. Shiny provides a structure for communicating between a user-interface (i.e., a web-browser) and an R session, allowing users to interactively change the "code" that is run and the data that are outputted. This not only enables developers to create interactive graphics, but provides a way for users to interact directly with a R session (without writing any code!).

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Contents**

- [Resources](#resources)
- [Shiny Applications](#shiny-applications)
  - [Application Structure](#application-structure)
    - [Combining UI and Server](#combining-ui-and-server)
  - [The UI](#the-ui)
    - [Control Widgets and Reactive Outputs](#control-widgets-and-reactive-outputs)
  - [The Server](#the-server)
    - [Multiple Views](#multiple-views)
- [Publishing Shiny Apps](#publishing-shiny-apps)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Resources
- [Shiny Documentation](http://shiny.rstudio.com/articles/)
- [Shiny Basics Article](http://shiny.rstudio.com/articles/basics.html)
- [Shiny Tutorial](http://shiny.rstudio.com/tutorial/) (video; links to text at bottom)
- [Shiny Cheatsheet](https://www.rstudio.com/wp-content/uploads/2016/01/shiny-cheatsheet.pdf)
- [Shiny Example Gallery](http://shiny.rstudio.com/gallery/)
- [shinyapps.io User Guide](http://docs.rstudio.com/shinyapps.io/index.html)
- [Interactive Plots with Shiny](http://shiny.rstudio.com/articles/plot-interaction.html) (see also [here](https://blog.rstudio.org/2015/06/16/shiny-0-12-interactive-plots-with-ggplot2/))
- [Interactive Docs with Shiny](https://shiny.rstudio.com/articles/interactive-docs.html)


## Shiny Applications
Shiny is a **web application framework for R**. As opposed to a simple (static) web page like you've created with R Markdown, a _web application_ is an interactive, dynamic web page---the user can click on buttons, check boxes, or input text in order to change the presentation of the data. Shiny is a _framekwork_ in it provides the "code" for producing an enabling this interaction, while you as the developer simply "fill in the blanks" by providing _variables_ or _functions_ that the provided code will utilize to create the interactive page.

`shiny` is another external package (like `dplyr` and `ggplot2`), so you will need to install and load it in order to use it:

```r
install.packages("shiny")  # once per machine
library("shiny")
```

This will make all of the framework functions and variables you will need to worth with available.

### Application Structure
Shiny applications are divided into two parts:

1. The **User Interface (UI)** defines how the application will be _displayed_ in the browser. The UI can render R content such as text or graphics just like R Markdown, but it can also include **widgets**, which are interactive controls for your application (think buttons or sliders). The UI can also specify a **layout** for these components (e.g., so you can put widgets above, below, or beside one another).

  The UI for a Shiny application is defined as a **value**, usually one returned from calling a **layout function**. For example:

  ```r
  # The ui is the result of calling the `fluidPage()` layout function
  my.ui <- fluidPage(
    # A widget: a text input box (save input in the `username` key)
    textInput('username', label="What is your name?"),

    # An output element: a text output (for the `message` key)
    textOutput('message')
  )
  ```

  This UI defines a [fluidPage](https://shiny.rstudio.com/reference/shiny/latest/fluidPage.html) (where the content flows "fluidly" down the page), that contains two _content elements_: a text input box where the user can type their name, and some outputted text based on the `message` variable.

2. The **Server** defines the data that will be displayed on the UI and that the user can interact with. You can think of this as an interactive R script that the user will be able to "run": the script will take in _inputs_ from the user (based on their interactions) and provide _outputs_ that the UI will then display. The server users **reactive expressions**, which are like functions that will automatically be re-run whenever the input changes. This allows the output to be dynamic and enablling interactivity.

  The Server for a Shiny application is defined as a **function** (as opposed to the UI which is a _value_). This function takes in two _lists_ as argments: an `input` and `output`. It then uses _render functions_ and _reactive expressions_ that assign values to the `output` list based on the `input` list. For example:

  ```r
  # The server is a function that takes `input` and `output` args
  my.server <- function(input, output) {
    # assign a value to the `message` key in `output`
    # parameter is a reactive expression for showing text
    output$message <- renderText({
      # use the `username` key from input and and return new value
      # for the `message` key in output
      return(paste("Hello", input$username))
    })
  })
  ```

Combined, this UI and server will allow the user to type their name into an input box, and will then say hello to whatever name is typed in.

More details about the UI and server components can be found in the sections below.

#### Combining UI and Server
There are two ways of combining the UI and server.

The first (newer) way is to define a file called **`app.R`**. This file should calls the [**`shinyApp()`**](http://shiny.rstudio.com/reference/shiny/latest/shinyApp.html) function, which takes a UI value and Server function as arguments. For example:

```r
# pass in the variables defined above
shinyApp(ui = my.ui, server = my.server)
```

Executing the `shinyApp()` function will start the App (you can also click the "Run App" button at the top of R Studio).

- Note: if you change the UI or the server, you do **not** need to stop and start the app; you can simply refresh the browser or viewer window and it will reload with the new UI and server.

- If you need to stop the App, you can hit the "Stop Sign" icon on the RStudio console.

Using this function allows you to define your entire application (UI and server) in a single file (which **must** be named `app.R`). This approach is good for simple applications that you wish to be able to share with others, since the entire application code can be listed in a single file.

However, it is also possible to define the UI and server as _separate_ files. This allows you to keep the presentation (UI) separated from the logic (server) of your application, making it easier to maintain and change in the future. Do to this, you define two separate files: **`ui.R`** for the UI and **`server.R`** for the server (the files **must** be named `ui.R` and `server.R`). These files call the functions `shinyUI()` and `shinyServer()` respectively create the UI and server, and then RStudio will automatically combine these files together into an application:

```r
### In ui.R file
my.ui <- fluidPage(
  # define widgets
)

shinyUI(my.ui)
```

```r
### In server.R file
my.server <- function(input, output) {
  # define output reactive expressions
}

shinyServer(my.server)
```

You can then run the app by using the **"Run App"** button at the top of RStudio:

![Run app button](img/run-app.png)

This module will will primarily use the "single file" approach for compactness and readability, but you are encouraged to break up the UI and server into separate files for your own, larger applications.

- Note that it is also possible to simply define the (e.g.) `my.ui` and `my.server` variables in separate files, and then use `source()` to load them into the `app.R` file and pass them into `shinyApp()`.

### The UI
The UI defines how the app will be displayed in the browser. You create a UI by calling a **layout function** such as `fluidPage()`, which will return a UI definition that can be used by the `shinyUI()` or `shinyApp()` functions.

You specify the "content" that you want the layout to contain (and hence the app to show) by passing each **content element** (piece of content) as an _argument_ to that function:

```r
# a "pseudocode" example, calling a function with arguments
ui <- fluidPage(element1, element2, element3)
```

Content elements are defined by calling specific _functions_ that create them: for example `h1()` will create an element that has a first-level heading, `textInput()` will create an element where the user can enter text, and `textOutput` will create an element that can have dynamic (changing) content. Usually these content elements are defined as _nested_ (anonymous) variables, each on their own line:

```r
# still just calling a function with arguments!
ui <- fluidPage(
  h1("My App"),  # first argument
  textInput('username', label="What is your name?"),  # second argument
  textOutput('message')  # third argument
)
```
Note that layout functions _themselves return content elements_, meaning it is possible to include a layout inside another layout. This allows you to create complex layouts by combining multiple layout elements together. For example:

```r
ui <- fluidPage(   # UI is a fluid page
  titlePanel("My Title"),  # include panel with the title (also sets browser title)

  sidebarLayout(   # layout the page in two columns
    sidebarPanel(  # specify content for the "sidebar" column
      p("sidebar panel content goes here")
    ),
    mainPanel(     # specify content for the "main" column
      p("main panel content goes here")
    )
  )
)
```

See the [documentation](http://shiny.rstudio.com/reference/shiny/latest/) and [gallery](http://shiny.rstudio.com/gallery/) for details and examples of doing complex application layouts.

- Fun Fact: much of Shiny's styling and layout structure is based on the [Bootstrap](http://getbootstrap.com/) web framework.

You can include _static_ (unchanging) content in a Shiny UI layout&mdash;this is similar to the kinds of content you would write in Markdown (rather than inline R) when using R Markdown. However, you usually don't specify this content using Markdown syntax (though it is possible to [include a markdown file](http://shiny.rstudio.com/reference/shiny/latest/include.html)'s content). Instead, you include content functions that produce HTML, the language that Markdown is converted to when you look at it in the browser. These functions include:

- `p()` for creating paragraphs, the same as plain text in Markdown
- `h1()`, `h2()`, `h3()` etc for creating headings, the same as `# Heading 1`, `## Heading 2`, `### Heading 3` in Markdown
- `em()` for creating _emphasized_ (italic) text, the same as `_text_` in Markdown
- `strong()` for creating **strong** (bolded) text, the same as `**text**` in Markdown
- `a(text, href='url')` for creating hyperlinks (anchors), the same as `[text](url)` in Markdown
- `img(text, src='url')` for including images, the same as `![text](url)` in Markdown

There are may other methods as well, see [this tutorial lesson](http://shiny.rstudio.com/tutorial/lesson2/) for a list. If you are [familiar with HTML](https://info343-au16.github.io/#/tutorials/html), then these methods will seem familiar; you can also write content in HTML directly using the `tag()` content function.

#### Control Widgets and Reactive Outputs
It is more common to include **control widgets** as content elements in your UI layout. Widgets are _dynamic_ (changing) control elements that the user can interact with. Each stores a **value** that the user has entered, whether by typing into a box, moving a slider, or checking a button. When the user changes their import, the stored _value_ automatically changes as well.

![Control widgets, from shiny.rstudio.com](img/basic-widgets.png)

Like other content elements, widgets are created by calling an appropriate function. For example:

- `textInput()` creates a box in which the user can enter text
- `sliderInput()` creates a slider
- `selectInput()` creates a dropdown menu the user can choose from
- `checkboxInput()` creates a box the user can check (using `checkboxGroupInput()` to group them)
- `radioButtons()` creates "radio" buttons (which the user can select only one of at a time)

See [the documentation](http://shiny.rstudio.com/reference/shiny/latest/), and [this tutorial lesson](http://shiny.rstudio.com/tutorial/lesson3/) for a complete list.

All widget functions take at least two arguments:

- A **name** (as a string) for the widget's value. This will be the **"key"** that will allow the server to be able to access the value the user has inputted.
- A **label** (a string or content element described above) that will be shown alongside the widget and tell the user what the value represents. Note that this can be an empty string (`""`) if you don't want to show anything.

Other arguments may be required by a particular widget, e.g., a slider's `min` and `max` values:

```r
# this function would be nested in a layout function (e.g., `fluidPage()`)
sliderInput('age',              # key this value will be assigned to
            "Age of subjects",  # label
            min = 18,           # minimum slider value
            max = 80,           # maximum slider value
            value = 42          # starting value
           )
```

Widgets are used to provide **inputs _to_** the Server; see the below section for how to use these inputs, as well as examples from [the gallery](http://shiny.rstudio.com/gallery/).

In order to diplay **outputs _from_** the Server, you include a **Reactive Output** element in your UI layout. These are elements similar to the basic content elements, but instead of just display _static_ (unchanging) content they can display _dynamic_ (changing) content outputted by the Server.

As with other content elements, reactive outputs are creating by calling an appropriate function. For example:

- `textOutput()` displays output as plain text (note this output can be nested in a content element for formatting)
- `tableOutput()` displays output as a data table (similar to `kable()` in R Markdown). See also `dataTableOutput()` for an interactive version!
- `plotOutput()` displays a graphical plot, such as one created with `ggplot2`

Each of these functions takes as an argument the **name** (as a string) of the value that will be displayed. This is the **"key"** that allows it to access the value the Server is outputting. Note that the functions may take additional arguments as well (e.g., to specify the size of a plot); see [the documentation](http://shiny.rstudio.com/reference/shiny/latest/) for details.


### The Server
The Server defines how the data inputted by the user will be used to create the output displayed by the app&mdash;that is, how the _control widgets_ and _reactive outputs_ will be connected. You create a Server by _defining a new function_ (not calling a provided one):

```r
server <- function(input, output){
  # assign values to `output` here
}
```

Note that this is _just a normal function_ that happens two take **lists** as arguments. That means you can include the same kinds of code as you normally would---though that code will only be run once (when the application is first started) unless defined as part of a reactive expression.

The first argument is a list of any values defined by the _control widgets_: each **name** in a control widget will be a **key** in this list. For example, using the above `sliderInput()` example would cause the list to have a `age` key (referenced as `input$age`). This allows the Server to access any data that the user has inputted, using the key names defined in the UI. Note that the values in this list _will change as the user interacts with the UI's control widgets_.

The purpose of the Server function is to assign new _values_ to the `output` argument list (each with an appropriate _key_). These values will then be displayed by the _reactive outputs_ defined in the UI. To make it so that the values can actually be displayed by by the UI, the values assigned to this list need to be the results of **Render Functions**. Similar to creating widgets or reactive outputs, different functions are associated with different types of output the server should produce. For example:

- `renderText()` will produce text (character strings) that can be displayed (i.e., by `textOutput()` in the UI)
- `renderTable()` will produce a table that can be displayed (i.e., by `tableOutput` in the UI)
- `renderPlot()` will produce a graphical plot that can be displayed (i.e., by `plotOutput()` in the UI)

Render functions take as an argument a **Reactive Expression**. This is a lot like a function: it is a **block** of code (in braces **`{}`**) that **returns** the value which should be rendered. For example:

```r
output$msg <- renderText({
  # code goes here, just like any other function
  my.greeting <- "Hello"

  # code should always draw upon a key from the `input` variable
  message <- paste(my.greeting, input$username)

  # return the variable that will be rendered
  return(message)
})
```

The only difference between a _reactive expression_ and a function is that you only include the _block_ (the braces and the code inside of them): you don't use the keyword `function` and don't specify a set of arguments.
- This technically defines a _closure_, which is a programming concept used to encapsulate functions and the context for those functions.

These _reactive expressions_ will be "re-run" **every time** one of the `input` values that it references changes. So if the user interacts with the `username` control widget (and thereby changes the value of the `input` list), the expression in the above `renderText()` will be executed again, returning a new value that will be assigned to `output$msg`. And since `output$msg` has now changed, any _reactive output_ in the UI (e.g., a `textOutput()`) will update to show the latest value. This makes the app interactive!

#### Multiple Views
It is quite common in a Shiny app to produce _lots_ of output variables, and thus to have multiple reactive expressions. For example:

```r
server <- function(input, output) {
  # render a histogram plot
  output$hist <- renderPlot({
    uniform.nums <- runif(input$num, 1, 10)  # random nums between 1 and 10
    return( hist(uniform.nums) )  # built-in plotting for simplicity
  })

  # render the counts
  output$counts <- renderPrint({
    uniform.nums <- runif(input$num, 1, 10)  # random nums between 1 and 10
    counts <- factor(cut(uniform.nums, breaks=1:10))  # factor
    return( summary(counts) )  # simple vector of counts
  })
}
```

If you look at the above example though, you'll notice that each render function produces a set of random numbers... which means each will produce a _different_ set of numbers! The histogram and the table won't match!

This is an example of where we want to share a single piece of data (a single **model**) between multiple different renditions (multiple **views**). Effectively, we want to define a shared variable (the `uniform.nums`) that can be referenced by both render functions. But since we need that shared variable to be able to _update_ whenever the `input` changes, we need to make it be a _reactive expression_ itself. We can do this by using the **`reactive()`** function:

```r
server <- function(input, output) {
  # define a reactive variable
  uniform.nums <- reactive({
    return( runif(input$num, 1, 10) )  # just like for a render function
  })

  # render a histogram plot
  output$hist <- renderPlot({
    return( hist(uniform.nums()) )  # call the reactive variable AS A FUNCTION
  })

  # render the counts
  output$counts <- renderPrint({
    counts <- factor(cut(uniform.nums(), breaks=1:10))  # call the reactive variable AS A FUNCTION
    return( summary(counts) )
  })
}
```

This lets us define a single "variable" that is a _reactive function_ that can be called from within the render functions. Importantly, the value returned by this function (the `uniform.nums()`) only changes **when a referenced `input` changes**. This as long as `input$num` stays the same, `uniform.nums()` will return the same value.

This is very powerful for allowing multiple **views** of a single piece of data: you can have a single source of data displayed both graphically and textually, both linked off of the same processed data table. Additionally, it can help keep your code more organized and readable, with avoid needing to duplicate any processing.


## Publishing Shiny Apps
Sharing a Shiny App with the world is a bit more involved than simply pushing the code to GitHub. We can't just use GitHub pages to host the code because, in addition to the HTML UI, we need an `R` interpreter session to run the Server that the UI can connect to (and GitHub does not provide R interpreters!)

While there are a few different ways of "hosting" Shiny Apps, in this class we'll use the simplest one: hosting through [**shinyapps.io**](https://www.shinyapps.io). shinyapps.io is a platform for hosting and running Shiny Apps; while large applications cost money, anyone can deploy a simple app (like the ones we'll create in this class) for free!

In order to host your app on shinyapps.io, you'll need to [create a free account](https://www.shinyapps.io/admin/#/signup). Note that you can sign up with GitHub or your Google (UW) account. Follow the site's instructions to

1. Select an account name (use something professional, like you used with the GitHub account!)
2. Install the required `rsconnect` package (may be included with RStudio)
3. Set your authorization token ("password"). Just click the green "Copy to Clipboard" button, and then paste that into the **Console** in RStudio. You should only need to do this once.
  - Don't worry about "Step 3 - Deploy"; we'll do that through RStudio directly!

After you've set up an account, you can _Run_ your application and hit the **Publish** button in the upper-right corner:

![shiny publish button](img/publish-app.png)

This will put your app online, available at

```
https://USERNAME.shinyapps.io/APPNAME/
```

**Important** Publishing to shinyapps.io is one of the major "pain points" in working with Shiny. For the best experience, be sure to

1. Always test and debug your app _locally_ (e.g., on your own computer, by running the App through RStudio). Make sure it works on your machine before you try to put it online.
2. Use correct folder structures and _relative paths_. All of your app should be in a single folder (usually named after the project). Make sure any `.csv` or `.R` files referenced are inside the app folder, and that you use relative paths to refer to them. Do not include any `setwd()` statements in your code; you should only set the working directory through RStudio (because shinyapps.io will have its own working directory).
3. It is possible to see [the logs for your deployed app](http://docs.rstudio.com/shinyapps.io/applications.html#logging), which may include errors explaining any problems that arise when you deploy your app.

For more options and details, see [the shinyapps.io documentation](http://docs.rstudio.com/shinyapps.io/index.html). And of course, if you get stuck, ask for help!
