library('grid')
library('ggplot2')
library('wesanderson')

mean <-  0
sd <-  1

limits <-  c(mean - 3 * sd, mean + 3 * sd)
areax <- seq(limits[1], limits[2], length.out = 100)
area <- data.frame(x = areax, ymin = 0, ymax = dnorm(areax, mean = mean, sd = sd))

limits2 <-  c(mean - 2 * sd, mean + 2 * sd)
areax2 <- seq(limits2[1], limits2[2], length.out = 100)
area2 <- data.frame(x = areax2, ymin = 0, ymax = dnorm(areax2, mean = mean, sd = sd))

limits1 <-  c(mean - 1 * sd, mean + 1 * sd)
areax1 <- seq(limits1[1], limits1[2], length.out = 100)
area1 <- data.frame(x = areax1, ymin = 0, ymax = dnorm(areax1, mean = mean, sd = sd))

colors <- wes_palette('Royal1', n=5, type='continuous')

p1 <- ggplot() +
        geom_line(data.frame(x = areax, y = dnorm(areax, mean = mean, sd = sd)),
                    mapping = aes(x = x, y = y)) +
        geom_ribbon(data = area, mapping = aes(x = x, ymin = ymin, ymax = ymax), fill=colors[4]) +
        geom_ribbon(data = area2, mapping = aes(x = x, ymin = ymin, ymax = ymax), fill=colors[3]) +
        geom_ribbon(data = area1, mapping = aes(x = x, ymin = ymin, ymax = ymax), fill=colors[2]) +
        geom_segment(aes(x=-3, xend=3, y=0.05, yend=0.05), 
                     arrow=arrow(length=unit(0.3,"cm"), ends='both')) + 
        geom_segment(aes(x=-2, xend=2, y=0.125, yend=0.125), 
                     arrow=arrow(length=unit(0.3,"cm"), ends='both')) + 
        geom_segment(aes(x=-1, xend=1, y=0.2, yend=0.2), 
                     arrow=arrow(length=unit(0.3,"cm"), ends='both')) + 
        geom_text(aes(x=0, y=0.21, label='68%')) +
        geom_text(aes(x=0, y=0.135, label='95%')) +
        geom_text(aes(x=0, y=0.06, label='99.7%')) +
        scale_x_continuous(limits = limits, breaks=c(-3,-2,-1,0,1,2,3), 
                           labels=c(labels = c('-3' = expression(-3*sigma),'-2' = expression(-2*sigma),
                                               '-1' = expression(-1*sigma),'0' = expression(0),
                                               '1' = expression(1*sigma),'2' = expression(2*sigma),
                                               '3' = expression(3*sigma)))) +
        scale_y_continuous(expand = c(0, 0)) +
        theme_classic() +
        theme(axis.text.y=element_blank(), axis.title=element_blank(),
              axis.ticks.y=element_blank())

ggsave(p1, file='figs/normal_distribution.png')
