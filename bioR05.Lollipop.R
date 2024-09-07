#install.packages("ggpubr")

library(ggpubr)            
inputFile="input.txt"       
outFile="Lollipop.pdf"     
setwd("F:\\BaiduNetdiskDownload\\05.Lollipop")     
rt=read.table(inputFile,header=T,sep="\t",check.names=F)   

pdf(file=outFile,width=10,height=4.5)
ggdotchart(rt, x="Term", y="Count", color = "ONTOLOGY",group = "ONTOLOGY", 
          palette = "aaas",     
          legend = "right",     
          sorting = "descending",   
          add = "segments",    
          rotate = TRUE,       
          dot.size = 8,        
          label = round(rt$Count),  
          font.label = list(color="white",size=15, vjust=0.5),   
          ggtheme = theme_pubr())
dev.off()