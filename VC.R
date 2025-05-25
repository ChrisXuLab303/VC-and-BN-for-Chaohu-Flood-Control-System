#Load
library(VineCopula)
library(kdecopula)
library(shiny)
library(network)
library(readxl)
library(openxlsx)
library(rio)

#
data = read_excel("C:\\1.基于copula与贝叶斯网络的水库-湖泊系统防洪风险快速推演模型\\4-边缘分布拟合结果.xlsx",range = "A1:E51")
RCModel = RVineStructureSelect(data, family=c(1:10,13,14,16:20,23,24,26:30,33,34,36:40,104,114,124,134,204,214,224,234), selectioncrit="AIC", progress=FALSE, se=TRUE, method='mle', rotations=TRUE)
print(RCModel)
plot(RCModel)
contour(RCModel)

#
simdata = RVineSim(25000,RCModel, U = NULL)
df = data.frame(simdata)
colnames(df) = c("Wlhk", "Wdp", "Wdfy","Wlake","Z")
export(df,file = "C:\\1.基于copula与贝叶斯网络的水库-湖泊系统防洪风险快速推演模型\\6-RCM抽样结果.xlsx")
