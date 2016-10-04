# Shiny Web App
# Number of telephones by region and year

library(shiny)
library(datasets)

# Define UI for application, including sidebar and placeholder for barplot
ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("Number of telephones by region and year"),
  
  # Sidebar with checkboxes for region and year and dropdown selections 
  sidebarLayout(
    sidebarPanel(
     
       # Checkboxes
      checkboxInput("region_check", "Region", TRUE),
      checkboxInput("year_check", "Year", FALSE),
      
      # Dropdown options
      selectInput("region", "Region:", 
                  choices=colnames(WorldPhones)),
      selectInput("year", "Year:", 
                  choices=rownames(WorldPhones)),
      
      # Footer
      hr(),
      helpText("Data from AT&T (1961) The World's Telephones.")
    ),
    
    # Show generated barplot of the phones by region / year
    mainPanel(
      plotOutput("phonePlot")
    )
  )
))

# Define server logic required to draw barplot
server <- shinyServer(function(input, output) {
  
  output$phonePlot <- renderPlot({
    # Select data
    if (input$region_check) {plotdata <- WorldPhones[,input$region]}
    else if (input$year_check) {plotdata <- WorldPhones[input$year,]}
    else {plotdata <- WorldPhones[,input$region]}
    
    # Set title
    if (input$region_check) {plottitle <- input$region}
    else if (input$year_check) {plottitle <- input$year}
    else {plottitle <- input$region}
    
    # Set x axis label
    if (input$region_check) {xaxis <- 'Year'}
    else if (input$year_check) {xaxis <- 'Region'}
    else {xaxis <- 'Year'}
    
    # Draw bar graph
    barplot(plotdata, 
            col=c('blue'),
            main=plottitle,
            ylab='Number of Telephones (K)',
            xlab=xaxis)
  })
})

# Run the application 
shinyApp(ui = ui, server = server)

