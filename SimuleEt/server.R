library(shiny)
library(ggplot2)
library(scales)

shinyServer(function(input, output, session) {
  
  output$sim1 <- renderPlot({
    
    # Populasyon Buyumesi Simulasyonu
    
    # Simulasyon 1
    # Basit Üstel (Geometrik) Büyüme Simülasyonu
    
    # Baslangic populasyon buyuklugu
    N0=input$N01
    # Populasyon buyume hizi
    # =Dogal artis kapasitesi
    # =Malthusian parametresi
    r=input$r1
    # T = Simulasyon suresi
    T=input$T1
    t=0:T
    N=N0*exp(r*t)
    df=data.frame(t=t,N=N)
    p1 = ggplot(data = df, aes(t, N)) + 
      geom_line() +
      theme_classic()+
      ggtitle("Populasyonlarda Üstel Büyüme")+
      theme(axis.text.x = element_text(size=12),
           axis.text.y = element_text(size=12),
           axis.title.x = element_text(size=15),
           axis.title.y = element_text(size=15),
           plot.title = element_text(size=20, 
                                     face="bold", 
                                     margin = margin(10, 0, 10, 0),
                                     hjust=0.5
                                     ),
           plot.margin = unit(c(0, 8, 0, 4), "cm")
           )+
      scale_x_continuous(name="Nesil", breaks=pretty_breaks(),
                         expand = c(0, 0)) +
      scale_y_continuous(name="Populasyon Büyüklüğü", 
                         breaks=pretty_breaks())
      print(p1)
  })

  output$sim2 <- renderPlot({
    
    # Simulasyon 2
    # Basit Lojistik Büyüme Simülasyonu
    # Baslangic populasyon buyuklugu
    N0=input$N02
    # Populasyon buyume hizi
    # =Dogal artis kapasitesi
    # =Malthusian parametresi
    r=input$r2
    # T = Simulasyon suresi
    T=input$T2
    K=input$K2
    C=K/N0-1
    t=0:T
    N=K/(1+C*exp(-r*t))
    df=data.frame(t=t,N=N)
    p2 = ggplot(data = df, aes(t, N)) + 
      geom_line() +
      theme_classic()+
      ggtitle("Populasyonlarda Lojistik Büyüme")+
      theme(axis.text.x = element_text(size=12),
            axis.text.y = element_text(size=12),
            axis.title.x = element_text(size=15),
            axis.title.y = element_text(size=15),
            plot.title = element_text(size=20, 
                                      face="bold", 
                                      margin = margin(10, 0, 10, 0),
                                      hjust=0.5),
            plot.margin = unit(c(0, 8, 0, 4), "cm")
            )+
      scale_x_continuous(name="Nesil", breaks=pretty_breaks(),
                         expand = c(0, 0))+
      scale_y_continuous(name="Populasyon Büyüklüğü", breaks=pretty_breaks())+
      geom_hline(yintercept=K, linetype="dashed", color="red")+
      annotate("text", -Inf, Inf, label = "Taşıma Kapasitesi (K)", hjust = -0.5, vjust = 1, color="red", size=5)
    
    print(p2)
    
  })
  
  output$sim3 <- renderPlot({
    
    # Simulasyon 3
    # Baslangic populasyon buyuklugu
    N0=input$N03
    # Populasyon buyume hizi
    # =Dogal artis kapasitesi
    # =Malthusian parametresi
    rmax.mean=input$r3
    # T = Simulasyon suresi
    T=input$T3
    K=input$K3
    C=K/N0-1
    t=0:T
    # Stokastiklik ekleyelim
    rmax.sd=input$s3
    rmax=rnorm(T,rmax.mean,rmax.sd)
    t=N=array(dim=T+1)
    N[1]=N0
    t[1]=0
    for (i in 1:T){
      N[i+1]<-N[i]+rmax[i]*N[i]*(1-N[i]/K)
      t[i+1]=t[i]+1
    }
    df = data.frame(t=t,N=N)

    p3 = ggplot(data = df, aes(t,N)) + 
      geom_line() +
      theme_classic()+
      ggtitle("Populasyonlarda Stokastik Lojistik Büyüme")+
      theme(axis.text.x = element_text(size=12),
            axis.text.y = element_text(size=12),
            axis.title.x = element_text(size=15),
            axis.title.y = element_text(size=15),
            plot.title = element_text(size=20, 
                                      face="bold", 
                                      margin = margin(10, 0, 10, 0),
                                      hjust=0.5),
            plot.margin = unit(c(0, 8, 0, 4), "cm")
      )+
      scale_x_continuous(name="Nesil", breaks=pretty_breaks(),
                         expand = c(0, 0))+
      scale_y_continuous(name="Populasyon Büyüklüğü", breaks=pretty_breaks())+
      geom_hline(yintercept=K, linetype="dashed", color="red")+
      annotate("text", -Inf, Inf, label = "Taşıma Kapasitesi (K)", hjust = -0.5, vjust = 1, color="red", size=5)
  
    print(p3)
    
  })
  
  # Denklemler
  output$f1 <- renderUI({
    withMathJax(
      helpText('$$ N(T) = 2^t \\cdot 
               N(0)$$'))
  })
  
  output$f2 <- renderUI({
    withMathJax(
      helpText('$$ N(T) = R^t \\cdot 
               N(0)$$'))
  })
  
  output$f3 <- renderUI({
    withMathJax(
      helpText('$$ N(T) = N(0) \\cdot 
               e^{rt}$$'))
  })
  
  output$f4 <- renderUI({
    withMathJax(
      helpText('$$ N(T) = N(0) \\cdot 
               e^{r} $$'))
  })
  
  output$f5 <- renderUI({
    withMathJax(
      helpText('$$ ln(N(T)) = rt $$'))
  })
  
  output$f7 <- renderUI({
    withMathJax(
      helpText('$$ \\frac{dN}{dt} = rN $$'))
  })
  
  output$f8 <- renderUI({
    withMathJax(
      helpText('$$ \\frac{dN}{dt} = r_{max}N $$'))
  })
  
  output$f9 <- renderUI({
    withMathJax(
      helpText('$$ \\frac{dN}{dt} = r_{max}(\\frac{K-N}{K})N $$'))
  })
  
  output$f10 <- renderUI({
    withMathJax(
      helpText('$$ \\frac{K-N}{K} $$'))
  })
  
  output$f11 <- renderUI({
    withMathJax(
      helpText('$$ \\frac{K-N}{K} \\approx  \\frac{K}{K}$$'))
  })
  
})