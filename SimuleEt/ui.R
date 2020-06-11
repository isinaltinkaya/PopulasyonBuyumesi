library(shiny)
library(markdown)
library(latex2exp)
library(shinythemes)

shinyUI(navbarPage(
  "Populasyon Büyümesi Simülasyonları",
  theme=shinytheme("yeti"),
  fluid = TRUE,
  tabPanel(
    "Üstel Büyüme Simülasyonu",
    sidebarLayout(
      sidebarPanel(
        helpText("Üstel Büyüme Simülasyonu Parametreleri"),

        sliderInput(
          "r1",
          label = c("Doğal artış kapasitesi (r)"),
          min = 0.01,
          max = 1,
          value = 0.3
        ),
        
        helpText("Doğal artış kapasitesi, Malthusian Parametresi ile ifade edilir."),
        br(),
        
        sliderInput(
          "N01",
          label = c("Başlangıç Populasyon Büyüklüğü (N0)"),
          min = 10,
          max = 100,
          value = 50
        ),
        
        sliderInput(
          "T1",
          label = c("Simülasyon Süresi (t, Nesil)"),
          min = 2,
          max = 20,
          value = 10
        ),
        
        helpText("Simülasyonlarda zaman, nesil ile ölçeklendirilmiştir."),
      ),
      
      mainPanel(
        plotOutput("sim1"),
        hr(),
        helpText(div(HTML("Populasyonlarda üstel (<em>geometrik, eksponansiyel</em>) büyümeyi türev kullanarak matematiksel olarak modelleyebiliriz.
                          Türev bize değişimi modelleme imkanı sunduğu için, N<sub>i</sub>'den N<sub>i+1</sub>'a yani nesiller arası populasyon büyümesini modellemek için türevi kullanabiliriz.
                         "))),
        uiOutput("f8"),
        helpText(div(HTML("r<sub>max</sub> değeri (<em>maksimum doğal artış kapasitesi, maximum per capita rate of increase</em>) 
                          pozitif bir değer olduğu sürece populasyonumuz üstel bir büyüme gösterecektir. Bu büyüme grafiklerde J şeklinde görüşmektedir.
                          r<sub>max</sub>, ideal şartlarda ve türe özgü bir değerdir. 
                          Bir tür için maksimum populasyon büyüme hızı biyotik potansiyel olarak adlandırılır."))),
        uiOutput("f1"),
        uiOutput("f4"),
        uiOutput("f2"),
        uiOutput("f3"),
        uiOutput("f5"),
        
        br(),
        hr(),
        helpText(h6(div(HTML("<em>Hazırlayan: Işın Altınkaya, Hacettepe Üniversitesi, Biyoloji Bölümü</em>")))),
      )
    )
  ),
  
  tabPanel(
    "Lojistik Büyüme Simülasyonu",
    sidebarLayout(
      sidebarPanel(
        helpText("Lojistik Büyüme Simülasyonu Parametreleri"),
        
        sliderInput(
          "r2",
          label = c("Doğal artış kapasitesi (r)"),
          min = 0.01,
          max = 1,
          value = 0.7
        ),
        helpText("Doğal artış kapasitesi, Malthusian Parametresi ile ifade edilir."),

        br(),
        
        sliderInput(
          "N02",
          label = c("Başlangıç Populasyon Büyüklüğü (N0)"),
          min = 10,
          max = 100,
          value = 50
        ),
        
        sliderInput(
          "T2",
          label = div(HTML("Simülasyon Süresi (t, Nesil)")),
          min = 2,
          max = 20,
          value = 10
        ),
        
        sliderInput(
          "K2",
          label = div(HTML("Taşıma Kapasitesi (K)")),
          min = 100,
          max = 500,
          value = 200
        ),
        helpText("Simülasyonlarda zaman, nesil ile ölçeklendirilmiştir."),
        
        
      ),
      
      mainPanel(plotOutput("sim2"),
                br(),
                helpText(div(HTML("Eğer başlangıçta az sayıda birey ve çok sayıda enerji kaynağı mevcutsa, üstel büyüme bir süre devam edebilir.
                                  Fakat bir noktadan sonra populasyon taşıma kapasitesine yaklaştıkça büyüme hızı düşer.
                                  Bu S şeklinde bir eğri oluşmasına neden olur."))),
                helpText(div(HTML("Populasyonlar maksimum büyüklüklerine (<em>Taşıma Kapasitesi, k</em>) yaklaştıkça r değeri küçülür.
                Lojistik büyüme gösteren bu değişimi şu şekilde modelleyebiliriz:"))),
                uiOutput("f9"),
                helpText(div(HTML("Buradaki K-N, populasyonun büyümesi esnasında herhangi bir zamanda populasyona taşıma kapasitesini geçmeyecek şekilde
                                  kaç yeni birey eklenebileceğini ifade etmektedir. O halde: "))),
                uiOutput("f10"),
                helpText(div(HTML("bu ifade de taşıma kapasitesinde kalan mevcut alanın (birey sayısı ölçeğinde) toplam taşıma kapasitesine oranını ifade eder.
                                  Taşıma kapasitesinin daha büyük bir kısmı kullanıldıkça bu değer büyüme hızının o derece azalmasına neden olacaktır."))),
                br(),
                helpText(div(HTML("Populasyon büyüklüğü oldukça düşük ve taşıma kapasitesi oldukça büyük olduğu zaman:"))),
                uiOutput("f11"),
                helpText(div(HTML("bu ifade K/K yani 1'e yakınsayacaktır. Bu durumda tekrar üstel büyüme ile karşı karşıya kalırız."))),
                
                br(),
                hr(),
                helpText(h6(div(HTML("<em>Hazırlayan: Işın Altınkaya, Hacettepe Üniversitesi, Biyoloji Bölümü</em>")))),
      )
    )
  ),
  
  tabPanel(
    "Stokastik Lojistik Büyüme Simülasyonu Parametreleri",
    sidebarLayout(
      sidebarPanel(
        
        helpText("Stokastik Lojistik Büyüme Simülasyonu Parametreleri"),

        sliderInput(
          "r3",
          label = c("Doğal artış kapasitesi (r)"),
          min = 0.01,
          max = 1,
          value = 0.7
        ),
        helpText("Doğal artış kapasitesi, Malthusian Parametresi ile ifade edilir."),
        br(),
        
        sliderInput(
          "s3",
          label = c("Standart sapma"),
          min = 0.01,
          max = 1,
          value = 0.3
        ),
      
        
        sliderInput(
          "N03",
          label = c("Başlangıç Populasyon Büyüklüğü (N0)"),
          min = 10,
          max = 100,
          value = 50
        ),
        
        sliderInput(
          "T3",
          label = div(HTML("Simülasyon Süresi (t, Nesil)")),
          min = 2,
          max = 20,
          value = 10
        ),
        
        sliderInput(
          "K3",
          label = div(HTML("Taşıma Kapasitesi (K)")),
          min = 100,
          max = 500,
          value = 200
        ),
        helpText("Simülasyonlarda zaman, nesil ile ölçeklendirilmiştir."),
        
      ),
      
      
      
      
      mainPanel(plotOutput("sim3"),
                br(),
                helpText(div(HTML("Şimdi de daha gerçekçi bir simülasyon yapmaya çalışalım. Bunu yaparken bir normal dağılımdan, belirlediğimiz standart sapmayı ve belirlediğimiz r değerini ortalama olarak alarak kullanabiliriz.
                         "))),
                
                br(),
                hr(),
                helpText(h6(div(HTML("<em>Hazırlayan: Işın Altınkaya, Hacettepe Üniversitesi, Biyoloji Bölümü</em>")))),
      )
    )
  )
  
  
  
))