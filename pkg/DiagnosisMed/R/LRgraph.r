LRgraph<-function(a=cbind(t1,t2),lwd=2,lty=1,cex=1,leg.cex=1.5,pt.cex=2){
  plot(1-a[[6,1]],a[[4,1]],xlim=c(0,1),ylim=c(0,1),xlab="False positive rate",ylab="True positive rate",col=1,cex=cex,lwd=lwd,lty=lty)
  abline(coef=c(0,((a[[4,1]])/(1-a[[6,1]]))),lwd=lwd)
  abline(coef=c(1-1*((1-a[[4,1]])/(1-(1-a[[6,1]]))),(1-a[[4,1]])/(1-(1-a[[6,1]]))),lwd=lwd)
  abline(v=1-a[[6,1]],lty=6,col="lightgray",lwd=lwd)
  abline(h=a[[4,1]],lty=6,col="lightgray",lwd=lwd)
  fill.col<-c(1)
  symbol<-c(1)
  for(i in 2:ncol(a))
        {
        points(1-a[[4,i]],a[[6,i]],col=i,pch=i,cex=cex,lwd=lwd,lty=lty)
        fill.col<-c(fill.col,i)
        symbol<-c(symbol,i)
        }
  legend("bottomright",legend=colnames(a),col=fill.col, pch=symbol, bty="n",cex=leg.cex,pt.cex=pt.cex,pt.lwd=lwd)
}  
