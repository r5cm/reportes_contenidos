library(treemap)

# itreemap: Interactive user interface for treemap
data(business)
itreemap(business)

# treecolors: Interactive tool to experiment with Tree Colors
treecolors()

# treegraph Create a tree graph
treegraph(business, index=c("NACE1", "NACE2", "NACE3", "NACE4"), show.labels=FALSE)

treegraph(business[business$NACE1=="F - Construction",],
          index=c("NACE2", "NACE3", "NACE4"), show.labels=TRUE, truncate.labels=c(2,4,6))

# treemap: Create a treemap
data(GNI2014)
treemap(GNI2014,
        index=c("continent", "iso3"),
        vSize="population",
        vColor="GNI",
        type="value",
        format.legend = list(scientific = FALSE, big.mark = " "))
