install.packages('rsconnect')

rsconnect::setAccountInfo(name='simran18',
                          token='7352609C3A5351CE32EA176107705050',
                          secret='MTowc7XM8asb9q7blGCv+o/YRbGSrahtzQl63+4U')
library(rsconnect)
rsconnect::deployApp('exercise-2/app')

