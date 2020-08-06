#문제1
mid = ggplot2::midwest

mid = mid %>% 
  mutate(ra_child = (poptotal-popadults)/poptotal*100)

colnames(mid)

View(mid)


#문제2
mid %>% 
  arrange(desc(ra_child)) %>% 
  select(county, ra_child) %>% 
  head(5)


#문제3
mid = mid %>% 
  mutate(class=ifelse(ra_child>=40,"large",
                      ifelse(ra_child<30,"small","middle")))

table(mid$class)


#문제4
mid %>% 
  mutate(ra_asian = popasian/poptotal*100) %>%
  arrange(ra_asian) %>%
  select(state, county, ra_asian) %>% 
  head(10)
