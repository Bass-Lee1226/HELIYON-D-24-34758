
#install.packages("survival")
#install.packages("survminer")



library(survival)
library(survminer)
inputFile="input.txt"        
outFile="survival.pdf"      
var="GBP7"                  
setwd("F:\\BaiduNetdiskDownload\\04.survivalCutoff")     


rt=read.table(inputFile, header=T, sep="\t", check.names=F)
rt=rt[,c("futime","fustat",var)]
colnames(rt)=c("futime","fustat","var")

res.cut=surv_cutpoint(rt, time = "futime", event = "fustat",variables =c("var"))
res.cut
res.cat=surv_categorize(res.cut)
fit=survfit(Surv(futime, fustat) ~var, data = res.cat)

diff=survdiff(Surv(futime, fustat) ~var,data =res.cat)
pValue=1-pchisq(diff$chisq,df=1)
if(pValue<0.001){
	pValue="p<0.001"
}else{
	pValue=paste0("p=",sprintf("%.03f",pValue))
}

surPlot=ggsurvplot(fit, 
		           data=res.cat,
		           conf.int=F,
		           pval=pValue,
		           pval.size=6,
		           legend.labs=c("High", "Low"),
		           legend.title=var,
		           xlab="Time(years)",
				   ylab="Progression-free survival",
				   palette=c("red2", "blue"),
		           break.time.by = 1,
		           risk.table.title="Number at risk",
		           risk.table=T,
		           risk.table.height=.25)
pdf(file=outFile,onefile = FALSE,width =5,height =5)
print(surPlot)
dev.off()
