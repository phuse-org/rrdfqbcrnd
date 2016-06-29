###############################################################################
# FILE : .../PhUSE/ARM/R/StructApp/app.R
# DESCR: Plot the indivdual subgraphs for use in the Tech Spec documentation
#        --Full Graph-- can be used as the graph in the Appendix.
# SRC  : 
# KEYS : 
# NOTES: Unlike the pure D3 version, the RShiny App  does not  positioni the nodes
#          and Unique node names are used instead of generating unique numeric 
#          ID values to connect nodes.
#        Code is sloppy, but documented. Has warnings. No warranty implied.
# INPUT:  CubeStructureMetaData.xlsx , in same folder as the App.
#      : 
# OUT  : 
# REQ  : 
# ToDO : Fix warnings:
#        1. "attributes are not identical across measure variables; they will be dropped"
#        2. from IF on the input$subGraphSelector upon initialization
#         
###############################################################################
library(plyr) 
library(reshape2)
library(visNetwork)
library(xlsx)
library(shiny)
library(shinythemes)

CubeStructureMetaDataFn<- system.file("extdata/spec-xls","CubeStructureMetaData.xlsx", package="rrdfqbspec")
cat("Reading specifications from ", normalizePath(CubeStructureMetaDataFn))

#------------------------------------------------------------------------------
# Nodes
#------------------------------------------------------------------------------
nodes <- read.xlsx(CubeStructureMetaDataFn,sheetName="Nodes") 

# Determine if duplicate node identifiers
#  Run this commented-out code whenever the spreadsheet is updated.
    # index <- duplicated(nodeList$node)
    # nodeList[index,]

# Remove duplicates before assigning unique ID number
nodes <- nodes[!duplicated(nodes$node),] 

# Recode the colors from colour group ID to hex color values.
nodes$color[nodes$nodeColor == "1"] <- "#FFFF00" # Yellow
nodes$color[nodes$nodeColor == "2"] <- "#989898" # Grey
nodes$color[nodes$nodeColor == "3"] <- "#FFFFFF" # White
nodes$color[nodes$nodeColor == "4"] <- "#377eb8" # Blue
nodes$color[nodes$nodeColor == "5"] <- "#006600" # Green
nodes$color[nodes$nodeColor == "6"] <- "#e41a1c" # Red
nodes$color[nodes$nodeColor == "7"] <- "#ff9933" # Orange  

# dot  = regular node
# star = links to other subgraphs in the display
# box  = center node of a subgraph. Is a selection in the drop down. Used to 
#        indicate subgraphs in the --Full Model-- graph 
nodes$shape[nodes$toOtherSubgraph == 0] <- "dot" # nodes$shape <- "dot"
nodes$shape[nodes$toOtherSubgraph == 1] <- "star" # 
nodes$shape[nodes$toOtherSubgraph == 2] <- "box" # Not used. Obscures parts of graph.

nodes$id <-nodes$node  # Rename as needed for the graph  
nodes$size <- 5 # Node sizes = all the same
nodes$label <- nodes$nodeLabel  # Or change this to a rename

#------------------------------------------------------------------------------
# Edges
#------------------------------------------------------------------------------
edges <- read.xlsx(CubeStructureMetaDataFn,sheetName="Edges") 


# Remove cases where graphName is NA
# Keep on only the cases where roleN is not NA. Consider use of another variable
naIndex <- complete.cases(edges[,"graphName"]) 
edges <- edges[naIndex, ]

# Rename for visNetwork
edges <- rename(edges, c("s" = "from", "o" = "to"))

# Set the line type for edges by recoding 'necessity' value
# If necessity is Optional, dashes=TRUe, else dashes=FALSE. Change to ifelse?
edges$dashes = FALSE
edges$dashes[edges$necessity == 'Optional'] <- TRUE

# Label for edges 
edges$label <- edges$p
# Add arrows to the TO destination node for each edge.
# Other graphs will be  more complex.
edges$arrows <- paste("to")
edges$width <- 2
# Edge label values
edges$align <- paste("top")

# List of subgraph names to use in the drop down selector
subGraphs <- sort(unique(as.character(edges$graphName))) 
subGraphs <- c(subGraphs, "--Full Model--")  # Add choice to include all nodes and edges

#------------------------------------------------------------------------------
# UI 
#
#------------------------------------------------------------------------------
ui <- fluidPage(theme = shinytheme("Spacelab"),
    fluidRow(
        column(12,
            h3("PhUSE AR&M RDF Data Cube Model"),
            p("Select a sub-graph from the RDF Data Cube model. Detailed descriptions 
            available in the Technical Specification document."),
            uiOutput("subGraphSelector")
        ) # End column
    ), # End fluidRow
    fluidRow(
        column(12,
            tabsetPanel(
                tabPanel("Graph", visNetworkOutput("fnPlot",
                                                   width = "100%",
                                                   height = "700px")),
                tabPanel("Edges", dataTableOutput("edgesTable")),
                tabPanel("Nodes", dataTableOutput("nodesTable"))
            ) # End tabsetPanel
        ) # End column
    ) # End fluidRow
) # End fluidPage

#------------------------------------------------------------------------------
# SERVER 
# 
#------------------------------------------------------------------------------
server <- function(input, output) {

    # Build drop-down selector based on values in the subGraph list
    output$subGraphSelector <- renderUI({
        selectInput("subGraphSelector",
                    label = h4("Sub Graph"),
                    c(Choose ='', subGraphs),
                    selectize = FALSE)
    })

    # Subset the edges dataset based on the graphName selected
    edgesSub <- reactive({
            input$subGraphSelector
            if(input$subGraphSelector == "--Full Model--"){
                edgesSub <- edges
            }
            else
            {
                edgesSub <- subset(edges, graphName == input$subGraphSelector)    
            }
    })

    nodesSub <- reactive({
        input$subGraphSelector
        if(input$subGraphSelector =="--Full Model--"){
            edgesSub <- edges
        }
        else
        {
            edgesSub <- subset(edges, graphName == input$subGraphSelector)
        }
        
        edgeNodes <- edgesSub[,c("graphName", "from","to")]  # Keep graphName as an IDVar
        # Use the edgesSub to select only those nodes that are in edgesSub
        # Get the lists of all the nodes in edgesSub (both source and target nodes)
        edgeNodes <- melt(edgeNodes, id.vars = "graphName")
        # Remove duplicate node values (from repeats of the source node)
        edgeNodes <- edgeNodes[!duplicated(edgeNodes$value),]
        # edgeNodes$value is the list of node names in edgesSub
        selRows <- nodes$node %in% edgeNodes$value  # index of the matching rows
        nodesSub <- nodes[selRows,] # subset to only those that match
    })

    output$edgesTable <- renderDataTable({
        edgesSub()
    }, options = list (pageLength = 20))

    output$nodesTable <- renderDataTable({
        nodesSub()
    }, options = list (pageLength = 20))
   
    output$fnPlot <- renderVisNetwork({
        edges <- edgesSub()
        nodes <- nodesSub()
        # Arrows only on the "to" node
        visNetwork(nodes, edges, 
                   width = "100%",
                   height = "200")  %>%
        visEdges(font = list(size = 16, face = 'sans-serif', color = "darkblue", align = "top"),
                 arrows = list(to = list(enabled = TRUE, scaleFactor = 0.5)),
                 color = "#ccc",
                 length = 250
        ) %>%
        visNodes( font = list(size = 16, face = 'sans-serif', color = "black", background = "white"),
                  fixed = FALSE
                  
                  )
    })
}
shinyApp(ui = ui, server = server)
