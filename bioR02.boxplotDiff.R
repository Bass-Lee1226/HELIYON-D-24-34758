#install.packages("ggpubr")


library(ggpubr)            
inputFile="input.txt"      
outFile="boxplot.pdf"      
setwd("F:\\BaiduNetdiskDownload\\02.boxplotDiff")    

rt=read.table(inputFile,sep="\t",header=T,check.names=F)
x=colnames(rt)[2]
y=colnames(rt)[3]
colnames(rt)=c("id","Type","Expression")

group=levels(factor(rt$Type))
rt$Type=factor(rt$Type, levels=group)
comp=combn(group,2)
my_comparisons=list()
for(i in 1:ncol(comp)){my_comparisons[[i]]<-comp[,i]}

boxplot=ggboxplot(rt, x="Type", y="Expression", fill="Type",
		          xlab=x,
		          ylab=y,
		          legend.title=x,
				  width=0.6,
		          palette = c("#FF0000","#0066FF"),
		          add = "none")+ 
	    stat_compare_means(comparisons = my_comparisons)

pdf(file=outFile,width=4,height=5)
print(boxplot)
dev.off()
