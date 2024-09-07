#install.packages("corrplot")


library(corrplot)           
inputFile="input.txt"       
setwd("F:\\BaiduNetdiskDownload\\03.corrplot") 

rt=read.table(inputFile,sep="\t",header=T,row.names=1)      
rt=t(rt)      
M=cor(rt)     

pdf(file="corpot1.pdf",width=12,height=12)
corrplot(M,
         method = "circle", 
         order = "hclust", 
         type = "upper",
         number.cex = 1.2,
         addCoef.col = "black",
         diag = TRUE,
         col=colorRampPalette(c("blue", "white", "red"))(50)
         )
dev.off()

pdf(file="corpot2.pdf",width=12,height=12)
corrplot(M,
         order="original",
         method = "color",
         number.cex = 0.7, 
         addCoef.col = "black",
         diag = TRUE,
         tl.col="black",
         col=colorRampPalette(c("blue", "white", "red"))(50))
dev.off()
