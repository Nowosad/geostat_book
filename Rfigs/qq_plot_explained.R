positive_part <- function(x) {ifelse(x > 0, x, 0)}

random_sample <- function(n, mu = 0, skewness = 0, tailedness = 0){
        sigma = 1
        reject_skewness <- function(x){
                scale = 1
                # if `skewness` > 0 (means data are right-skewed), then small values of x will be rejected
                # with higher probability.
                l <- exp(-scale * skewness * x)
                l/(1 + l)
        }
        
        reject_tailedness <- function(x){
                scale = 1
                # if `tailedness` < 0 (means data are lightly-tailed), then big values of x will be rejected with
                # higher probability.
                l <- exp(-scale * tailedness * abs(x))
                l/(1 + l)
        }
        
        w = positive_part((1 - exp(-0.5 * tailedness)))/(1 + exp(-0.5 * tailedness))
        
        filter <- function(x){
                accept <- runif(length(x)) > reject_tailedness(x) * reject_skewness(x)
                x[accept]
        }
        
        result <- filter(mu + sigma * ((1 - w) * rnorm(n) + w * rt(n, 5)))
        while (length(result) < n) {
                result <- c(result, filter(mu + sigma * ((1 - w) * rnorm(n) + w * rt(n, 5))))
        }
        result[1:n]
}

multimodal <- function(n, Mu, skewness = 0, tailedness = 0) {
        # Deal with the bimodal case.
        mumu <- as.numeric(Mu %*% rmultinom(n, 1, rep(1, length(Mu))))
        mumu + random_sample(n, skewness = skewness, tailedness = tailedness)
}

# if (input$modality == "Unimodal") {
# mu = 0
# # For `Bimodal` choice, we fix the two modes at -2 and 2.
# mu = c(-2, 2)

set.seed(1215)
n=1000
scale = 1000

sample1 <- multimodal(n, 0, skewness = scale * 0, tailedness = scale * 0)
normalny <- data.frame(values = sample1, type='normalny')

sample1 <- multimodal(n, c(-2, 2), skewness = scale * 0, tailedness = scale * 0)
bimodalny <- data.frame(values = sample1, type='bimodalny')

sample1 <- multimodal(n, 0, skewness = scale * 0, tailedness = scale * -1)
light_tailed <- data.frame(values = sample1, type='krótki ogon')

sample1 <- multimodal(n, 0, skewness = scale * 0, tailedness = scale * 1)
high_tailed <- data.frame(values = sample1, type='długi ogon')

sample1 <- multimodal(n, 0, skewness = scale * -0.7, tailedness = scale * 0.7)
lewoskośny <- data.frame(values = sample1, type='lewoskośny')

sample1 <- multimodal(n, 0, skewness = scale * 0.7, tailedness = scale * 0.7)
prawoskośny <- data.frame(values = sample1, type='prawoskośny')

df <- rbind(normalny, bimodalny, light_tailed, high_tailed, lewoskośny, prawoskośny)

library('ggplot2')
p <- ggplot(df, aes(sample=values)) + 
        stat_qq(size=0.2) +
        facet_wrap(~type, ncol=2) +
        ggtitle('Interpretacja wykresu kwantyl-kwantyl') +
        theme_bw() +
        theme(axis.title=element_blank(), axis.text=element_blank())

ggsave(p, file='figs/qq_plot_explained.png', scale=0.8)
