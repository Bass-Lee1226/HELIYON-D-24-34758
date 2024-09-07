#install.packages("ggpubr")


library(reshape2)
library(ggpubr)
inputFile="input.txt"     
outFile="boxplot.pdf"     
setwd("F:\\BaiduNetdiskDownload\\08.boxplotMulti")    

rt=read.table(inputFile,sep="\t",header=T,check.names=F,row.names=1)
x=colnames(rt)[1]
colnames(rt)[1]="Type"

data=melt(rt,id.vars=c("Type"))
colnames(data)=c("Type","Gene","Expression")

p=ggboxplot(data, x="Gene", y="Expression", fill = "Type", 
	     ylab="Fraction",
	     xlab="",
	     legend.title=x,
		 width=0.6,
	     palette = c("#FF0000","#0066FF"),)
p=p+rotate_x_text(50)
p1=p+stat_compare_means(aes(group=Type),
	      method="wilcox.test",
	      symnum.args=list(cutpoints = c(0, 0.001, 0.01, 0.05, 1), symbols = c("***", "**", "*", " ")),
	      label = "p.signif")

pdf(file=outFile, width=6, height=5)
print(p1)
dev.off()