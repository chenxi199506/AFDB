library(shiny)
library(shinydashboard)
library(reactable)
library(ggplot2)
library(ggvis)
library(r3dmol)

library(shiny)
library(r3dmol)
library(colourpicker)
library(bio3d)
drugs <- readRDS("www/smallmol.rds")
drugnames <- names(drugs)
dn <- list()
for(i in 1:length(drugnames)){dn[[i]] <- drugnames[i]}
names(dn) <-names(drugs)

# library(ggiraph)
# install.packages("ggvis")
shinyUI(dashboardPage(
  ## 指定主题色
  skin = "blue",
  ## 指定应用名称
  dashboardHeader(title = "AFDB v1.0"),
  ## 指定页面菜单栏内容
  dashboardSidebar(
    sidebarMenu(
      ## 添加的菜单栏
      menuItem("Home Page", tabName = "dashboard", icon = icon("home")),
      menuItem("DEG Exploration", tabName = "widgets", icon = icon("th")),
      menuItem("Database Searching", tabName = "charts",icon = icon("search")),
      menuItem("Candidate Drugs", tabName = "about",icon = icon("dashboard"))
    )
  ),
  ## Body content
  dashboardBody(
    tabItems(

      #第一个菜单栏的页面内容
      tabItem(tabName = "dashboard",
              h1("Welcome to Arthrofibrosis database (AFDB)"),
              p('AFDB aims to provide integrated clincal and sequencing data for arthrofibrosis'),
              #在dashboard的tab栏加入应用程序www文件夹中的图片
               div(img(src="fig1.png",height = 1000,width=790)),
              # img(src="www/fig1.png" ),
              # p('药物基因组学基因功能学与分子药理学的有机结合******。
              #         我们致力于归纳总结这些药物基因组学的研究成果，为用药者提供重要的研究信息，提供用药指导。'),
              #div("图片来自："),
              #a("web",href="https://www.google.com/")

      ),

      # 第二个菜单栏的页面内容
      tabItem(tabName = "widgets",
              h1("Differential expressed genes database"),
              reactableOutput("table2")
      ),

      # 第三个菜单栏内容
      tabItem(tabName = "charts",
              h1("Fibrosis-related genes database"),
              reactableOutput("table")
      ),
      # 第四个菜单栏内容
      tabItem(tabName = "about",
              h1("Candidate Drug"),
            
              fluidRow(
                column(
                  width = 4,
                  wellPanel(
                    uiOutput(outputId = "select_panel"),
                    actionButton(
                      inputId = "zoom_in",
                      label = "Zoom in",
                      icon = icon("plus")
                    ),
                    actionButton(
                      inputId = "zoom_out",
                      label = "Zoom out",
                      icon = icon("minus")
                    ),
                    actionButton(
                      inputId = "spin",
                      label = "Spin",
                      icon = icon("sync-alt")
                    ),
                    actionButton(
                      inputId = "clear",
                      label = "Clear",
                      icon = icon("trash-alt")
                    )
                  )
                ),
                column(
                  width = 8,
                  column(
                    width = 12,
                    selectizeInput(
                      inputId = "select_single_model",
                      label = "Select Model",
                      choices = dn,
                    )
                  ),
                  r3dmolOutput(outputId = "r3dmol", height = "700px")
                ),
               
                
              )
              
              
              
      )
    )
  )
)
)
