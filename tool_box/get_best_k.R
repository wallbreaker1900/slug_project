# Description: calculate the best K

library(stringr)

#read in the data

data<-list.files("/more_storage/jill/alignment_updated_ngs", pattern = ".log", full.names = T)

#look at data to make sure it only has the log files

data

#use lapply to read in all our log files at once
bigData<-lapply(1:40, FUN = function(i) readLines(data[i]))


#this will pull out the line that starts with "b" from each file and return it as a list
foundset<-sapply(1:40, FUN= function(x) bigData[[x]][which(str_sub(bigData[[x]], 1, 1) == 'b')])

foundset

#we're getting there!

#now we need to pull out the first number in the string, we'll do this with the function sub

as.numeric( sub("\\D*(\\d+).*", "\\1", foundset) )

#now lets store it in a dataframe
#make a dataframe with an index 1:7, this corresponds to our K values
logs<-data.frame(K = rep(1:8, each=5))

#add to it our likelihood values

logs$like<-as.vector(as.numeric( sub("\\D*(\\d+).*", "\\1", foundset) ))

#and now we can calculate our delta K and probability

tapply(logs$like, logs$K, FUN= function(x) mean(abs(x))/sd(abs(x)))